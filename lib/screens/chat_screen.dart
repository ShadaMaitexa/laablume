import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/message_service.dart';
import '../utils/responsive_layout.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Fetch conversations — the backend chat endpoint is per-bookingId.
  // A future /api/chat/list endpoint would populate this list.
  Future<List<MessageModel>> fetchConversations() async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      return [];
    } catch (_) {
      return [];
    }
  }

  MessageModel? _selectedMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: ResponsiveLayout(
          mobile: _buildList(context),
          tablet: _buildSplitView(context),
          desktop: _buildSplitView(context),
        ),
      ),
    );
  }

  Widget _buildSplitView(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 400, child: _buildList(context)),
        const VerticalDivider(width: 1, color: Color(0xFFE5E7EB)),
        Expanded(
          child: _selectedMessage == null
              ? _emptyState('Select a conversation to start chatting')
              : _buildChatDetail(_selectedMessage!),
        ),
      ],
    );
  }

  Widget _buildList(BuildContext context) {
    return Column(
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
                const Icon(
                  Icons.search_rounded,
                  color: Color(0xFF9CA3AF),
                  size: 22,
                ),
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
                  child: CircularProgressIndicator(color: Color(0xFF12B8A6)),
                );
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return _emptyState('No conversations yet');
              }

              final conversations = snapshot.data!;

              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: conversations.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final conversation = conversations[index];
                  return _conversationItem(conversation);
                },
              );
            },
          ),
        ),
        if (!ResponsiveLayout.isDesktop(context)) const SizedBox(height: 100),
      ],
    );
  }

  Widget _buildChatDetail(MessageModel message) {
    return Column(
      children: [
        // Chat Header
        Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB))),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xFF12B8A6).withOpacity(0.1),
                child: const Icon(
                  Icons.person_rounded,
                  color: Color(0xFF12B8A6),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                message.name,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF111827),
                ),
              ),
            ],
          ),
        ),
        // Chat Body Placeholder
        Expanded(
          child: Center(
            child: Text(
              'Chat with ${message.name}\n(Messages integration ready)',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(color: Colors.grey),
            ),
          ),
        ),
        // Chat Input
        Container(
          padding: const EdgeInsets.all(24),
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF12B8A6),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.send_rounded, color: Colors.white),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ],
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
            child: Icon(
              Icons.chat_bubble_outline_rounded,
              size: 48,
              color: Colors.grey.shade400,
            ),
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
    bool isSelected = _selectedMessage?.id == conversation.id;
    return GestureDetector(
      onTap: () {
        if (ResponsiveLayout.isDesktop(context)) {
          setState(() {
            _selectedMessage = conversation;
          });
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatDetailScreen(message: conversation),
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF12B8A6).withOpacity(0.05)
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? Border.all(color: const Color(0xFF12B8A6), width: 1.5)
              : null,
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
                      ? const Icon(
                          Icons.person_rounded,
                          color: Color(0xFF12B8A6),
                          size: 28,
                        )
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
                          fontWeight: conversation.unread
                              ? FontWeight.w700
                              : FontWeight.w600,
                          color: const Color(0xFF111827),
                        ),
                      ),
                      Text(
                        conversation.time,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: conversation.unread
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: conversation.unread
                              ? const Color(0xFF12B8A6)
                              : const Color(0xFF9CA3AF),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    conversation.lastMessage,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: conversation.unread
                          ? const Color(0xFF1F2937)
                          : const Color(0xFF6B7280),
                      fontWeight: conversation.unread
                          ? FontWeight.w500
                          : FontWeight.w400,
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

class ChatDetailScreen extends StatefulWidget {
  final MessageModel message;
  const ChatDetailScreen({super.key, required this.message});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final MessageService _messageService = MessageService();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Map<String, dynamic>> _messages = [];
  bool _isLoading = true;
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadMessages() async {
    try {
      final data = await _messageService.getChatHistory(widget.message.id);
      if (mounted) {
        setState(() {
          _messages = data
              .map((m) => m is Map<String, dynamic> ? m : <String, dynamic>{})
              .toList();
          _isLoading = false;
        });
        _scrollToBottom();
      }
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty || widget.message.isChatExpired) return;

    _messageController.clear();
    setState(() {
      _isSending = true;
      _messages.add({
        'content': text,
        'isMe': true,
        'timestamp': DateTime.now().toIso8601String(),
      });
    });
    _scrollToBottom();

    try {
      await _messageService.sendMessage({
        'bookingId': widget.message.id,
        'content': text,
      });
    } catch (_) {
      // Message was optimistically added; silently fail or show a retry indicator
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF111827),
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: const Color(0xFF12B8A6).withOpacity(0.1),
              child: const Icon(
                Icons.person_rounded,
                color: Color(0xFF12B8A6),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.message.name,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF111827),
                    ),
                  ),
                  Text(
                    widget.message.isChatExpired ? 'Chat Expired' : 'Active',
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: widget.message.isChatExpired
                          ? Colors.red
                          : const Color(0xFF12B8A6),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam_rounded, color: Color(0xFF12B8A6)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Starting video consultation...')),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Color(0xFF12B8A6)),
                  )
                : _messages.isEmpty
                ? Center(
                    child: Text(
                      'No messages yet. Start the conversation!',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF9CA3AF),
                      ),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(24),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final msg = _messages[index];
                      final isMe =
                          msg['isMe'] as bool? ?? msg['sender'] == 'patient';
                      final content =
                          msg['content'] as String? ??
                          msg['message'] as String? ??
                          '';
                      final time = msg['timestamp'] != null
                          ? _formatTime(msg['timestamp'])
                          : '';
                      return _buildMessageBubble(
                        message: content,
                        isMe: isMe,
                        time: time,
                      );
                    },
                  ),
          ),
          if (widget.message.isChatExpired)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.red.withOpacity(0.05),
              child: Text(
                'This chat has expired (7 days post-appointment). Please book a new consultation.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.red.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          else
            _buildChatInput(context),
        ],
      ),
    );
  }

  String _formatTime(String isoString) {
    try {
      final dt = DateTime.parse(isoString).toLocal();
      final h = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
      final m = dt.minute.toString().padLeft(2, '0');
      final ampm = dt.hour >= 12 ? 'PM' : 'AM';
      return '$h:$m $ampm';
    } catch (_) {
      return '';
    }
  }

  Widget _buildMessageBubble({
    required String message,
    required bool isMe,
    required String time,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            constraints: const BoxConstraints(maxWidth: 280),
            decoration: BoxDecoration(
              color: isMe ? const Color(0xFF12B8A6) : Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: Radius.circular(isMe ? 20 : 0),
                bottomRight: Radius.circular(isMe ? 0 : 20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              message,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: isMe ? Colors.white : const Color(0xFF1F2937),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (time.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              time,
              style: GoogleFonts.poppins(
                fontSize: 10,
                color: const Color(0xFF9CA3AF),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildChatInput(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.description_outlined,
              color: Color(0xFF12B8A6),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Viewing prescription...')),
              );
            },
            tooltip: 'View Prescription',
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _messageController,
                style: GoogleFonts.poppins(fontSize: 14),
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _sendMessage(),
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: GoogleFonts.poppins(
                    color: const Color(0xFF9CA3AF),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF12B8A6),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: _isSending
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
              onPressed: _isSending ? null : _sendMessage,
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
  final DateTime appointmentDate;

  MessageModel({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    this.unread = false,
    this.avatarUrl,
    required this.appointmentDate,
  });

  bool get isChatExpired {
    final now = DateTime.now();
    final difference = now.difference(appointmentDate).inDays;
    return difference > 7;
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      name: json['name'],
      lastMessage: json['last_message'],
      time: json['time'],
      unread: json['unread'] ?? false,
      avatarUrl: json['avatar'],
      appointmentDate: json['appointment_date'] != null
          ? DateTime.parse(json['appointment_date'])
          : DateTime.now().subtract(const Duration(days: 3)),
    );
  }
}
