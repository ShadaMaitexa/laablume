import 'package:flutter/foundation.dart';
import 'api_base_service.dart';

class AuthService extends ApiBaseService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  Future<void> signup(
    String userName,
    String mobileNumber,
    String email, {
    String? role,
  }) async {
    final cleanPhone = mobileNumber.replaceAll(' ', '');
    await post('/auth/register', {
      'name': userName,
      'phone': cleanPhone,
      'email': email,
      if (role != null) 'role': role,
    });
  }

  Future<void> requestOtp(String mobileNumber) async {
    final cleanPhone = mobileNumber.replaceAll(' ', '');
    try {
      await post('/auth/send-otp', {'phone': cleanPhone});
    } catch (e) {
      // If backend fails, we still allow proceeding if the user knows the OTP (e.g. 1234)
      debugPrint('Request OTP failed, but allowing bypass for testing: $e');
    }
  }

  Future<Map<String, dynamic>?> verifyOtp(
    String mobileNumber,
    String otp, {
    String? role,
  }) async {
    final cleanPhone = mobileNumber.replaceAll(' ', '');

    // Developer Bypass: If OTP is 1234, and backend fails or for testing
    if (otp == '1234') {
      try {
        final response = await post('/auth/verify-otp', {
          'phone': cleanPhone,
          'otp': otp,
          if (role != null) 'role': role,
        });
        if (response != null) return _handleAuthResponse(response, role);
      } catch (e) {
        debugPrint('Verify OTP failed, using local bypass for 1234: $e');
        // Return a mock successful response if it's 1234 and backend failed
        return {
          'id': 'mock_userid_1234',
          'token': 'mock_token_for_1234',
          'role': role ?? 'doctor',
          'name': 'Test User',
          'email': 'test@laablume.com',
          'phone': cleanPhone,
          'isApproved': true,
        };
      }
    }

    final response = await post('/auth/verify-otp', {
      'phone': cleanPhone,
      'otp': otp,
      if (role != null) 'role': role,
    });

    return _handleAuthResponse(response, role);
  }

  Map<String, dynamic>? _handleAuthResponse(dynamic response, String? role) {
    if (response != null && response is Map<String, dynamic>) {
      final isApproved = response['isApproved'] ?? true;
      final userRole =
          response['role']?.toString().toLowerCase() ?? role?.toLowerCase();

      if ((userRole == 'lab' || userRole == 'hospital') && !isApproved) {
        throw Exception(
          'Your account is pending admin approval. Please try again later.',
        );
      }

      String? token =
          response['token'] ?? response['accessToken'] ?? response['jwt'];

      if (token != null) {
        setToken(token);
        debugPrint('Token set: $token');
        return response;
      }
    }
    return null;
  }

  Future<void> refreshToken() async {
    await post('/auth/refresh-token', {});
  }

  Future<void> logout() async {
    await post('/auth/logout', {});
    setToken(''); // Clear token locally
  }

  // Admin Portal Endpoints
  Future<List<dynamic>> getPendingHospitals() async {
    final response = await get('/admin/pending-hospitals');
    if (response is List) return response;
    if (response is Map && response.containsKey('hospitals'))
      return response['hospitals'];
    return [];
  }

  Future<void> approveHospital(String hospitalId) async {
    await post('/admin/approve-hospital/$hospitalId', {});
  }

  Future<List<dynamic>> getPendingLabs() async {
    final response = await get('/admin/pending-labs');
    if (response is List) return response;
    return [];
  }

  Future<void> approveLab(String labId) async {
    await post('/admin/approve-lab/$labId', {});
  }

  Future<List<dynamic>> getUsers({String? query}) async {
    final response = await get(
      '/admin/users${query != null ? '?search=$query' : ''}',
    );
    if (response is List) return response;
    return [];
  }

  Future<void> updateUserStatus(String userId, String status) async {
    await patch('/admin/users/$userId/status', {'status': status});
  }

  Future<Map<String, dynamic>> getSystemReports() async {
    return await get('/admin/reports/system');
  }
}
