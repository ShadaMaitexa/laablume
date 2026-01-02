import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:laablume/screens/patient_card.dart';
import 'package:laablume/screens/auth/login.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _agreedToPolicy = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF8F6),
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3,
            left: MediaQuery.of(context).size.width * -0.2,
            child: Opacity(
              opacity: 0.15,
              child: Image.asset(
                'assets/dna_bg.png',
                width: MediaQuery.of(context).size.width * 1.3,
                height: MediaQuery.of(context).size.height * 0.4,
                fit: BoxFit.contain,
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 48),

                  // Title
                  Text(
                    'Sign Up',
                    style: GoogleFonts.poppins(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF12B8A6),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Subtitle
                  Text(
                    'Hello, we guess you are new here. You can start\nusing the application after sign up',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      height: 1.5,
                      color: const Color(0xFF6B7280),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Username
                  _premiumInputField(
                    icon: Icons.person_outline,
                    hint: 'User Name',
                  ),

                  const SizedBox(height: 16),

                  // Phone
                  _premiumPhoneField(),

                  const SizedBox(height: 16),

                  // Email
                  _premiumInputField(
                    icon: Icons.email_outlined,
                    hint: 'Email Address',
                  ),

                  const SizedBox(height: 16),

                  // Password
                  _premiumInputField(
                    icon: Icons.lock_outline,
                    hint: 'Password',
                    obscure: true,
                  ),

                  const SizedBox(height: 20),

                  // Privacy policy
                  GestureDetector(
                    onTap: () => setState(() => _agreedToPolicy = !_agreedToPolicy),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _agreedToPolicy,
                          onChanged: (v) => setState(() => _agreedToPolicy = v!),
                          activeColor: const Color(0xFF12B8A6),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: const Color(0xFF6B7280),
                              ),
                              children: [
                                const TextSpan(text: 'I have read the '),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFF12B8A6),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Sign up button
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {
                        if (!_agreedToPolicy) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please accept the Privacy Policy')),
                          );
                          return;
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PersonalDataScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF12B8A6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(27),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Footer
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: const Color(0xFF6B7280),
                        ),
                        children: [
                          const TextSpan(text: 'Already have an account? '),
                          TextSpan(
                            text: 'Login Now',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF12B8A6),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _premiumInputField({
    required IconData icon,
    required String hint,
    bool obscure = false,
  }) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF12B8A6).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF12B8A6), size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              obscureText: obscure,
              style: GoogleFonts.poppins(fontSize: 14),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: GoogleFonts.poppins(fontSize: 14, color: const Color(0xFF9CA3AF)),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _premiumPhoneField() {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF12B8A6).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Text('🇮🇳', style: TextStyle(fontSize: 20)),
          const SizedBox(width: 8),
          const Text('+91', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          const VerticalDivider(indent: 12, endIndent: 12, width: 24),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.phone,
              style: GoogleFonts.poppins(fontSize: 14),
              decoration: InputDecoration(
                hintText: '81290 83932',
                hintStyle: GoogleFonts.poppins(fontSize: 14, color: const Color(0xFF9CA3AF)),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
