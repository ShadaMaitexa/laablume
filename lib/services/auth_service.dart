import 'api_base_service.dart';

class AuthService extends ApiBaseService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // V2 Signup (updated for Labloom API)
  Future<Map<String, dynamic>> signup({
    required String name,
    required String phone,
    required String email,
    String password = '',
    String role = 'patient', // Default to patient
  }) async {
    final response = await post('/auth/v2/signup', {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
      'role': role,
    });
    return response;
  }

  // Password-based login
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await post('/auth/login', {
      'email': email,
      'password': password,
    });

    // Store tokens
    if (response != null && response is Map<String, dynamic>) {
      String? token = response['token'] ?? response['accessToken'];
      String? refreshToken = response['refreshToken'];
      if (token != null) {
        await setToken(token, refreshToken: refreshToken);
      }
    }
    return response;
  }

  // Request OTP for mobile login (V2)
  Future<Map<String, dynamic>> requestOtp(String phone) async {
    // Hardcoded Admin Bypass
    if (phone == '+911234567890') {
      return {'message': 'OTP sent (Hardcoded Bypass)'};
    }
    final response = await post('/auth/v2/request-otp', {'phone': phone});
    return response;
  }

  // Verify OTP and login (V2)
  Future<Map<String, dynamic>> verifyOtp({
    required String phone,
    required String otp,
    String? role,
  }) async {
    // Hardcoded Admin Bypass
    if (phone == '+911234567890' && otp == '1234') {
      final mockAdmin = {
        'token': 'hardcoded-admin-token',
        'name': 'Platform Admin',
        'phone': '+911234567890',
        'email': 'admin@lablume.com',
        'role': 'admin',
        'id': 'admin-001',
        'isApproved': true,
      };
      await setToken(mockAdmin['token'].toString());
      return mockAdmin;
    }

    final Map<String, dynamic> data = {'phone': phone, 'otp': otp};
    if (role != null) {
      data['role'] = role;
    }
    final response = await post('/auth/v2/verify-otp', data);

    // Store tokens
    if (response != null && response is Map<String, dynamic>) {
      String? token = response['token'] ?? response['accessToken'];
      String? refreshToken = response['refreshToken'];
      if (token != null) {
        await setToken(token, refreshToken: refreshToken);
      }
    }
    return response;
  }

  // Refresh access token (V2)
  Future<Map<String, dynamic>> refreshAccessToken(String refreshToken) async {
    final response = await post('/auth/v2/refresh-token', {
      'refreshToken': refreshToken,
    });

    // Update stored token
    if (response != null && response is Map<String, dynamic>) {
      String? newToken = response['token'] ?? response['accessToken'];
      String? newRefreshToken = response['refreshToken'];
      if (newToken != null) {
        await setToken(newToken, refreshToken: newRefreshToken);
      }
    }
    return response;
  }

  // Logout (V2)
  Future<void> logout() async {
    String? currentRefreshToken = refreshToken;
    if (currentRefreshToken != null) {
      try {
        await post('/auth/v2/logout', {'refreshToken': currentRefreshToken});
      } catch (e) {
        // Continue logout even if API call fails
      }
    }
    await clearTokens();
  }

  // Get user profile
  Future<Map<String, dynamic>> getProfile() async {
    final response = await get('/auth/profile');
    return response;
  }

  // Update user profile
  Future<Map<String, dynamic>> updateProfile(
    Map<String, dynamic> profileData,
  ) async {
    final response = await put('/auth/profile', profileData);
    return response;
  }
}
