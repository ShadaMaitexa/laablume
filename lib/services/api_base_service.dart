import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiBaseService {
  final String baseUrl = "https://labloom-malabar.vercel.app/api";
  static String? _token;

  void setToken(String token) {
    _token = token;
  }

  Map<String, String> get _headers {
    final headers = {'Content-Type': 'application/json'};
    if (_token != null) {
      headers['Authorization'] = 'Bearer $_token';
    }
    return headers;
  }

  Future<dynamic> get(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
      );
      return _processResponse(response);
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
        body: jsonEncode(data),
      );
      return _processResponse(response);
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }

  Future<dynamic> patch(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
        body: jsonEncode(data),
      );
      return _processResponse(response);
    } catch (e) {
      throw Exception('Failed to patch data: $e');
    }
  }

  dynamic _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return {};
      try {
        return jsonDecode(response.body);
      } catch (e) {
        return {};
      }
    } else {
      // If we are in a mock session, don't throw, just return empty/mock data
      if (_token != null && _token!.startsWith('mock_')) {
        return _getMockResponseForEndpoint(response.request?.url.path ?? '');
      }
      throw Exception(
        'Error: ${response.statusCode} ${response.reasonPhrase} - ${response.body}',
      );
    }
  }

  dynamic _getMockResponseForEndpoint(String path) {
    // Return basic mock structures so dashboards don't crash
    if (path.contains('/doctors')) return [];
    if (path.contains('/reports')) return [];
    if (path.contains('/appointments')) return [];
    if (path.contains('/analytics')) return {};
    return {};
  }
}
