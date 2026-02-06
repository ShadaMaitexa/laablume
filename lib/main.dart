import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import 'screens/main_navigation_screen.dart';
import 'screens/web/doctor_portal/doctor_dashboard.dart';
import 'screens/web/lab_portal/lab_dashboard.dart';
import 'screens/web/common/landing_page.dart';
import 'screens/web/common/unified_signup_screen.dart';
import 'screens/common/splash_screen.dart';
import 'providers/patient_provider.dart';

void main() {
  runApp(const LabLumeApp());
}

class LabLumeApp extends StatelessWidget {
  const LabLumeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PatientProvider()),
      ],
      child: MaterialApp(
        title: 'LabLume',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFEFF7F6),
          primaryColor: const Color(0xFF12B8A6),
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF12B8A6)),
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        // Automatically detect platform or show selector for development
        home: const PlatformSelector(),
      ),
    );
  }
}

class PlatformSelector extends StatelessWidget {
  const PlatformSelector({super.key});

  @override
  Widget build(BuildContext context) {
    // If running on Mobile (non-web), lead directly to the Patient-only experience
    if (!kIsWeb) {
      return const SplashScreen();
    }

    // If running on Web, show the professional Landing Page with role-based entry
    return const LandingPage();
  }
}

