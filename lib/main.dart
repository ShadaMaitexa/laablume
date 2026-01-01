import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'screens/main_navigation_screen.dart';
import 'screens/web/doctor_portal/doctor_dashboard.dart';
import 'screens/web/lab_portal/lab_dashboard.dart';

void main() {
  runApp(const LabLumeApp());
}

class LabLumeApp extends StatelessWidget {
  const LabLumeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LabLume',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEFF7F6),
        primaryColor: const Color(0xFF12B8A6),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      // Automatically detect platform or show selector for development
      home: const PlatformSelector(),
    );
  }
}

class PlatformSelector extends StatelessWidget {
  const PlatformSelector({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return const MainNavigationScreen();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF0F9F8),
      body: Stack(
        children: [
          // Background Aesthetic Decoration
          Positioned(
            top: -100,
            right: -100,
            child: CircleAvatar(radius: 200, backgroundColor: const Color(0xFF12B8A6).withOpacity(0.05)),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: CircleAvatar(radius: 150, backgroundColor: const Color(0xFF12B8A6).withOpacity(0.03)),
          ),
          
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'logo',
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF12B8A6).withOpacity(0.1),
                            blurRadius: 40,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.auto_awesome_rounded, color: Color(0xFF12B8A6), size: 64),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'LabLume Enterprise',
                    style: GoogleFonts.poppins(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF1F2937),
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Precision Diagnostics & Integrated Care Delivery',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 64),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _premiumPortalCard(
                        context,
                        title: 'Patient App',
                        subtitle: 'Multi-platform Mobile Experience',
                        details: 'Self-care diagnostic tools, report analysis, and doctor booking.',
                        icon: Icons.person_search_rounded,
                        color: const Color(0xFF12B8A6),
                        target: const MainNavigationScreen(),
                      ),
                      const SizedBox(width: 32),
                      _premiumPortalCard(
                        context,
                        title: 'Doctor Portal',
                        subtitle: 'Clinical Decision Terminal',
                        details: 'Electronic health records, AI-driven insights, and telehealth.',
                        icon: Icons.medical_information_rounded,
                        color: const Color(0xFF3B82F6),
                        target: const DoctorWebDashboard(),
                      ),
                      const SizedBox(width: 32),
                      _premiumPortalCard(
                        context,
                        title: 'Lab Portal',
                        subtitle: 'Intelligence Operations',
                        details: 'High-throughput tracking, sample analysis, and validation.',
                        icon: Icons.biotech_rounded,
                        color: const Color(0xFFF59E0B),
                        target: const LabWebDashboard(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 80),
                  Text(
                    '© 2026 LabLume Systems. All rights reserved.',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF9CA3AF),
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

  Widget _premiumPortalCard(BuildContext context, {
    required String title,
    required String subtitle,
    required String details,
    required IconData icon,
    required Color color,
    required Widget target,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => target)),
        child: Container(
          width: 280,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(height: 28),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                details,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  height: 1.6,
                  color: const Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Text(
                    'Launch Portal',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_rounded, size: 16, color: Color(0xFF1F2937)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

