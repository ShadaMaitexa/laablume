import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'role_otp_screen.dart';
import 'role_signup_screen.dart';
import '../../../services/auth_service.dart';
import '../../../services/admin_service.dart';

class RoleLoginScreen extends StatefulWidget {
  final String role; // 'Doctor' or 'Lab'
  const RoleLoginScreen({super.key, required this.role});

  @override
  State<RoleLoginScreen> createState() => _RoleLoginScreenState();
}

class _RoleLoginScreenState extends State<RoleLoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  String _selectedCountryCode = '+91';
  bool _isLoading = false;

  final Color _primaryColor = const Color(0xFF12B8A6);

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _handleSendOTP() async {
    if (_phoneController.text.trim().isEmpty) {
      _showSnackBar('Please enter your phone number', isError: true);
      return;
    }

    if (_phoneController.text.trim().length < 10) {
      _showSnackBar('Please enter a valid phone number', isError: true);
      return;
    }

    setState(() => _isLoading = true);

    // Clear any existing tokens before fresh login
    await AuthService().clearTokens();

    String mobileNumber =
        '$_selectedCountryCode${_phoneController.text.trim()}';

    // For Admin, use the last 10 digits of the raw phone number as per backend expectation
    if (widget.role.toLowerCase() == 'admin') {
      String digits = _phoneController.text.replaceAll(RegExp(r'\D'), '');
      if (digits.length >= 10) {
        mobileNumber = digits.substring(digits.length - 10);
      } else {
        mobileNumber = digits;
      }
    }

    try {
      if (widget.role.toLowerCase() == 'admin') {
        await AdminService().requestOtp(mobileNumber);
      } else {
        await AuthService().requestOtp(mobileNumber);
      }

      if (mounted) {
        setState(() => _isLoading = false);

        // Navigate to OTP screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                RoleOtpScreen(mobileNumber: mobileNumber, role: widget.role),
          ),
        );
      }
    } catch (e) {
      print('RoleLoginScreen Error: $e');
      if (mounted) {
        setState(() => _isLoading = false);
        _showSnackBar(
          e.toString().replaceAll('Exception: ', ''),
          isError: true,
        );
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
    bool isDesktop = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F9F8),
      body: Row(
        children: [
          // Left Side: Branding/Illustration (Desktop only)
          if (isDesktop)
            Expanded(
              flex: 1,
              child: Container(
                color: const Color(0xFF1F2937),
                child: Stack(
                  children: [
                    Positioned(
                      top: -100,
                      left: -100,
                      child: CircleAvatar(
                        radius: 200,
                        backgroundColor: _primaryColor.withOpacity(0.1),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                'assets/logo.png',
                                width: 60,
                                height: 60,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'LabLume Enterprise',
                              style: GoogleFonts.poppins(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Accessing ${widget.role} Secure Terminal',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.white60,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Right Side: Login Form
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 450),
                  padding: const EdgeInsets.all(48),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 30,
                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isDesktop) ...[
                        Center(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: _primaryColor.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              'assets/logo.png',
                              width: 40,
                              height: 40,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                      Text(
                        'Welcome Back',
                        style: GoogleFonts.poppins(
                          fontSize: isDesktop ? 28 : 24,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Enter your mobile number to access the ${widget.role.toLowerCase()} portal.',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                      const SizedBox(height: 48),

                      // Mobile Number Field
                      Text(
                        'Mobile Number',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            // Country Code Dropdown
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: DropdownButton<String>(
                                value: _selectedCountryCode,
                                underline: const SizedBox(),
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
                                  setState(() => _selectedCountryCode = value!);
                                },
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 30,
                              color: const Color(0xFFE5E7EB),
                            ),
                            const SizedBox(width: 12),
                            // Phone Number Input
                            Expanded(
                              child: TextField(
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  hintText: 'Enter your phone number',
                                  hintStyle: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: const Color(0xFF9CA3AF),
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                ),
                                style: GoogleFonts.poppins(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Send OTP Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleSendOTP,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  'Send OTP',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Go Back to Platform Selector',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: const Color(0xFF6B7280),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Signup Link
                      if (widget.role != 'Admin')
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RoleSignupScreen(role: widget.role),
                                ),
                              );
                            },
                            child: RichText(
                              text: TextSpan(
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: const Color(0xFF6B7280),
                                ),
                                children: [
                                  const TextSpan(text: 'New User? '),
                                  TextSpan(
                                    text: 'Register Now',
                                    style: GoogleFonts.poppins(
                                      color: _primaryColor,
                                      fontWeight: FontWeight.w600,
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
            ),
          ),
        ],
      ),
    );
  }
}
