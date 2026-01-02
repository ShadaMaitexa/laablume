import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // ---------- API CALL ----------
  Future<UserProfile> fetchProfile() async {
    // TODO: Replace with real API call
    await Future.delayed(const Duration(seconds: 1));

    return UserProfile(
      name: 'Alexander Johnson',
      age: 58,
      weightKg: 72,
      avatarUrl: null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: FutureBuilder<UserProfile>(
          future: fetchProfile(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(color: Color(0xFF12B8A6)));
            }

            if (!snapshot.hasData) {
              return const Center(
                  child: Text('Failed to load profile'));
            }

            final user = snapshot.data!;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
            
                  // -------- Header --------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Profile',
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF111827),
                        ),
                      ),
                      _iconButton(Icons.settings_suggest_rounded),
                    ],
                  ),
            
                  const SizedBox(height: 32),
            
                  // -------- Profile Card --------
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF111827).withOpacity(0.04),
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
                            color: const Color(0xFF12B8A6).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            image: user.avatarUrl != null
                                ? DecorationImage(
                                    image: NetworkImage(user.avatarUrl!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: user.avatarUrl == null
                              ? const Icon(Icons.person_rounded, color: Color(0xFF12B8A6), size: 32)
                              : null,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF111827),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${user.age} yrs, ${user.weightKg} kg',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF6B7280),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.edit_rounded, size: 20, color: Color(0xFF6B7280)),
                        ),
                      ],
                    ),
                  ),
            
                  const SizedBox(height: 32),
            
                  // -------- Section Title --------
                  Text(
                    'Settings',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // -------- Menu --------
                  _menuItem(Icons.favorite_rounded, 'Favorite Doctors'),
                  _menuItem(Icons.emergency_rounded, 'Emergency Contact'),
                  _menuItem(Icons.shield_rounded, 'Insurance Information'),
                  _menuItem(Icons.notifications_rounded, 'Notifications'),
                  _menuItem(Icons.payments_rounded, 'Payment Methods'),
                  _menuItem(Icons.mail_rounded, 'Change Email'),
                  _menuItem(Icons.lock_rounded, 'Security & Privacy'),
                  
                  const SizedBox(height: 16),
                  
                  // Logout Button
                  GestureDetector(
                    onTap: () {
                      // Handle logout
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEE2E2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.logout_rounded, color: Color(0xFFDC2626), size: 22),
                          const SizedBox(width: 12),
                          Text(
                            'Log Out',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFDC2626),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            
                  const SizedBox(height: 120), // Extra padding for bottom nav
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _iconButton(IconData icon) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: IconButton(
        onPressed: () {},
        icon: Icon(icon, size: 24, color: const Color(0xFF111827)),
        padding: EdgeInsets.zero,
      ),
    );
  }

  // ---------- MENU ITEM ----------
  Widget _menuItem(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withOpacity(0.01),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF12B8A6).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF12B8A6), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1F2937),
              ),
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: Color(0xFF9CA3AF), size: 22),
        ],
      ),
    );
  }
}

// =================================================
// MODEL (API READY)
// =================================================
class UserProfile {
  final String name;
  final int age;
  final int weightKg;
  final String? avatarUrl;

  UserProfile({
    required this.name,
    required this.age,
    required this.weightKg,
    this.avatarUrl,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'],
      age: json['age'],
      weightKg: json['weight'],
      avatarUrl: json['avatar'],
    );
  }
}
