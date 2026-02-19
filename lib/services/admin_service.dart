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

  // Helper to safely parse List from API response
  List<dynamic> _parseList(dynamic response, String key) {
    if (response == null) return [];
    if (response is List) return response;
    if (response is Map) {
      final data =
          response[key] ??
          response['data'] ??
          response['users'] ??
          response['hospitals'] ??
          response['doctors'] ??
          response['labs'] ??
          response['bookings'];
      if (data is List) return data;
    }
    return [];
  }

  // Get list of hospitals awaiting verification
  Future<List<dynamic>> getPendingHospitals() async {
    try {
      final response = await get('/admin/pending-hospitals');
      return _parseList(response, 'hospitals');
    } catch (e) {
      print('Error fetching pending hospitals: $e');
      return [];
    }
  }

  // Approve/Enable a hospital entity
  Future<Map<String, dynamic>> approveHospital(String id) async {
    final response = await post('/admin/approve-hospital/$id', {});
    return Map<String, dynamic>.from(response is Map ? response : {});
  }

  // Get list of doctors awaiting verification
  Future<List<dynamic>> getPendingDoctors() async {
    try {
      final response = await get('/admin/pending-doctors');
      return _parseList(response, 'doctors');
    } catch (e) {
      print('Error fetching pending doctors: $e');
      return [];
    }
  }

  // Approve/Enable a doctor entity
  Future<Map<String, dynamic>> approveDoctor(String id) async {
    final response = await post('/admin/approve-doctor/$id', {});
    return Map<String, dynamic>.from(response is Map ? response : {});
  }

  // Get list of diagnostic centers awaiting verification
  Future<List<dynamic>> getPendingLabs() async {
    try {
      final response = await get('/admin/pending-labs');
      return _parseList(response, 'labs');
    } catch (e) {
      print('Error fetching pending labs: $e');
      return [];
    }
  }

  // Approve/Enable a lab entity
  Future<Map<String, dynamic>> approveLab(String id) async {
    final response = await post('/admin/approve-lab/$id', {});
    return Map<String, dynamic>.from(response is Map ? response : {});
  }

  // Get list of users awaiting verification (privacyPolicyAccepted: false)
  Future<List<dynamic>> getPendingUsers() async {
    try {
      final allUsers = await getUsers();
      return allUsers
          .where((u) => u['privacyPolicyAccepted'] == false)
          .toList();
    } catch (e) {
      return [];
    }
  }

  // Approve a user account
  Future<Map<String, dynamic>> approveUser(String id) async {
    final response = await patch('/admin/users/$id/status', {
      'privacyPolicyAccepted': true,
      'isActive': true,
    });
    return Map<String, dynamic>.from(response is Map ? response : {});
  }

  // Search and manage all platform users
  Future<List<dynamic>> getUsers({String? search}) async {
    try {
      final queryParams = search != null ? {'search': search} : null;
      final response = await get('/admin/users', queryParams: queryParams);
      return _parseList(response, 'users');
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }
  }

  // Suspend or deactivate accounts
  Future<Map<String, dynamic>> updateUserStatus(
    String id,
    bool isActive,
  ) async {
    final response = await patch('/admin/users/$id/status', {
      'isActive': isActive,
    });
    return Map<String, dynamic>.from(response is Map ? response : {});
  }

  // Platform-wide usage and growth analytics
  Future<Map<String, dynamic>> getSystemReports() async {
    try {
      final response = await get('/admin/reports/system');
      return Map<String, dynamic>.from(response is Map ? response : {});
    } catch (e) {
      print('Error fetching system reports: $e');
      return {};
    }
  }

  // Get all bookings (appointments/tests) across the platform
  Future<List<dynamic>> getAllBookings() async {
    try {
      final response = await get('/admin/bookings');
      return _parseList(response, 'bookings');
    } catch (e) {
      print('Error fetching all bookings: $e');
      return [];
    }
  }

  // Get booking-specific analytics
  Future<Map<String, dynamic>> getBookingStats() async {
    try {
      final response = await get('/admin/reports/bookings');
      return Map<String, dynamic>.from(response is Map ? response : {});
    } catch (e) {
      print('Error fetching booking stats: $e');
      return {};
    }
  }

  // Get patient feedback
  Future<List<dynamic>> getFeedback() async {
    // Return mock data if API fails or for demonstration
    try {
      final response = await get('/admin/feedback');
      return _parseList(response, 'feedback');
    } catch (e) {
      return [];
    }
  }
}
