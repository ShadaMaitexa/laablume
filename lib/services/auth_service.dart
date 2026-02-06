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
        // Check for approval if user is Lab or Hospital
        final userRole = response['role']?.toString().toLowerCase() ?? role?.toLowerCase();
        final isApproved = response['isApproved'] ?? true;

        if ((userRole == 'lab' || userRole == 'hospital') && !isApproved) {
            throw Exception('Your account is pending admin approval. Please try again later.');
        }

        String? token = response['token'] ?? response['accessToken'] ?? response['jwt'];
        
        if (token != null) {
            setToken(token);
            debugPrint('Token set: $token');
            return response;
        }
    }
    return null;
  }

  // Admin Methods
  Future<List<dynamic>> getPendingHospitals() async {
    try {
      final response = await get('/admin/pending-hospitals');
      if (response is List) return response;
      return [
        {'id': 'h1', 'hospitalName': 'City General Hospital', 'email': 'city@gen.com', 'mobileNumber': '+919876543210', 'isApproved': false},
        {'id': 'h2', 'hospitalName': 'Kochi Medical Centre', 'email': 'kmc@med.com', 'mobileNumber': '+919876543211', 'isApproved': false},
      ]; // Mock data if API fails
    } catch (e) {
      return [
        {'id': 'h1', 'hospitalName': 'City General Hospital', 'email': 'city@gen.com', 'mobileNumber': '+919876543210', 'isApproved': false},
        {'id': 'h2', 'hospitalName': 'Kochi Medical Centre', 'email': 'kmc@med.com', 'mobileNumber': '+919876543211', 'isApproved': false},
      ];
    }
  }

  Future<void> approveHospital(String hospitalId) async {
    await post('/admin/approve-hospital/$hospitalId', {});
  }
}
