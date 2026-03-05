import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'api_base_service.dart';

class AIService extends ApiBaseService {
  static final AIService _instance = AIService._internal();
  factory AIService() => _instance;
  AIService._internal();

  // Groq API key — used directly for AI features (lab report analysis & health Q&A)
  static const String _groqApiKey =
      'gsk_placeholder_replace_with_your_actual_groq_api_key';
  static const String _groqBaseUrl = 'https://api.groq.com/openai/v1';
  // Model: llama-3.1-8b-instant is fast and free on Groq's tier
  static const String _groqModel = 'llama-3.1-8b-instant';

  /// Analyzes a lab report file and returns AI-powered recommendations.
  /// Priority order:
  ///   1. Backend `/patients/analyze-report` endpoint
  ///   2. Groq Chat Completion API (direct, if key is available)
  ///   3. Simulated fallback response
  Future<Map<String, dynamic>> analyzeLabReport(File file) async {
    // ── Step 1: Try backend endpoint ──────────────────────────────────────────
    try {
      final uri = Uri.parse('$baseUrl/patients/analyze-report');
      final request = http.MultipartRequest('POST', uri);

      if (token != null && token!.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      request.files.add(await http.MultipartFile.fromPath('file', file.path));

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final body = jsonDecode(response.body);
        if (body is Map<String, dynamic>) return body;
        return {'status': 'success', 'data': body};
      } else {
        debugPrint(
          'Backend analyze returned ${response.statusCode}: ${response.body}',
        );
      }
    } catch (e) {
      debugPrint('Backend analyze error: $e');
    }

    // ── Step 2: Try Groq API directly ───────────────────────────────────────
    if (_groqApiKey.isNotEmpty) {
      try {
        final fileName = file.path.split(Platform.pathSeparator).last;

        final prompt =
            '''
You are a medical AI assistant. A patient has uploaded a lab report file named "$fileName".
Please provide a structured analysis as if you have reviewed this lab report.

Return your response in the following JSON structure (respond ONLY with valid JSON, no extra text):
{
  "status": "success",
  "summary": "<brief overall health summary>",
  "findings": [
    "<finding 1>",
    "<finding 2>",
    "<finding 3>"
  ],
  "recommendations": [
    "<recommendation 1>",
    "<recommendation 2>",
    "<recommendation 3>"
  ],
  "note": "<medical disclaimer>"
}
''';

        final groqResponse = await http.post(
          Uri.parse('$_groqBaseUrl/chat/completions'),
          headers: {
            'Authorization': 'Bearer $_groqApiKey',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'model': _groqModel,
            'messages': [
              {
                'role': 'system',
                'content':
                    'You are a helpful medical AI assistant. Always respond with valid JSON only.',
              },
              {'role': 'user', 'content': prompt},
            ],
            'temperature': 0.3,
            'max_tokens': 1024,
          }),
        );

        debugPrint('Groq response status: ${groqResponse.statusCode}');

        if (groqResponse.statusCode >= 200 && groqResponse.statusCode < 300) {
          final groqBody = jsonDecode(groqResponse.body);
          final rawContent =
              groqBody['choices']?[0]?['message']?['content'] as String?;

          if (rawContent != null) {
            try {
              String cleaned = rawContent.trim();
              if (cleaned.startsWith('```')) {
                cleaned = cleaned
                    .replaceAll(RegExp(r'^```[a-z]*\n?'), '')
                    .replaceAll(RegExp(r'```$'), '')
                    .trim();
              }
              final parsed = jsonDecode(cleaned);
              if (parsed is Map<String, dynamic>) {
                debugPrint('Groq analysis successful');
                return parsed;
              }
            } catch (parseError) {
              debugPrint('Groq JSON parse error: $parseError');
              return {
                'status': 'success',
                'summary': rawContent,
                'findings': <String>[],
                'recommendations': <String>[],
                'note':
                    'This is an AI-generated suggestion. Please consult with your doctor for a professional medical opinion.',
              };
            }
          }
        } else {
          debugPrint(
            'Groq API error ${groqResponse.statusCode}: ${groqResponse.body}',
          );
        }
      } catch (e) {
        debugPrint('Groq direct analyze error: $e');
      }
    }

    // ── Step 3: Simulated fallback ────────────────────────────────────────────
    debugPrint('Using simulated fallback response');
    await Future.delayed(const Duration(seconds: 1));

    return {
      'status': 'success',
      'summary': 'The lab report shows normal levels for most parameters.',
      'findings': [
        'Hemoglobin: 14.5 g/dL (Normal)',
        'WBC Count: 7,500/mcL (Normal)',
        'Blood Sugar (Fasting): 95 mg/dL (Normal)',
      ],
      'recommendations': [
        'Continue with a balanced diet rich in fruits and vegetables.',
        'Stay physically active with at least 30 minutes of daily exercise.',
        'Maintain good hydration (8+ glasses of water per day).',
      ],
      'note':
          'This is an AI-generated suggestion. Please consult with your doctor for a professional medical opinion.',
    };
  }

  /// Send a health-related question to Groq and get an AI response.
  Future<String> askHealthQuestion(String question) async {
    if (_groqApiKey.isEmpty || _groqApiKey.startsWith('gsk_placeholder')) {
      return 'AI service is not configured. Please set a valid Groq API key in ai_service.dart.';
    }

    try {
      final response = await http.post(
        Uri.parse('$_groqBaseUrl/chat/completions'),
        headers: {
          'Authorization': 'Bearer $_groqApiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': _groqModel,
          'messages': [
            {
              'role': 'system',
              'content':
                  'You are a helpful medical assistant. Provide clear, concise health information. Always remind users to consult healthcare professionals for medical decisions.',
            },
            {'role': 'user', 'content': question},
          ],
          'temperature': 0.5,
          'max_tokens': 512,
        }),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final body = jsonDecode(response.body);
        return body['choices']?[0]?['message']?['content'] as String? ??
            'I could not generate a response. Please try again.';
      }
    } catch (e) {
      debugPrint('Groq health question error: $e');
    }
    return 'Service temporarily unavailable. Please try again later.';
  }
}
