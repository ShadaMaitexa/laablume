import '../models/booking_model.dart';
import 'api_base_service.dart';

class BookingService extends ApiBaseService {
  Future<BookingModel> createBooking({
    required String labID,
    required String testID,
    required DateTime bookingDate,
    String status = "Scheduled",
  }) async {
    final response = await post('/patients/bookings', {
      'labID': labID,
      'testID': testID,
      'bookingDate': bookingDate.toUtc().toIso8601String(),
      'status': status,
    });

    return BookingModel.fromJson(response['booking'] ?? response);
  }

  Future<List<BookingModel>> getMyBookings() async {
    final response = await get('/patients/bookings/me');

    final List<dynamic> list = (response is List)
        ? response
        : (response['bookings'] ?? []);
    return list.map((e) => BookingModel.fromJson(e)).toList();
  }

  Future<BookingModel> updateStatus(String bookingID, String status) async {
    final response = await patch('/lab/bookings/$bookingID/status', {
      'status': status,
    });

    return BookingModel.fromJson(response['booking'] ?? response);
  }
}
