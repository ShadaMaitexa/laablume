import 'api_base_service.dart';

class BookingService extends ApiBaseService {
  static final BookingService _instance = BookingService._internal();
  factory BookingService() => _instance;
  BookingService._internal();

  Future<Map<String, dynamic>> createBooking(
    Map<String, dynamic> bookingData,
  ) async {
    final response = await post('/bookings', bookingData);
    return response is Map<String, dynamic> ? response : {};
  }

  Future<List<dynamic>> getMyBookings() async {
    final response = await get('/bookings/my');
    return response is List ? response : [];
  }

  Future<void> cancelBooking(String bookingId) async {
    await patch('/bookings/$bookingId/cancel', {});
  }

  Future<Map<String, dynamic>> getBookingDetails(String bookingId) async {
    final response = await get('/bookings/$bookingId');
    return response is Map<String, dynamic> ? response : {};
  }
}
