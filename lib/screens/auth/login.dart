import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laablume/screens/auth/otp_screen.dart';
import 'package:laablume/screens/auth/register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String selectedCountryCode = '+91';
  final TextEditingController phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void _validateAndProceed() {
    if (phoneController.text.trim().isEmpty) {
      _showSnackBar('Please enter your phone number');
      return;
    }

    if (phoneController.text.trim().length < 10) {
      _showSnackBar('Please enter a valid phone number');
      return;
    }

    // Set loading state
    setState(() {
      _isLoading = true;
    });

    // Simulate API call for sending OTP
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        
        // Navigate to OTP screen
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => const OtpScreen(),
          ),
        );
      }
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF8F6),
      body: Stack(
        children: [
          // DNA Background
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),

                  // Title
                  Text(
                    'Sign in',
                    style: GoogleFonts.poppins(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF12B8A6),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Subtitle
                  Text(
                    'Welcome to Lab Lume, you\'re in one\nstep to connecting healthcare',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      height: 1.5,
                      color: const Color(0xFF6B7280),
                    ),
                  ),

                  const SizedBox(height: 76),

                  // Mobile label
                  Text(
                    'Mobile number',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Phone input with country dropdown
                  Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFF12B8A6),),
                     ),
                    
                    child: Row(
                      children: [
                        DropdownButton<String>(
                          value: selectedCountryCode,
                          items: const [
                            DropdownMenuItem(
                              value: '+91',
                              child: Text('🇮🇳 +91'),
                            ),
                            DropdownMenuItem(
                              value: '+1',
                              child: Text('🇺🇸 +1'),
                            ),
                            DropdownMenuItem(
                              value: '+44',
                              child: Text('🇬🇧 +44'),
                            ),
                            DropdownMenuItem(
                              value: '+86',
                              child: Text('🇨🇳 +86'),
                            ),
                            DropdownMenuItem(
                              value: '+81',
                              child: Text('🇯🇵 +81'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() => selectedCountryCode = value!);
                          },
                          underline: const SizedBox(),
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),

                        const VerticalDivider(
                          width: 20,
                          thickness: 1,
                          color:  Color(0xFF12B8A6),
                        ),

                        Expanded(
                          child: TextField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: 'Enter your phone number',
                              hintStyle: GoogleFonts.poppins(
                                color: const Color(0xFF9CA3AF),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 29),

                  // Login button
                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _validateAndProceed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF12B8A6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 0,
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              'Send OTP',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Divider
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'Or sign in with',
                          style: GoogleFonts.poppins(fontSize: 12),
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Social login (IMAGES)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Handle Google sign in
                          _showSnackBar('Google sign in coming soon!');
                        },
                        child: _socialImage('assets/google.png'),
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () {
                          // Handle Apple sign in
                          _showSnackBar('Apple sign in coming soon!');
                        },
                        child: _socialImage('assets/apple.png'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // Register text
                  Center(
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupScreen(),
                        ),
                      ),
                      child: RichText(
                        text: TextSpan(
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: const Color(0xFF6B7280),
                          ),
                          children: [
                            const TextSpan(text: 'New to the app? '),
                            TextSpan(
                              text: 'Register now',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF12B8A6),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Social login button using IMAGE
  Widget _socialImage(String asset) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Image.asset(asset, width: 24, height: 24, fit: BoxFit.contain),
    );
  }
}
