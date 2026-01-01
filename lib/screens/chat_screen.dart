import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // ---------- API CALL ----------
  Future<List<MessageModel>> fetchConversations() async {
    // TODO: Replace with real API call
    await Future.delayed(const Duration(seconds: 1));
    
    return [
      MessageModel(
        id: '1',
        name: 'Dr. Sarah Wilson',
        lastMessage: 'Your test results look good. Let\'s schedule a follow-up.',
        time: '2:30 PM',
        unread: true,
        avatarUrl: null,
      ),
      MessageModel(
        id: '2', 
        name: 'Dr. Michael Chen',
        lastMessage: 'Please take the medication twice daily.',
        time: '11:45 AM',
        unread: false,
        avatarUrl: null,
      ),
      MessageModel(
        id: '3',
        name: 'Dr. Emily Davis',
        lastMessage: 'Your appointment is confirmed for tomorrow.',
        time: '9:15 AM',
        unread: true,
        avatarUrl: null,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF7F6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              // -------- Title --------
              Text(
                'Messages',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 24),

              // -------- Search --------
              Container(
                height: 46,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search conversations...',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 13,
                            color: const Color(0xFF9CA3AF),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Color(0xFF12B8A6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // -------- Conversations List --------
              Expanded(
                child: FutureBuilder<List<MessageModel>>(
                  future: fetchConversations(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return _emptyState('No conversations yet');
                    }

                    final conversations = snapshot.data!;
                    
                    return ListView.separated(
                      itemCount: conversations.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final conversation = conversations[index];
                        return _conversationItem(conversation);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 100), // Space for floating bottom nav
            ],
          ),
        ),
      ),
    );
  }

  // ---------- EMPTY STATE ----------
  Widget _emptyState(String text) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: const Color(0xFF9CA3AF),
        ),
      ),
    );
  }

  // ---------- CONVERSATION ITEM ----------
  Widget _conversationItem(MessageModel conversation) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.grey.shade300,
            backgroundImage: conversation.avatarUrl != null
                ? NetworkImage(conversation.avatarUrl!)
                : null,
            child: conversation.avatarUrl == null
                ? const Icon(Icons.person)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        conversation.name,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      conversation.time,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        conversation.lastMessage,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF6B7280),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (conversation.unread)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFF12B8A6),
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =================================================
// MODEL (API READY)
// =================================================
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
