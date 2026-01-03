import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'prescriptions/prescriptions_screen.dart';
import 'reports/lab_reports_screen.dart';
import 'health_metrics/health_metrics_screen.dart';
import 'visit_summaries/visit_summaries_screen.dart';

import '../utils/responsive_layout.dart';

class MedicalRecordsScreen extends StatefulWidget {
  const MedicalRecordsScreen({super.key});

  @override
  State<MedicalRecordsScreen> createState() => _MedicalRecordsScreenState();
}

class _MedicalRecordsScreenState extends State<MedicalRecordsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF7F6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveLayout.isDesktop(context) ? 80 : 24,
            vertical: 24,
          ),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  
                  Text(
                    'Medical records',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1F2937),
                      letterSpacing: -0.5,
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: ResponsiveLayout.isMobile(context) ? 2 : 4,
                    mainAxisSpacing: 32,
                    crossAxisSpacing: 20,
                    childAspectRatio: 0.85,
                    children: [
                      _MedicalRecordCard(
                        icon: Icons.medication_outlined,
                        title: 'Prescriptions',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const PrescriptionsScreen()),
                          );
                        },
                      ),
                      _MedicalRecordCard(
                        icon: Icons.biotech_outlined,
                        title: 'Lab reports',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LabReportsScreen()),
                          );
                        },
                      ),
                      _MedicalRecordCard(
                        icon: Icons.show_chart_rounded,
                        title: 'Health metrics',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const HealthMetricsScreen()),
                          );
                        },
                      ),
                      _MedicalRecordCard(
                        icon: Icons.assignment_outlined,
                        title: 'Visit summaries',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const VisitSummariesScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MedicalRecordCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _MedicalRecordCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        // The main card
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 44,
                  color: const Color(0xFF12B8A6),
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF4B5563),
                  ),
                ),
                const SizedBox(height: 20), // Extra space for the button
              ],
            ),
          ),
        ),
        
        // The floating arrow button
        Positioned(
          bottom: -20,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF12B8A6),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF12B8A6).withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.north_east_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
