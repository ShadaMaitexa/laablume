import 'api_base_service.dart';

class UtilityService extends ApiBaseService {
  static final UtilityService _instance = UtilityService._internal();
  factory UtilityService() => _instance;
  UtilityService._internal();

  Future<List<String>> getCities() async {
    final response = await get('/utils/cities');
    return response is List ? List<String>.from(response) : [];
  }

  Future<List<dynamic>> getTests() async {
    final response = await get('/utils/tests');
    return response is List ? response : [];
  }

  Future<List<dynamic>> getNotifications() async {
    final response = await get('/utils/notifications');
    return response is List ? response : [];
  }

  Future<List<String>> getPaymentMethods() async {
    final response = await get('/utils/payment-methods');
    return response is List ? List<String>.from(response) : [];
  }
}
