import 'api_base_service.dart';

class LabService extends ApiBaseService {
  Future<List<dynamic>> getBookings({String? status}) async {
    final endpoint = '/lab/bookings${status != null ? '?status=$status' : ''}';
    final response = await get(endpoint);
    if (response is List) return response;
    if (response is Map && response.containsKey('bookings'))
      return response['bookings'];
    return [];
  }

  Future<void> createBooking(Map<String, dynamic> data) async {
    await post('/lab/bookings', data);
  }

  Future<void> updateBookingStatus(String bookingId, String status) async {
    await patch('/lab/bookings/$bookingId/status', {'status': status});
  }

  Future<void> uploadReport(Map<String, dynamic> data) async {
    // Note: Multipart file upload should be handled if adding a real file
    await post('/lab/reports/upload', data);
  }

  Future<void> validateReport(String reportId) async {
    await post('/lab/reports/$reportId/validate', {});
  }

  // Staff
  Future<List<dynamic>> getStaff() async {
    final response = await get('/lab/staff');
    if (response is List) return response;
    return [];
  }

  Future<void> addStaff(Map<String, dynamic> data) async {
    await post('/lab/staff', data);
  }

  // Settings
  Future<void> updateSettings(Map<String, dynamic> settings) async {
    await patch('/lab/settings', settings);
  }
}
