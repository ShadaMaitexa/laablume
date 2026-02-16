import 'api_base_service.dart';

class TestService extends ApiBaseService {
  static final TestService _instance = TestService._internal();
  factory TestService() => _instance;
  TestService._internal();

  // Get all tests
  Future<List<dynamic>> getAllTests({String? category, String? search}) async {
    final queryParams = <String, String>{};
    if (category != null) queryParams['category'] = category;
    if (search != null) queryParams['search'] = search;

    final response = await get(
      '/tests',
      queryParams: queryParams.isNotEmpty ? queryParams : null,
    );
    return response['tests'] ?? response['data'] ?? [];
  }

  // Create a test (Admin only)
  Future<Map<String, dynamic>> createTest(Map<String, dynamic> testData) async {
    final response = await post('/tests', testData);
    return response;
  }

  // Get test by ID
  Future<Map<String, dynamic>> getTestById(String id) async {
    final response = await get('/tests/$id');
    return response;
  }

  // Seed sample tests
  Future<Map<String, dynamic>> seedTests() async {
    final response = await post('/tests/seed', {});
    return response;
  }
}
