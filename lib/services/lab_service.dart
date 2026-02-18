import 'api_base_service.dart';

class LabService extends ApiBaseService {
  static final LabService _instance = LabService._internal();
  factory LabService() => _instance;
  LabService._internal();

  // List test bookings by status or date
  Future<List<dynamic>> getBookings({String? status}) async {
    final queryParams = status != null ? {'status': status} : null;
    final response = await get('/lab/bookings', queryParams: queryParams);
    return response['bookings'] ?? response['data'] ?? [];
  }

  // Add offline/manual booking for walk-in patient
  Future<Map<String, dynamic>> createBooking(
    Map<String, dynamic> bookingData,
  ) async {
    final response = await post('/lab/bookings', bookingData);
    return response;
  }

  // Update sample status (Collected/In-Lab/etc.)
  Future<Map<String, dynamic>> updateBookingStatus(
    String id,
    String status,
  ) async {
    final response = await patch('/lab/bookings/$id/status', {
      'status': status,
    });
    return response;
  }

  // Upload digitized report file
  Future<Map<String, dynamic>> uploadReport(
    Map<String, dynamic> reportData,
  ) async {
    final response = await post('/lab/reports/upload', reportData);
    return response;
  }

  // Final pathologist approval
  Future<Map<String, dynamic>> validateReport(String id) async {
    final response = await post('/lab/reports/$id/validate', {});
    return response;
  }

  // List lab technicians and pathologists
  Future<List<dynamic>> getStaff() async {
    final response = await get('/lab/staff');
    return response['staff'] ?? response['data'] ?? [];
  }

  // Update lab configuration
  Future<Map<String, dynamic>> updateSettings(
    Map<String, dynamic> settings,
  ) async {
    final response = await patch('/lab/settings', settings);
    return response;
  }

  // Manage Test Catalog
  Future<List<dynamic>> getTests() async {
    final response = await get('/lab/tests');
    return response['tests'] ?? response['data'] ?? [];
  }

  Future<Map<String, dynamic>> addTest(Map<String, dynamic> testData) async {
    final response = await post('/lab/tests', testData);
    return response;
  }

  Future<Map<String, dynamic>> updateTest(
    String id,
    Map<String, dynamic> testData,
  ) async {
    final response = await patch('/lab/tests/$id', testData);
    return response;
  }

  Future<Map<String, dynamic>> deleteTest(String id) async {
    final response = await delete('/lab/tests/$id');
    return response;
  }

  // Feedbacks
  Future<List<dynamic>> getFeedbacks() async {
    final response = await get('/lab/feedbacks');
    return response['feedbacks'] ?? response['data'] ?? [];
  }

  // Lab Profile
  Future<Map<String, dynamic>> getProfile() async {
    final response = await get('/lab/profile');
    return response['profile'] ?? response['data'] ?? {};
  }

  // Get list of all labs (for patient view)
  Future<List<dynamic>> getAllLabs({String? city}) async {
    final queryParams = city != null ? {'city': city} : null;
    final response = await get('/patients/labs', queryParams: queryParams);
    return response['labs'] ?? response['data'] ?? [];
  }
}
