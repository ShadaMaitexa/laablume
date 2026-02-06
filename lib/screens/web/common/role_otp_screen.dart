import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import '../doctor_portal/doctor_dashboard.dart';
import '../lab_portal/lab_dashboard.dart';
import '../hospital_portal/hospital_dashboard.dart';
import '../admin_portal/admin_dashboard.dart';
import '../../patient_homescreen.dart';
import '../../../services/auth_service.dart';
import '../../../providers/user_provider.dart';
import 'package:provider/provider.dart';

class RoleOtpScreen extends StatefulWidget {
  final String mobileNumber;
  final String role; // 'Doctor' or 'Lab'
  const RoleOtpScreen({super.key, required this.mobileNumber, required this.role});

  @override
  State<RoleOtpScreen> createState() => _RoleOtpScreenState();
}

class _RoleOtpScreenState extends State<RoleOtpScreen> {
  final TextEditingController otpController = TextEditingController();
  final FocusNode _otpFocusNode = FocusNode();
  String? _otpError;
  bool _isVerifying = false;
  int _resendTimer = 0;
  bool _canResend = false;

  final Color _primaryColor = const Color(0xFF12B8A6);

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    otpController.dispose();
    _otpFocusNode.dispose();
    super.dispose();
  }

  void _startResendTimer() {
    _canResend = false;
    _resendTimer = 60;
    setState(() {});
    
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return false;
      
      setState(() {
        _resendTimer--;
      });
      
      if (_resendTimer <= 0) {
        _canResend = true;
        return false;
      }
      return true;
    });
  }

  void _verifyOtp() async {
    if (otpController.text.length != 4) {
      setState(() {
        _otpError = 'Please enter 4-digit OTP';
      });
      return;
    }

    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      await userProvider.login(
        widget.mobileNumber, 
        otpController.text,
        widget.role.toLowerCase(),
      );
      
      if (mounted) {
        setState(() {
          _isVerifying = false;
        });

        final user = userProvider.currentUser;
        if (user != null) {
          // Check role consistency
          if (user.role != widget.role.toLowerCase() && user.role != 'admin') {
             setState(() {
              _otpError = 'Access Denied: You are registered as ${user.role}. Please use the correct portal.';
            });
            return;
          }

          // Success - navigate to dashboard based on role
          switch (widget.role) {
            case 'Patient':
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const PatientHomeScreen()),
                (route) => false,
              );
              break;
            case 'Doctor':
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const DoctorWebDashboard()),
                (route) => false,
              );
              break;
            case 'Lab':
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LabWebDashboard()),
                (route) => false,
              );
              break;
            case 'Hospital':
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const HospitalWebDashboard()),
                (route) => false,
              );
              break;
            case 'Admin':
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const AdminWebPortal()),
                (route) => false,
              );
              break;
          }
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isVerifying = false;
          _otpError = e.toString().replaceAll('Exception: ', '');
        });
        otpController.clear();
      }
    }
  }

  void _resendOtp() async {
    if (!_canResend) return;
    
    try {
      await AuthService().requestOtp(widget.mobileNumber);
      
      _startResendTimer();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('New OTP sent to your phone'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width >= 900;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF1F2937),
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _otpError != null ? Colors.red : const Color(0xFFE5E7EB)),
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF0F9F8),
      body: Row(
        children: [
          // Left Side: Branding (Desktop only)
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
                              'Verifying ${widget.role} Access',
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
          
          // Right Side: OTP Form
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (!isDesktop) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _primaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset('assets/logo.png', width: 40, height: 40),
                      ),
                      const SizedBox(height: 24),
                    ],
                    Text(
                      'Verify OTP',
                      style: GoogleFonts.poppins(
                        fontSize: isDesktop ? 28 : 24,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Enter the 4-digit code sent to',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.mobileNumber,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: _primaryColor,
                      ),
                    ),
                    const SizedBox(height: 48),
                    
                    // OTP Input
                    if (_otpError != null) ...[
                      Text(
                        _otpError!,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    Pinput(
                      controller: otpController,
                      focusNode: _otpFocusNode,
                      length: 4,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          border: Border.all(color: _primaryColor, width: 2),
                        ),
                      ),
                      submittedPinTheme: defaultPinTheme,
                      onCompleted: (pin) {
                        _otpFocusNode.unfocus();
                        _verifyOtp();
                      },
                      onChanged: (pin) {
                        if (_otpError != null) {
                          setState(() {
                            _otpError = null;
                          });
                        }
                      },
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Verify Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _isVerifying ? null : _verifyOtp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 0,
                        ),
                        child: _isVerifying
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                              )
                            : Text(
                                'Verify & Sign In',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Resend OTP
                    Column(
                      children: [
                        Text(
                          "Didn't receive OTP?",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: const Color(0xFF6B7280),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: _canResend ? _resendOtp : null,
                          child: Text(
                            _canResend 
                                ? "Resend OTP" 
                                : "Resend OTP in $_resendTimer s",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: _canResend ? _primaryColor : const Color(0xFF6B7280),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Change Phone Number',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: const Color(0xFF6B7280),
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
