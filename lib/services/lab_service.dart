import 'api_base_service.dart';

class LabService extends ApiBaseService {
  static final LabService _instance = LabService._internal();
  factory LabService() => _instance;
  LabService._internal();

  // --- Booking Management ---

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

  // List upcoming/pending test bookings
  Future<List<dynamic>> getPendingBookings() async {
    final response = await get('/lab/bookings/pending');
    return response['bookings'] ?? response['data'] ?? [];
  }

  // Update booking status (Completed / Test Not Done)
  Future<Map<String, dynamic>> updateBookingStatus(
    String id,
    String status,
  ) async {
    final response = await patch('/lab/bookings/$id/status', {
      'status': status,
    });
    return response;
  }

  // --- Report Operations ---

  // Upload digital report for a specific booking (after completion)
  Future<Map<String, dynamic>> uploadReportForBooking(
    String id,
    Map<String, dynamic> data,
  ) async {
    final response = await post('/lab/bookings/$id/upload-report', data);
    return response;
  }

  // Upload digitized report file (legacy)
  Future<Map<String, dynamic>> uploadReport(
    Map<String, dynamic> reportData,
  ) async {
    final response = await post('/lab/reports/upload', reportData);
    return response;
  }

  // Download finalized PDF report
  Future<Map<String, dynamic>> downloadReport(String bookingId) async {
    final response = await get('/lab/reports/$bookingId/download');
    return response;
  }

  // Final pathologist approval
  Future<Map<String, dynamic>> validateReport(String id) async {
    final response = await post('/lab/reports/$id/validate', {});
    return response;
  }

  // --- Test Catalog Management ---

  // Get lab test catalog
  Future<List<dynamic>> getCatalog() async {
    final response = await get('/lab/catalog');
    return response['catalog'] ?? response['data'] ?? [];
  }

  // Add test to lab catalog
  Future<Map<String, dynamic>> addToCatalog(Map<String, dynamic> data) async {
    final response = await post('/lab/catalog', data);
    return response;
  }

  // Update price/turnaround for a test in catalog
  Future<Map<String, dynamic>> updateCatalogItem(
    String testEntryId,
    Map<String, dynamic> data,
  ) async {
    final response = await patch('/lab/catalog/$testEntryId', data);
    return response;
  }

  // Remove test from lab catalog
  Future<Map<String, dynamic>> deleteCatalogItem(String testEntryId) async {
    final response = await delete('/lab/catalog/$testEntryId');
    return response;
  }

  // --- Staff & Settings ---

  // List lab technicians and pathologists
  Future<List<dynamic>> getStaff() async {
    final response = await get('/lab/staff');
    return response['staff'] ?? response['data'] ?? [];
  }

  // Register new staff member
  Future<Map<String, dynamic>> registerStaff(Map<String, dynamic> data) async {
    final response = await post('/lab/staff', data);
    return response;
  }

  // Update lab configuration
  Future<Map<String, dynamic>> updateSettings(
    Map<String, dynamic> settings,
  ) async {
    final response = await patch('/lab/settings', settings);
    return response;
  }

  // --- Legacy / Misc ---

  Future<List<dynamic>> getFeedbacks() async {
    final response = await get('/lab/feedbacks');
    return response['feedbacks'] ?? response['data'] ?? [];
  }

  Future<Map<String, dynamic>> getProfile() async {
    final response = await get('/lab/profile');
    return response['profile'] ?? response['data'] ?? {};
  }

  // --- Compatibility Aliases ---
  Future<List<dynamic>> getTests() => getCatalog();
  Future<Map<String, dynamic>> addTest(Map<String, dynamic> data) =>
      addToCatalog(data);
  Future<Map<String, dynamic>> updateTest(
    String id,
    Map<String, dynamic> data,
  ) => updateCatalogItem(id, data);
  Future<Map<String, dynamic>> deleteTest(String id) => deleteCatalogItem(id);
}
