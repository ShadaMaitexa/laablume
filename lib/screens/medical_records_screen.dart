import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                  Text(
                    'Medical Records',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF111827),
                    ),
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
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.95,
                children: [
                  _RecordCard(
                    icon: Icons.medication_rounded,
                    title: 'Prescriptions',
                    subtitle: '12 active medicines',
                    color: Colors.blue,
                    onTap: () {
                      // TODO: Navigate to prescriptions screen
                    },
                  ),
                  _RecordCard(
                    icon: Icons.description_rounded,
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
                    icon: Icons.monitor_heart_rounded,
                    title: 'Health Metrics',
                    subtitle: 'Heart, Weight, Sleep',
                    color: Colors.pink,
                    onTap: () {
                      // TODO: Navigate to health metrics screen
                    },
                  ),
                  _RecordCard(
                    icon: Icons.upload_file_rounded,
                    title: 'Quick Upload',
                    subtitle: 'Fast scan & analyze',
                    color: Colors.indigo,
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
                    icon: Icons.vaccines_rounded,
                    title: 'Vaccinations',
                    subtitle: 'Immunization history',
                    color: Colors.orange,
                    onTap: () {},
                  ),
                  _RecordCard(
                    icon: Icons.history_edu_rounded,
                    title: 'Medical History',
                    subtitle: 'Chronic conditions',
                    color: Colors.brown,
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
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const Spacer(),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF6B7280),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
