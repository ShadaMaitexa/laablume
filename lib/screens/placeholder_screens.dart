import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF8F6),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF111827),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF12B8A6).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.construction_rounded, color: Color(0xFF12B8A6), size: 48),
            ),
            const SizedBox(height: 24),
            Text(
              'Feature Coming Soon',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'We are working hard to bring this to you.',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: const Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF8F6),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off_rounded, size: 80, color: Color(0xFF9CA3AF)),
              const SizedBox(height: 24),
              Text(
                'No internet!',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Check your internet connection and try to login again to the app.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: const Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: 60,
                height: 60,
                child: FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: const Color(0xFF12B8A6),
                  elevation: 0,
                  child: const Icon(Icons.refresh_rounded, color: Colors.white, size: 28),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorStateScreen extends StatelessWidget {
  const ErrorStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF8F6),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline_rounded, size: 80, color: Color(0xFF12B8A6)),
              const SizedBox(height: 24),
              Text(
                'Refresh error',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Something went wrong as you applied updates.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: const Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: 60,
                height: 60,
                child: FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: const Color(0xFF12B8A6),
                  elevation: 0,
                  child: const Icon(Icons.refresh_rounded, color: Colors.white, size: 28),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
