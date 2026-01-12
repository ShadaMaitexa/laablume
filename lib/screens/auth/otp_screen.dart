import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laablume/screens/patient_card.dart';
import 'package:pinput/pinput.dart';
import '../../services/auth_service.dart';

class OtpScreen extends StatefulWidget {
  final String mobileNumber;
  const OtpScreen({super.key, required this.mobileNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();
  final FocusNode _otpFocusNode = FocusNode();
  String? _otpError;
  bool _isVerifying = false;
  int _resendTimer = 0;
  bool _canResend = false;

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

    setState(() {
      _isVerifying = true;
      _otpError = null;
    });

    try {
      final response = await AuthService().verifyOtp(
        widget.mobileNumber, 
        otpController.text
      );
      
      if (mounted) {
        setState(() {
          _isVerifying = false;
        });
        
        if (response != null) {
          final role = response['role'] ?? 'patient';
          if (role != 'patient') {
            setState(() {
              _otpError = 'This app is for patients only. Please use the Web Portal for $role role.';
            });
            return;
          }

          // Success - navigate to next screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PersonalDataScreen(),
            ),
          );
        } else {
           // Show error
          setState(() {
            _otpError = 'Invalid OTP. Please try again.';
          });
          otpController.clear();
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
    final defaultPinTheme = PinTheme(
      width: 44,
      height: 44,
      textStyle: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF1F2937),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _otpError != null ? Colors.red : const Color(0xFFE5E7EB)),
      ),
    );

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
            child: Column(
              children: [
                const SizedBox(height: 190),

                // Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    "Let's Light Up Your Lab Data\nSecure Entry Awaits!",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                      color: const Color(0xFF111827),
                    ),
                  ),
                ),

                const SizedBox(height: 36),

                // OTP Input
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_otpError != null) ...[
                        Text(
                          _otpError!,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                      Pinput(
                        controller: otpController,
                        focusNode: _otpFocusNode,
                        length: 4,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            border: Border.all(
                              color: const Color(0xFF12B8A6),
                            ),
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
                    ],
                  ),
                ),

                const SizedBox(height: 36),

                // Verify Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: ElevatedButton(
                      onPressed: _isVerifying ? null : _verifyOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF12B8A6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 0,
                      ),
                      child: _isVerifying
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              'Verify your OTP',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Resend OTP
                Column(
                  children: [
                    Text(
                      "Didn't receive OTP?",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: _resendOtp,
                      child: Text(
                        _canResend 
                            ? "Resend OTP" 
                            : "Resend OTP ($_resendTimer)",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: _canResend 
                              ? const Color(0xFF12B8A6) 
                              : const Color(0xFF6B7280),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
