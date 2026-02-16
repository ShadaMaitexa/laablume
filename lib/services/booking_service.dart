import 'api_base_service.dart';

class BookingService extends ApiBaseService {
  static final BookingService _instance = BookingService._internal();
  factory BookingService() => _instance;
  BookingService._internal();

  // Create a new booking
  Future<Map<String, dynamic>> createBooking(
    Map<String, dynamic> bookingData,
  ) async {
    final response = await post('/bookings', bookingData);
    return response;
  }

  // Get my bookings
  Future<List<dynamic>> getMyBookings() async {
    final response = await get('/bookings/my');
    return response['bookings'] ?? response['data'] ?? [];
  }

  // Get visit summaries
  Future<List<dynamic>> getVisitSummaries() async {
    final response = await get('/bookings/summaries');
    return response['summaries'] ?? response['data'] ?? [];
  }

  // Update visit summary
  Future<Map<String, dynamic>> updateVisitSummary(
    String id,
    Map<String, dynamic> summaryData,
  ) async {
    final response = await put('/bookings/$id/summary', summaryData);
    return response;
  }
}
