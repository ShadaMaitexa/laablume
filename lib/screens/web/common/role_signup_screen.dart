import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'role_login_screen.dart';
import '../../../services/auth_service.dart';

class RoleSignupScreen extends StatefulWidget {
  final String role; // 'Doctor' or 'Lab'
  const RoleSignupScreen({super.key, required this.role});

  @override
  State<RoleSignupScreen> createState() => _RoleSignupScreenState();
}

class _RoleSignupScreenState extends State<RoleSignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _selectedCountryCode = '+91';
  bool _agreedToTerms = false;
  bool _isLoading = false;

  final Color _primaryColor = const Color(0xFF12B8A6);

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  String _getNameLabel() {
    switch (widget.role) {
      case 'Doctor':
        return 'Full Name';
      case 'Lab':
        return 'Laboratory Name';
      case 'Hospital':
        return 'Hospital Name';

      default:
        return 'Name';
    }
  }

  String _getNameHint() {
    switch (widget.role) {
      case 'Doctor':
        return 'e.g. Dr. Sarah Wilson';
      case 'Lab':
        return 'e.g. Kochi Central Lab';
      case 'Hospital':
        return 'e.g. St. Mary Medical Center';

      default:
        return 'Enter name';
    }
  }

  void _handleSignup() async {
    // Validate inputs
    if (_nameController.text.trim().isEmpty) {
      _showSnackBar('Please enter your ${_getNameLabel()}', isError: true);
      return;
    }

    if (_phoneController.text.trim().isEmpty ||
        _phoneController.text.trim().length < 10) {
      _showSnackBar('Please enter a valid mobile number', isError: true);
      return;
    }

    if (_emailController.text.trim().isEmpty ||
        !_emailController.text.contains('@')) {
      _showSnackBar('Please enter a valid email address', isError: true);
      return;
    }

    if (!_agreedToTerms) {
      _showSnackBar('Please accept the Terms & Conditions', isError: true);
      return;
    }

    setState(() => _isLoading = true);

    final mobileNumber = '$_selectedCountryCode${_phoneController.text.trim()}';

    try {
      // Call signup API
      await AuthService().signup(
        name: _nameController.text.trim(),
        phone: mobileNumber,
        email: _emailController.text.trim(),
        role: widget.role.toLowerCase(),
      );

      if (mounted) {
        setState(() => _isLoading = false);

        // Show success message
        _showSnackBar(
          'Account created successfully! Please login.',
          isError: false,
        );

        // Redirect to login screen after a short delay
        await Future.delayed(const Duration(seconds: 1));

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => RoleLoginScreen(role: widget.role),
            ),
          );
        }
      }
    } catch (e) {
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
                              'Join as ${widget.role}',
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

          // Right Side: Signup Form
          Expanded(
            flex: 1,
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 450),
                  padding: const EdgeInsets.all(48),
                  margin: const EdgeInsets.symmetric(vertical: 24),
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
                        'Create Account',
                        style: GoogleFonts.poppins(
                          fontSize: isDesktop ? 28 : 24,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Register your ${widget.role.toLowerCase()} account to get started.',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Name Field
                      Text(
                        _getNameLabel(),
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: _getNameHint(),
                          prefixIcon: const Icon(
                            Icons.person_outline,
                            size: 20,
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF9FAFB),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                      const SizedBox(height: 20),

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
                                  hintText: 'Enter phone number',
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
                      const SizedBox(height: 20),

                      // Email Field
                      Text(
                        'Email Address',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: widget.role == 'Doctor'
                              ? 'doctor@example.com'
                              : 'lab@example.com',
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            size: 20,
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF9FAFB),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),

                      const SizedBox(height: 24),

                      // Terms & Conditions
                      GestureDetector(
                        onTap: () =>
                            setState(() => _agreedToTerms = !_agreedToTerms),
                        child: Row(
                          children: [
                            Checkbox(
                              value: _agreedToTerms,
                              onChanged: (v) =>
                                  setState(() => _agreedToTerms = v!),
                              activeColor: _primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    color: const Color(0xFF6B7280),
                                  ),
                                  children: [
                                    const TextSpan(text: 'I agree to the '),
                                    TextSpan(
                                      text: 'Terms & Conditions',
                                      style: GoogleFonts.poppins(
                                        color: _primaryColor,
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

                      // Signup Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleSignup,
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
                                  'Create Account',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Login Link
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    RoleLoginScreen(role: widget.role),
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
                                const TextSpan(
                                  text: 'Already have an account? ',
                                ),
                                TextSpan(
                                  text: 'Login Now',
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
