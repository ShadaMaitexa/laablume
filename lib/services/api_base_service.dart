import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiBaseService {
  final String baseUrl = "https://api.lablume.com/v1"; // Placeholder URL

  Future<dynamic> get(String endpoint) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$endpoint'));
      return _processResponse(response);
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      return _processResponse(response);
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }

  dynamic _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error: ${response.statusCode} ${response.reasonPhrase}');
    }
  }
}
