import 'api_base_service.dart';

class LabService extends ApiBaseService {
  static final LabService _instance = LabService._internal();
  factory LabService() => _instance;
  LabService._internal();

  Future<List<dynamic>> getBookings() async {
    final response = await get('/labs/bookings');
    return response is List ? response : [];
  }

  Future<void> updateBookingStatus(String bookingId, String status) async {
    await patch('/labs/bookings/$bookingId', {'status': status});
  }

  Future<void> uploadReport(String bookingId, Map<String, dynamic> data) async {
    await post('/labs/bookings/$bookingId/report', data);
  }

  Future<List<dynamic>> getStaff() async {
    final response = await get('/labs/staff');
    return response is List ? response : [];
  }

  Future<void> addStaff(Map<String, dynamic> staffData) async {
    await post('/labs/staff', staffData);
  }
}
