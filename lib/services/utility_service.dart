import 'api_base_service.dart';

class UtilityService extends ApiBaseService {
  Future<List<dynamic>> getCities({String? query}) async {
    final response = await get(
      '/utils/cities${query != null ? '?query=$query' : ''}',
    );
    if (response is List) return response;
    return [];
  }

  Future<List<dynamic>> getAllTests() async {
    final response = await get('/tests');
    if (response is List) return response;
    return [];
  }

  Future<List<dynamic>> getNotifications() async {
    final response = await get('/notifications');
    if (response is List) return response;
    return [];
  }

  Future<List<dynamic>> getPaymentMethods() async {
    final response = await get('/payments/methods');
    if (response is List) return response;
    return [];
  }
}
