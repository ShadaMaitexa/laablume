class MessageModel {
  final String id;
  final String name;
  final String lastMessage;
  final String time;
  final bool unread;
  final String? avatarUrl;

  MessageModel({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    this.unread = false,
    this.avatarUrl,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      name: json['name'],
      lastMessage: json['last_message'],
      time: json['time'],
      unread: json['unread'] ?? false,
      avatarUrl: json['avatar'],
    );
  }
}
