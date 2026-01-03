import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../doctor_portal/doctor_dashboard.dart';
import '../lab_portal/lab_dashboard.dart';

class RoleLoginScreen extends StatefulWidget {
  final String role; // 'Doctor' or 'Lab'
  const RoleLoginScreen({super.key, required this.role});

  @override
  State<RoleLoginScreen> createState() => _RoleLoginScreenState();
}

class _RoleLoginScreenState extends State<RoleLoginScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  final Color _primaryColor = const Color(0xFF12B8A6);

  void _handleLogin() async {
    setState(() => _isLoading = true);
    
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      setState(() => _isLoading = false);
      
      // Role-based navigation
      if (widget.role == 'Doctor') {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const DoctorWebDashboard()),
          (route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LabWebDashboard()),
          (route) => false,
        );
      }
    }
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
                      child: CircleAvatar(radius: 200, backgroundColor: _primaryColor.withOpacity(0.1)),
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
                              child: Image.asset('assets/logo.png', width: 60, height: 60),
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
            child: Center(
              child: Container(
                width: 450,
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
                          child: Image.asset('assets/logo.png', width: 40, height: 40),
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
                      'Provide your credentials to access the ${widget.role.toLowerCase()} portal.',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                    const SizedBox(height: 48),
                    
                    // ID Field
                    Text(
                      'Terminal ID / Email',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _idController,
                      decoration: InputDecoration(
                        hintText: widget.role == 'Doctor' ? 'e.g. DR-SarahWilson' : 'e.g. LAB-KochiCentral',
                        prefixIcon: const Icon(Icons.person_outline, size: 20),
                        filled: true,
                        fillColor: const Color(0xFFF9FAFB),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Password Field
                    Text(
                      'Access Password',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        hintText: '••••••••',
                        prefixIcon: const Icon(Icons.lock_outline, size: 20),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                            size: 20,
                          ),
                          onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF9FAFB),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot Password?',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: _primaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    
                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 0,
                        ),
                        child: _isLoading 
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                          : Text(
                              'Sign In to Terminal',
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
