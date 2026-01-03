import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'prescriptions/prescriptions_screen.dart'; // Will be created next
import 'reports/lab_reports_screen.dart';
import 'reports/upload_report_screen.dart';

class MedicalRecordsScreen extends StatefulWidget {
  const MedicalRecordsScreen({super.key});

  @override
  State<MedicalRecordsScreen> createState() =>
      _MedicalRecordsScreenState();
}

class _MedicalRecordsScreenState extends State<MedicalRecordsScreen> {
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Medical Records',
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF111827),
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                       Text(
                        'Manage your health history',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                  _iconButton(Icons.add_circle_outline_rounded),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // -------- Grid --------
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.9,
                children: [
                  _RecordCard(
                    icon: Icons.medication_outlined,
                    title: 'Prescriptions',
                    subtitle: '12 active medicines',
                    color: const Color(0xFF3B82F6),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PrescriptionsScreen(),
                        ),
                      );
                    },
                  ),
                  _RecordCard(
                    icon: Icons.description_outlined,
                    title: 'Lab Reports',
                    subtitle: '4 reports analyzed',
                    color: const Color(0xFF12B8A6),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LabReportsScreen(),
                        ),
                      );
                    },
                  ),
                  _RecordCard(
                    icon: Icons.monitor_heart_outlined,
                    title: 'Health Metrics',
                    subtitle: 'Heart, Weight, Sleep',
                    color: const Color(0xFFEC4899),
                    onTap: () {
                      // TODO: Navigate to health metrics screen
                    },
                  ),
                  _RecordCard(
                    icon: Icons.upload_file_outlined,
                    title: 'Quick Upload',
                    subtitle: 'Fast scan & analyze',
                    color: const Color(0xFFF59E0B),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UploadReportScreen(),
                        ),
                      );
                    },
                  ),
                  _RecordCard(
                    icon: Icons.vaccines_outlined,
                    title: 'Vaccinations',
                    subtitle: 'Immunization history',
                    color: const Color(0xFF10B981),
                    onTap: () {},
                  ),
                  _RecordCard(
                    icon: Icons.history_edu_outlined,
                    title: 'Medical History',
                    subtitle: 'Chronic conditions',
                    color: const Color(0xFF8B5CF6),
                    onTap: () {},
                  ),
                ],
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
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(
        onPressed: () {},
        icon: Icon(icon, size: 24, color: const Color(0xFF111827)),
        padding: EdgeInsets.zero,
      ),
    );
  }
}

// =================================================
// RECORD CARD
// =================================================
class _RecordCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback? onTap;

  const _RecordCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF111827).withOpacity(0.04),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF6B7280),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
