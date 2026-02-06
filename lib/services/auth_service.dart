import 'package:flutter/foundation.dart';
import 'api_base_service.dart';

class AuthService extends ApiBaseService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  Future<void> signup(String userName, String mobileNumber, String email, {String? role}) async {
    await post('/auth/signup', {
      'userName': userName,
      'mobileNumber': mobileNumber,
      'email': email,
      if (role != null) 'role': role,
    });
  }

  Future<void> addDoctor({
    required String name,
    required String mobileNumber,
    required String specialty,
    required String email,
  }) async {
    // This endpoint should be handled by the backend to associate the doctor with the hospital
    await post('/hospital/add-doctor', {
      'name': name,
      'mobileNumber': mobileNumber,
      'specialty': specialty,
      'email': email,
      'role': 'doctor',
    });
  }

  Future<List<dynamic>> getHospitalDoctors() async {
    try {
      final response = await get('/hospital/doctors');
      if (response is List) return response;
      if (response is Map && response.containsKey('doctors')) return response['doctors'];
      return [];
    } catch (e) {
      debugPrint('Error fetching doctors: $e');
      return [];
    }
  }

  Future<void> requestOtp(String mobileNumber) async {
    await post('/auth/request-otp', {
      'mobileNumber': mobileNumber,
    });
  }

  Future<Map<String, dynamic>?> verifyOtp(String mobileNumber, String otp, {String? role}) async {
    final response = await post('/auth/verify-otp', {
      'mobileNumber': mobileNumber,
      'otp': otp,
      if (role != null) 'role': role,
    });
    
    if (response != null && response is Map<String, dynamic>) {
        String? token = response['token'] ?? response['accessToken'] ?? response['jwt'];
        
        if (token != null) {
            setToken(token);
            debugPrint('Token set: $token');
            return response;
        }
    }
    return null;
  }
}
