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
    await post('/auth/signup', {
      'name': userName,
      'mobile': mobileNumber,
      'email': email,
      if (role != null) 'role': role,
    });
  }

  Future<void> requestOtp(String mobileNumber) async {
    await post('/auth/request-otp', {'mobile': mobileNumber});
  }

  Future<Map<String, dynamic>?> verifyOtp(
    String mobileNumber,
    String otp, {
    String? role,
  }) async {
    final response = await post('/auth/verify-otp', {
      'mobile': mobileNumber,
      'otp': otp,
      if (role != null) 'role': role,
    });

    if (response != null && response is Map<String, dynamic>) {
      String? token = response['token'];
      if (token != null) {
        setToken(token);
        return response;
      }
    }
    return null;
  }

  Future<void> logout() async {
    await post('/auth/logout', {});
    setToken('');
  }
}
