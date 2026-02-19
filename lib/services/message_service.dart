import 'api_base_service.dart';

class MessageService extends ApiBaseService {
  static final MessageService _instance = MessageService._internal();
  factory MessageService() => _instance;
  MessageService._internal();

  // Get chat history
  Future<List<dynamic>> getChatHistory(String bookingId) async {
    final response = await get('/chat/$bookingId');
    return response['messages'] ?? response['data'] ?? [];
  }

  // Send a message
  Future<Map<String, dynamic>> sendMessage(
    Map<String, dynamic> messageData,
  ) async {
    final response = await post('/chat/send', messageData);
    return response;
  }
}
