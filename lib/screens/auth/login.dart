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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF8F6),
      body: Stack(
        children: [
          // DNA Background - Back to original style but properly visible
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
                           
                              hintText: '81290 89332',
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
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder:  (context) => OtpScreen(),));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF12B8A6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Login',
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
                      _socialImage('assets/google.png'),
                      const SizedBox(width: 16),
                      _socialImage('assets/apple.png'),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // Register text
                  Center(
                    child: GestureDetector(onTap: ()=>Navigator.push(
                      context,MaterialPageRoute(builder: (context) => SignupScreen(),)),
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
