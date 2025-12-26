import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laablume/screens/common/welcome1.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Welcome1()));
    });
    return Scaffold(
      backgroundColor: const Color(0xFFEAF8F6), 
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Logo
            Image.asset(
              'assets/logo.png',
              width: 96, 
              height: 96,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 12),

             Text(
              'Lab\nLume',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF12B8A6),
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
