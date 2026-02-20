import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiBaseService {
  final String baseUrl = "https://labloom-new.onrender.com/api";
  static String? _token;
  static String? _refreshToken;

  // Token management
  Future<void> setToken(String token, {String? refreshToken}) async {
    _token = token;
    _refreshToken = refreshToken;

    // Persist tokens
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
    if (refreshToken != null) {
      await prefs.setString('refresh_token', refreshToken);
    }
  }

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('access_token');
    _refreshToken = prefs.getString('refresh_token');
  }

  Future<void> clearTokens() async {
    _token = null;
    _refreshToken = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
  }

  String? get token => _token;
  String? get refreshToken => _refreshToken;

  Map<String, String> get _headers {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (_token != null && _token!.isNotEmpty) {
      headers['Authorization'] = 'Bearer $_token';
    }
    return headers;
  }

  // GET request
  Future<dynamic> get(
    String endpoint, {
    Map<String, String>? queryParams,
  }) async {
    var uri = Uri.parse('$baseUrl$endpoint');
    if (queryParams != null && queryParams.isNotEmpty) {
      uri = uri.replace(queryParameters: queryParams);
    }

    debugPrint('Sending GET to $uri');
    debugPrint('Headers: $_headers');
    final response = await http.get(uri, headers: _headers);
    return _processResponse(response);
  }

  // POST request
  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    debugPrint('Sending POST to $uri');
    debugPrint('Payload: $data');
    debugPrint('Headers: $_headers');
    final response = await http.post(
      uri,
      headers: _headers,
      body: jsonEncode(data),
    );
    return _processResponse(response);
  }

  // PUT request
  Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    debugPrint('Sending PUT to $uri');
    debugPrint('Payload: $data');
    debugPrint('Headers: $_headers');
    final response = await http.put(
      uri,
      headers: _headers,
      body: jsonEncode(data),
    );
    return _processResponse(response);
  }

  // PATCH request
  Future<dynamic> patch(String endpoint, Map<String, dynamic> data) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    debugPrint('Sending PATCH to $uri');
    debugPrint('Payload: $data');
    debugPrint('Headers: $_headers');
    final response = await http.patch(
      uri,
      headers: _headers,
      body: jsonEncode(data),
    );
    return _processResponse(response);
  }

  // DELETE request
  Future<dynamic> delete(String endpoint) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    debugPrint('Sending DELETE to $uri');
    debugPrint('Headers: $_headers');
    final response = await http.delete(uri, headers: _headers);
    return _processResponse(response);
  }

  // Response processing
  dynamic _processResponse(http.Response response) {
    print('API Response [${response.request?.url}]: ${response.statusCode}');
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return {};
      return jsonDecode(response.body);
    } else {
      print('API Error Body: ${response.body}');
      String errorMessage = 'Error: ${response.statusCode}';
      try {
        final body = jsonDecode(response.body);
        if (body is Map && body.containsKey('message')) {
          errorMessage = body['message'];
        } else if (body is Map && body.containsKey('error')) {
          errorMessage = body['error'];
        }
      } catch (_) {}
      throw Exception(errorMessage);
    }
  }
}
