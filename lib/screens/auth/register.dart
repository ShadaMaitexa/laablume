import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laablume/screens/auth/login.dart';
import '../../services/auth_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _agreedToPolicy = false;
  bool _isLoading = false;
  
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _handleSignup() async {
    // Validate inputs
    if (_userNameController.text.trim().isEmpty) {
      _showSnackBar('Please enter your name', isError: true);
      return;
    }

    if (_mobileController.text.trim().isEmpty || _mobileController.text.trim().length < 10) {
      _showSnackBar('Please enter a valid mobile number', isError: true);
      return;
    }

    if (_emailController.text.trim().isEmpty || !_emailController.text.contains('@')) {
      _showSnackBar('Please enter a valid email address', isError: true);
      return;
    }

    if (!_agreedToPolicy) {
      _showSnackBar('Please accept the Privacy Policy', isError: true);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Call signup API
      await AuthService().signup(
        _userNameController.text.trim(),
        '+91${_mobileController.text.trim()}', // Add country code
        _emailController.text.trim(),
      );

      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        // Show success message
        _showSnackBar('Account created successfully! Please login.', isError: false);

        // Redirect to login screen after a short delay
        await Future.delayed(const Duration(seconds: 1));
        
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _showSnackBar(e.toString().replaceAll('Exception: ', ''), isError: true);
      }
    }
  }

  void _showSnackBar(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

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
                    controller: _userNameController,
                  ),

                  const SizedBox(height: 16),

                  // Phone
                  _premiumPhoneField(),

                  const SizedBox(height: 16),

                  // Email
                  _premiumInputField(
                    icon: Icons.email_outlined,
                    hint: 'Email Address',
                    controller: _emailController,
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
                      onPressed: _isLoading ? null : _handleSignup,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF12B8A6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(27),
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
    TextEditingController? controller,
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
              controller: controller,
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
              controller: _mobileController,
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
