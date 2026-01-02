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
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            // -------- Header --------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Messages',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF111827),
                    ),
                  ),
                  _iconButton(Icons.edit_note_rounded),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // -------- Search --------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF111827).withOpacity(0.04),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search_rounded, color: Color(0xFF9CA3AF), size: 22),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search conversations...',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 14,
                            color: const Color(0xFF9CA3AF),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // -------- Conversations List --------
            Expanded(
              child: FutureBuilder<List<MessageModel>>(
                future: fetchConversations(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF12B8A6),
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return _emptyState('No conversations yet');
                  }

                  final conversations = snapshot.data!;
                  
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: conversations.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
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
    );
  }

  Widget _iconButton(IconData icon) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: IconButton(
        onPressed: () {},
        icon: Icon(icon, size: 24, color: const Color(0xFF111827)),
        padding: EdgeInsets.zero,
      ),
    );
  }

  // ---------- EMPTY STATE ----------
  Widget _emptyState(String text) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.chat_bubble_outline_rounded, size: 48, color: Colors.grey.shade400),
          ),
          const SizedBox(height: 20),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF111827),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- CONVERSATION ITEM ----------
  Widget _conversationItem(MessageModel conversation) {
    return GestureDetector(
      onTap: () {
        // Navigate to chat detail
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF111827).withOpacity(0.02),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color(0xFF12B8A6).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    image: conversation.avatarUrl != null
                        ? DecorationImage(
                            image: NetworkImage(conversation.avatarUrl!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: conversation.avatarUrl == null
                      ? const Icon(Icons.person_rounded, color: Color(0xFF12B8A6), size: 28)
                      : null,
                ),
                if (conversation.unread)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: const Color(0xFF12B8A6),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        conversation.name,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: conversation.unread ? FontWeight.w700 : FontWeight.w600,
                          color: const Color(0xFF111827),
                        ),
                      ),
                      Text(
                        conversation.time,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: conversation.unread ? FontWeight.w600 : FontWeight.w400,
                          color: conversation.unread ? const Color(0xFF12B8A6) : const Color(0xFF9CA3AF),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    conversation.lastMessage,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: conversation.unread ? const Color(0xFF1F2937) : const Color(0xFF6B7280),
                      fontWeight: conversation.unread ? FontWeight.w500 : FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
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
