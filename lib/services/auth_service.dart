import 'package:flutter/foundation.dart';
import 'api_base_service.dart';

class AuthService extends ApiBaseService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  Future<void> signup(String userName, String mobileNumber, String email) async {
    await post('/auth/signup', {
      'userName': userName,
      'mobileNumber': mobileNumber,
      'email': email,
    });
  }

  Future<void> requestOtp(String mobileNumber) async {
    await post('/auth/request-otp', {
      'mobileNumber': mobileNumber,
    });
  }

  Future<bool> verifyOtp(String mobileNumber, String otp) async {
    final response = await post('/auth/verify-otp', {
      'mobileNumber': mobileNumber,
      'otp': otp,
    });
    
    if (response != null) {
        String? token;
        // Check for common token keys
        if (response is Map<String, dynamic>) {
            token = response['token'] ?? response['accessToken'] ?? response['jwt'];
        } 
        
        if (token != null) {
            setToken(token);
            debugPrint('Token set: $token');
            return true;
        }
    }
    return false;
  }
}
