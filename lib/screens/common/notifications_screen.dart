import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data based on DFD processes
    final notifications = [
      {
        'title': 'Appointment Confirmed',
        'message': 'Your consultation with Dr. Smith is confirmed for tomorrow at 10:00 AM.',
        'time': '2 hours ago',
        'type': 'booking',
        'isRead': false,
      },
      {
        'title': 'AI Report Ready',
        'message': 'Your Blood Test analysis is complete. Check your reports section.',
        'time': '5 hours ago',
        'type': 'report',
        'isRead': true,
      },
      {
        'title': 'Prescription Added',
        'message': 'Dr. Sarah updated your consultation records with a new prescription.',
        'time': 'Yesterday',
        'type': 'general',
        'isRead': true,
      },
      {
        'title': 'Health Alert',
        'message': 'Your hydration level has been low for 3 consecutive days.',
        'time': '2 days ago',
        'type': 'alert',
        'isRead': true,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: GoogleFonts.poppins(
            color: const Color(0xFF111827),
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        backgroundColor: const Color(0xFFF9FAFB),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF111827), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Mark all read',
              style: GoogleFonts.poppins(
                color: const Color(0xFF12B8A6),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final notify = notifications[index];
          return _notificationCard(notify);
        },
      ),
    );
  }

  Widget _notificationCard(Map<String, dynamic> notify) {
    Color iconColor;
    IconData iconData;

    switch (notify['type']) {
      case 'booking':
        iconColor = Colors.blue;
        iconData = Icons.calendar_today_rounded;
        break;
      case 'report':
        iconColor = const Color(0xFF12B8A6);
        iconData = Icons.description_outlined;
        break;
      case 'alert':
        iconColor = Colors.orange;
        iconData = Icons.warning_amber_rounded;
        break;
      default:
        iconColor = Colors.grey;
        iconData = Icons.notifications_none_rounded;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: notify['isRead'] ? null : Border.all(color: const Color(0xFF12B8A6).withOpacity(0.3), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(iconData, color: iconColor, size: 24),
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
                      notify['title'],
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF111827),
                      ),
                    ),
                    Text(
                      notify['time'],
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: const Color(0xFF9CA3AF),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  notify['message'],
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: const Color(0xFF6B7280),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
