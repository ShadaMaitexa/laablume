import 'api_base_service.dart';

class MessageService extends ApiBaseService {
  static final MessageService _instance = MessageService._internal();
  factory MessageService() => _instance;
  MessageService._internal();

  /// Get chat history. Returns a map with:
  ///   - 'messages': List<dynamic>
  ///   - 'isChatExpired': bool
  ///   - 'chatExpiryDate': String (ISO date)
  Future<Map<String, dynamic>> getChatHistory(String bookingId) async {
    final response = await get('/chat/$bookingId');
    // Handle both old (list) and new (object with messages key) API shapes
    if (response is List) {
      return {'messages': response, 'isChatExpired': false};
    }
    return {
      'messages': response['messages'] ?? [],
      'isChatExpired': response['isChatExpired'] ?? false,
      'chatExpiryDate': response['chatExpiryDate'],
      'appointmentDate': response['appointmentDate'],
    };
  }

  // Send a message
  Future<Map<String, dynamic>> sendMessage(
    Map<String, dynamic> messageData,
  ) async {
    final response = await post('/chat/send', messageData);
    return response;
  }
}
