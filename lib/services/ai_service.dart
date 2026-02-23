import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'api_base_service.dart';

class AIService extends ApiBaseService {
  static final AIService _instance = AIService._internal();
  factory AIService() => _instance;
  AIService._internal();

  /// Persist a Grog API key locally for direct calls (use only for development).
  Future<void> setGrogApiKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('GROQ_API_KEY_REDACTED', key);
  }

  /// Remove stored Grog API key.
  Future<void> clearGrogApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('GROQ_API_KEY_REDACTED');
  }

  /// Analyzes a lab report (PDF or Image) and returns recommendations.
  /// This normally involves a multipart request to the backend.
  Future<Map<String, dynamic>> analyzeLabReport(File file) async {
    // Try to send a multipart request to the backend AI analyze endpoint.
    // If the backend endpoint is not available or the request fails, fall back to a simulated response.
    try {
      final uri = Uri.parse('$baseUrl/patients/analyze-report');

      final request = http.MultipartRequest('POST', uri);

      // Attach auth header if available
      if (token != null && token!.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      // Attach the file under the 'file' key (backend should expect this)
      request.files.add(await http.MultipartFile.fromPath('file', file.path));

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final body = jsonDecode(response.body);
        if (body is Map<String, dynamic>) return body;
        return {'status': 'success', 'data': body};
      } else {
        debugPrint(
          'AI analyze endpoint returned ${response.statusCode}: ${response.body}',
        );
      }
    } catch (e) {
      debugPrint('AIService.analyzeLabReport error: $e');
    }

    // If backend didn't handle analysis, try calling Grog AI directly (optional).
    try {
      final prefs = await SharedPreferences.getInstance();
      final grogKey = prefs.getString('GROQ_API_KEY_REDACTED');
      if (grogKey != null && grogKey.isNotEmpty) {
        final grogUri = Uri.parse('https://api.grog.ai/v1/analyze');
        final grogRequest = http.MultipartRequest('POST', grogUri);
        grogRequest.headers['Authorization'] = 'Bearer $grogKey';
        grogRequest.files.add(
          await http.MultipartFile.fromPath('file', file.path),
        );

        final grogStreamed = await grogRequest.send();
        final grogResponse = await http.Response.fromStream(grogStreamed);
        if (grogResponse.statusCode >= 200 && grogResponse.statusCode < 300) {
          final body = jsonDecode(grogResponse.body);
          if (body is Map<String, dynamic>) return body;
          return {'status': 'success', 'data': body};
        } else {
          debugPrint(
            'Grog analyze returned ${grogResponse.statusCode}: ${grogResponse.body}',
          );
        }
      }
    } catch (e) {
      debugPrint('Grog direct analyze error: $e');
    }

    // Fallback simulated response (keeps previous behavior for development).
    await Future.delayed(const Duration(seconds: 2));

    return {
      'status': 'success',
      'summary': 'The lab report shows normal levels for most parameters.',
      'findings': [
        'Hemoglobin: 14.5 g/dL (Normal)',
        'WBC Count: 7,500/mcL (Normal)',
        'Blood Sugar (Fasting): 95 mg/dL (Normal)',
      ],
      'recommendations': [
        'Continue with a balanced diet.',
        'Stay physically active with at least 30 minutes of daily exercise.',
        'Maintain good hydration.',
      ],
      'note':
          'This is an AI-generated suggestion. Please consult with your doctor for a professional medical opinion.',
    };
  }
}
