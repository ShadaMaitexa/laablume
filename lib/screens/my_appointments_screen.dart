import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppointmentsScreen extends StatelessWidget {
  const MyAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: Text(
          'My Appointments',
          style: GoogleFonts.poppins(
            color: const Color(0xFF111827),
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color(0xFFF9FAFB),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF111827), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: 3, // Mock data
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          // Mock Data
          final appointments = [
            {
              'doctor': 'Dr. Sarah Wilson',
              'specialty': 'Cardiologist',
              'date': 'Today, 2:30 PM',
              'type': 'Video Consultation',
              'status': 'Upcoming',
              'color': Colors.blue,
              'image': null
            },
            {
              'doctor': 'Dr. Michael Chen',
              'specialty': 'General Physician',
              'date': 'Jan 15, 10:00 AM',
              'type': 'Clinic Visit',
              'status': 'Confirmed',
              'color': Colors.green,
              'image': null
            },
            {
              'doctor': 'Dr. Emily Davis',
              'specialty': 'Dermatologist',
              'date': 'Dec 28, 09:15 AM',
              'type': 'Follow-up',
              'status': 'Completed',
              'color': Colors.grey,
              'image': null
            },
          ];
          final apt = appointments[index];

          return _buildAppointmentCard(
            doctorName: apt['doctor'] as String,
            specialty: apt['specialty'] as String,
            dateTime: apt['date'] as String,
            type: apt['type'] as String,
            status: apt['status'] as String,
            statusColor: apt['color'] as Color,
          );
        },
      ),
    );
  }

  Widget _buildAppointmentCard({
    required String doctorName,
    required String specialty,
    required String dateTime,
    required String type,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF12B8A6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.person_rounded, color: Color(0xFF12B8A6), size: 30),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctorName,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF111827),
                      ),
                    ),
                    Text(
                      specialty,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: const Color(0xFF6B7280),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.calendar_event_rounded, size: 18, color: Color(0xFF6B7280)),
                    const SizedBox(width: 8),
                    Text(
                      dateTime,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF374151),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      type.contains('Video') ? Icons.videocam_rounded : Icons.location_on_rounded, 
                      size: 18, 
                      color: const Color(0xFF6B7280)
                    ),
                    const SizedBox(width: 8),
                    Text(
                      type,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF374151),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: Color(0xFFE5E7EB)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    'Reschedule', 
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, 
                      color: const Color(0xFF374151)
                    )
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF12B8A6),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: Text(
                    'Join Call', // Dynamic based on type
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, 
                      color: Colors.white
                    )
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
