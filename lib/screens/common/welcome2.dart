import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laablume/screens/common/welcome3.dart';

class Welcome2 extends StatelessWidget {
  const Welcome2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF8F6),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),

            // Illustration
            Image.asset(
              'assets/welcome2.png',
              width: 260,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 28),

            // Page Indicators (2nd active)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _indicator(isActive: false),
                const SizedBox(width: 6),
                _indicator(isActive: true),
                const SizedBox(width: 6),
                _indicator(isActive: false),
              ],
            ),

            const SizedBox(height: 26),

            // Title
            Text(
              'Here for You, Always',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
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
                'Save your test results, access prescriptions, get medication delivered, manage appointments — all in one place.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  height: 1.5,
                  color: Color(0xFF6B7280),
                ),
              ),
            ),

            const SizedBox(height: 36),

            // Get Started Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Welcome3()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF12B8A6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 0,
                  ),
                  child:  Text(
                    'Get started',
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

  // Indicator visible only inside this file
  Widget _indicator({required bool isActive}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: isActive ? 24 : 16,
      height: 4,
      decoration: BoxDecoration(
        color: isActive
            ? const Color(0xFF12B8A6)
            : const Color(0xFFBFEDEA),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
