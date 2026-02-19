import 'api_base_service.dart';

class AdminService extends ApiBaseService {
  static final AdminService _instance = AdminService._internal();
  factory AdminService() => _instance;
  AdminService._internal();

  // Request OTP for admin login
  Future<Map<String, dynamic>> requestOtp(String phone) async {
    final response = await post('/admin/request-otp', {'phone': phone});
    return Map<String, dynamic>.from(response);
  }

  // Verify OTP and get admin access token
  Future<Map<String, dynamic>> verifyOtp(String phone, String otp) async {
    final response = await post('/admin/verify-otp', {
      'phone': phone,
      'otp': otp,
    });
    // Store token if available
    if (response != null && response is Map<String, dynamic>) {
      String? token = response['token'] ?? response['accessToken'];
      if (token != null) {
        await setToken(token);
      }
    }
    return Map<String, dynamic>.from(response);
  }

  // Get list of hospitals awaiting verification
  Future<List<dynamic>> getPendingHospitals() async {
    final response = await get('/admin/pending-hospitals');
    return response['hospitals'] ?? response['data'] ?? [];
  }

  // Approve/Enable a hospital entity
  Future<Map<String, dynamic>> approveHospital(String id) async {
    final response = await post('/admin/approve-hospital/$id', {});
    return Map<String, dynamic>.from(response);
  }

  // Get list of doctors awaiting verification
  Future<List<dynamic>> getPendingDoctors() async {
    final response = await get('/admin/pending-doctors');
    return response['doctors'] ?? response['data'] ?? [];
  }

  // Approve/Enable a doctor entity
  Future<Map<String, dynamic>> approveDoctor(String id) async {
    final response = await post('/admin/approve-doctor/$id', {});
    return Map<String, dynamic>.from(response);
  }

  // Get list of diagnostic centers awaiting verification
  Future<List<dynamic>> getPendingLabs() async {
    final response = await get('/admin/pending-labs');
    return response['labs'] ?? response['data'] ?? [];
  }

  // Approve/Enable a lab entity
  Future<Map<String, dynamic>> approveLab(String id) async {
    final response = await post('/admin/approve-lab/$id', {});
    return Map<String, dynamic>.from(response);
  }

  // Search and manage all platform users
  Future<List<dynamic>> getUsers({String? search}) async {
    final queryParams = search != null ? {'search': search} : null;
    final response = await get('/admin/users', queryParams: queryParams);
    return response['users'] ?? response['data'] ?? [];
  }

  // Suspend or deactivate accounts
  Future<Map<String, dynamic>> updateUserStatus(
    String id,
    bool isActive,
  ) async {
    final response = await patch('/admin/users/$id/status', {
      'isActive': isActive,
    });
    return Map<String, dynamic>.from(response);
  }

  // Platform-wide usage and growth analytics
  Future<Map<String, dynamic>> getSystemReports() async {
    final response = await get('/admin/reports/system');
    return Map<String, dynamic>.from(response);
  }

  // Get all bookings (appointments/tests) across the platform
  Future<List<dynamic>> getAllBookings() async {
    final response = await get('/admin/bookings');
    return response['bookings'] ?? response['data'] ?? [];
  }

  // Get booking-specific analytics
  Future<Map<String, dynamic>> getBookingStats() async {
    final response = await get('/admin/reports/bookings');
    return Map<String, dynamic>.from(response);
  }

  // Get patient feedback
  Future<List<dynamic>> getFeedback() async {
    // Return mock data if API fails or for demonstration
    try {
      final response = await get('/admin/feedback');
      return response['feedback'] ?? response['data'] ?? [];
    } catch (e) {
      return [];
    }
  }

  // Get registration growth trends for charts
  Future<Map<String, dynamic>> getGrowthTrends() async {
    try {
      final response = await get('/admin/reports/growth');
      return Map<String, dynamic>.from(response);
    } catch (e) {
      return {};
    }
  }

  // Get system security logs
  Future<List<dynamic>> getSecurityLogs() async {
    try {
      final response = await get('/admin/logs/security');
      return response['logs'] ?? response['data'] ?? [];
    } catch (e) {
      return [];
    }
  }
}
