import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laablume/screens/common/welcome2.dart';

class Welcome1 extends StatelessWidget {
  const Welcome1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF8F6),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),

            // Illustration Image
            Image.asset(
              'assets/welcome1.png',
              width: 260,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 32),

            // Page Indicator (single active bar)
            Container(
              width: 32,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFF12B8A6),
                borderRadius: BorderRadius.circular(4),
              ),
            ),

            const SizedBox(height: 28),

            // Title
            const Text(
              'Healthcare Made Easy',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Color(0xFF12B8A6),
              ),
            ),

            const SizedBox(height: 10),

            // Subtitle
           Padding(
              padding: EdgeInsets.symmetric(horizontal: 36),
              child: Text(
                'Choose from a wide range of specialists and book appointments with ease. Personalized care is just a click away.',
                textAlign: TextAlign.center,
                style:GoogleFonts.poppins(
                  fontSize: 13,
                  height: 1.5,
                  color: Color(0xFF6B7280),
                ),
              ),
            ),

            const SizedBox(height: 36),

            // Next Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => const Welcome2()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF12B8A6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Next',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
