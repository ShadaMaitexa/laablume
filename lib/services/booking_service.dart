import '../models/booking_model.dart';
import 'api_base_service.dart';

class BookingService extends ApiBaseService {
  Future<BookingModel> createBooking({
    required String labID,
    required String testID,
    required DateTime bookingDate,
    String status = "Scheduled",
  }) async {
    final response = await post('/bookings', {
      'labID': labID,
      'testID': testID,
      'bookingDate': bookingDate.toUtc().toIso8601String(),
      'status': status,
      'reportURL': '', // Optional/Empty on creation usually
    });
    
    return BookingModel.fromJson(response['booking']);
  }

  Future<List<BookingModel>> getMyBookings() async {
    final response = await get('/bookings/me');
    
    if (response['bookings'] != null) {
      return (response['bookings'] as List)
          .map((e) => BookingModel.fromJson(e))
          .toList();
    }
    return [];
  }

  Future<BookingModel> updateStatus(String bookingID, String status) async {
    final response = await patch('/bookings/$bookingID/status', {
      'status': status,
    });
    
    return BookingModel.fromJson(response['booking']);
  }
}
