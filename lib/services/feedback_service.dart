import 'api_base_service.dart';

class FeedbackService extends ApiBaseService {
  static final FeedbackService _instance = FeedbackService._internal();
  factory FeedbackService() => _instance;
  FeedbackService._internal();

  // Submit ratings and comments
  Future<Map<String, dynamic>> submitFeedback(Map<String, dynamic> data) async {
    final response = await post('/feedback/submit', data);
    return response;
  }

  // Retrieve reviews for a specific entity (lab, doctor, or hospital)
  Future<List<dynamic>> getEntityReviews(String targetId) async {
    final response = await get('/feedback/$targetId');
    return response['feedback'] ?? response['data'] ?? [];
  }
}
