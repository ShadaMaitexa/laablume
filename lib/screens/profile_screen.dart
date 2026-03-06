import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/patient_provider.dart';
import '../providers/user_provider.dart';
import 'personal_information_screen.dart';
import 'emergency_contact.dart';
import 'insurance_information_screen.dart';
import 'health_assesment.dart';
import 'payment_methods_screen.dart';
import 'change_email_screen.dart';
import 'security_privacy_screen.dart';
import '../utils/responsive_layout.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PatientProvider>().loadProfile();
    });
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF12B8A6).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.logout_rounded,
                  color: Color(0xFF12B8A6),
                  size: 32,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Are you sure you want to log out?',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'You will need to login again to access your account.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: const Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    await context.read<UserProvider>().logout();
                    if (mounted) {
                      Navigator.of(context, rootNavigator: true)
                          .pushNamedAndRemoveUntil('/', (route) => false);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF12B8A6),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Log out',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF12B8A6),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Consumer<PatientProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading && provider.user == null) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFF12B8A6)),
              );
            }

            final user = provider.user;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveLayout.isDesktop(context) ? 80 : 24,
                vertical: 24,
              ),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),

                      // -------- Header --------
                      Text(
                        'Profile',
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF111827),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // -------- Profile Card --------
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const PersonalInformationScreen(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xFF111827,
                                ).withOpacity(0.04),
                                blurRadius: 20,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 64,
                                height: 64,
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFF12B8A6,
                                  ).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  image: user?.profileImageUrl != null
                                      ? DecorationImage(
                                          image: NetworkImage(
                                            user!.profileImageUrl!,
                                          ),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                ),
                                child: user?.profileImageUrl == null
                                    ? const Icon(
                                        Icons.person_rounded,
                                        color: Color(0xFF12B8A6),
                                        size: 32,
                                      )
                                    : null,
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user?.name ?? 'Loading...',
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF111827),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      user?.email ?? '',
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF6B7280),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.chevron_right_rounded,
                                color: Color(0xFF9CA3AF),
                                size: 24,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // -------- Menu Section --------
                      _buildSectionTitle('HEALTH RECORD'),
                      const SizedBox(height: 12),
                      _menuItem(
                        Icons.person_outline_rounded,
                        'Personal Information',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const PersonalInformationScreen(),
                          ),
                        ),
                      ),
                      _menuItem(
                        Icons.emergency_outlined,
                        'Emergency Contact',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const EmergencyContactScreen(),
                          ),
                        ),
                      ),

                      _menuItem(
                        Icons.health_and_safety_outlined,
                        'Health Assessment',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const HealthAssessmentScreen(),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),
                      _buildSectionTitle('SETTINGS'),
                      const SizedBox(height: 12),
                      _menuItem(
                        Icons.payments_outlined,
                        'Payment Methods',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PaymentMethodsScreen(),
                          ),
                        ),
                      ),
                      _menuItem(
                        Icons.mail_outline_rounded,
                        'Change Email',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChangeEmailScreen(),
                          ),
                        ),
                      ),
                      _menuItem(
                        Icons.lock_outline_rounded,
                        'Security & Privacy',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SecurityPrivacyScreen(),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),
                      const Divider(height: 32),
                      const SizedBox(height: 8),

                      // Logout Button
                      _menuItem(
                        Icons.logout_rounded,
                        'Log out',
                        isLast: true,
                        iconColor: const Color(0xFFDC2626),
                        onTap: _showLogoutDialog,
                      ),

                      const SizedBox(
                        height: 120,
                      ), // Extra padding for bottom nav
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF9CA3AF),
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  // ---------- MENU ITEM ----------
  Widget _menuItem(
    IconData icon,
    String title, {
    VoidCallback? onTap,
    bool isLast = false,
    Color? iconColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF111827).withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: (iconColor ?? const Color(0xFF12B8A6)).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: iconColor ?? const Color(0xFF12B8A6),
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isLast
                      ? const Color(0xFFDC2626)
                      : const Color(0xFF1F2937),
                ),
              ),
            ),
            if (!isLast)
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF9CA3AF),
                size: 22,
              ),
          ],
        ),
      ),
    );
  }
}
