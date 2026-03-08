import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'screens/common/splash_screen.dart';
import 'providers/patient_provider.dart';
import 'providers/user_provider.dart';
import 'screens/reports/report_detail_screen.dart';
import 'models/report_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final userProvider = UserProvider();
  await userProvider.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PatientProvider()),
        ChangeNotifierProvider.value(value: userProvider),
      ],
      child: const LabLumeApp(),
    ),
  );
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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF12B8A6)),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      onGenerateRoute: (settings) {
        if (settings.name == '/report-detail') {
          final report = settings.arguments as Report;
          return MaterialPageRoute(
            builder: (context) => ReportDetailScreen(report: report),
          );
        }
        return null;
      },
      home: const SplashScreen(),
    );
  }
}
