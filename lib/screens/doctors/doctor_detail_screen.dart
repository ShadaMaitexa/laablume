import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'find_doctors_screen.dart';
import 'book_consultation_screen.dart';

class DoctorDetailScreen extends StatelessWidget {
  final Doctor doctor;

  const DoctorDetailScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with Doctor Image
                Container(
                  height: 320,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF111827), Color(0xFF1F2937)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      children: [
                        // App Bar
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: const Icon(Icons.favorite_rounded, color: Colors.white, size: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Doctor Avatar
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(color: Colors.white.withOpacity(0.2), width: 4),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: const Icon(Icons.person_rounded, size: 60, color: Color(0xFF12B8A6)),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          doctor.name,
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF12B8A6).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            doctor.specialty,
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF12B8A6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Stats Cards
                      Row(
                        children: [
                          Expanded(
                            child: _statCard(
                              icon: Icons.star_rounded,
                              value: doctor.rating.toString(),
                              label: 'Rating',
                              color: Colors.amber,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _statCard(
                              icon: Icons.work_history_rounded,
                              value: '${doctor.experience}+',
                              label: 'Years Exp.',
                              color: const Color(0xFF12B8A6),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _statCard(
                              icon: Icons.groups_rounded,
                              value: '${doctor.reviewCount}+',
                              label: 'Patients',
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // About
                      _sectionTitle('Biography'),
                      const SizedBox(height: 16),
                      Text(
                        'Dr. ${doctor.name} is a highly accomplished ${doctor.specialty} with over ${doctor.experience} years of experience in providing exceptional medical care. Specializing in advanced diagnostic treatments and patient-centric care.',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: const Color(0xFF6B7280),
                          height: 1.6,
                        ),
                      ),

                      const SizedBox(height: 28),

                      _infoCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _infoRow(Icons.school_rounded, 'Education', doctor.education),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Divider(height: 1, color: Color(0xFFF3F4F6)),
                            ),
                            _infoRow(Icons.local_hospital_rounded, 'Hospital', doctor.hospital),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Divider(height: 1, color: Color(0xFFF3F4F6)),
                            ),
                            _infoRow(
                              Icons.language_rounded,
                              'Languages',
                              doctor.languages.join(', '),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Consultation Options
                      _sectionTitle('Consultation Mode'),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _consultationOption(
                              icon: Icons.videocam_rounded,
                              title: 'Video Call',
                              subtitle: '₹${doctor.consultationFee}',
                              isAvailable: doctor.isOnline,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _consultationOption(
                              icon: Icons.location_on_rounded,
                              title: 'In-Clinic',
                              subtitle: '₹${doctor.consultationFee}',
                              isAvailable: true,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Reviews Section
                      Row(
                        children: [
                          _sectionTitle('Patient Reviews'),
                          const Spacer(),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'See all',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF12B8A6),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _reviewCard(
                        name: 'Emily Thompson',
                        rating: 5.0,
                        date: '2 days ago',
                        comment: 'One of the best experiences I\'ve had with a specialist. Very thorough and patient.',
                      ),
                      const SizedBox(height: 12),
                      _reviewCard(
                        name: 'Marcus Chen',
                        rating: 4.5,
                        date: '1 week ago',
                        comment: 'Very professional and the AI integration to my reports was seamless during the session.',
                      ),

                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Booking Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF111827).withOpacity(0.08),
                    blurRadius: 30,
                    offset: const Offset(0, -10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookConsultationScreen(doctor: doctor),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF12B8A6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Book Appointment',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
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
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: const Color(0xFF111827),
      ),
    );
  }

  Widget _infoCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
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
      ),
      child: child,
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF12B8A6).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: const Color(0xFF12B8A6)),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              const SizedBox(height: 1),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF111827),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _consultationOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isAvailable,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isAvailable ? Colors.white : const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isAvailable
              ? const Color(0xFF12B8A6).withOpacity(0.2)
              : Colors.transparent,
          width: 2,
        ),
        boxShadow: isAvailable ? [
          BoxShadow(
            color: const Color(0xFF111827).withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ] : null,
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 28,
            color: isAvailable
                ? const Color(0xFF12B8A6)
                : const Color(0xFF9CA3AF),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: isAvailable ? const Color(0xFF111827) : const Color(0xFF9CA3AF),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isAvailable ? const Color(0xFF12B8A6) : const Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }

  Widget _reviewCard({
    required String name,
    required double rating,
    required String date,
    required String comment,
  }) {
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
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFF12B8A6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    name[0],
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF12B8A6),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        ...List.generate(
                          5,
                          (index) => Icon(
                            index < rating.floor()
                                ? Icons.star_rounded
                                : Icons.star_border_rounded,
                            size: 14,
                            color: Colors.amber,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          date,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF9CA3AF),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            comment,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: const Color(0xFF6B7280),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
