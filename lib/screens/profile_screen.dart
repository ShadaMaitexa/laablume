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
      backgroundColor: const Color(0xFFEFF7F6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: FutureBuilder<UserProfile>(
            future: fetchProfile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator());
              }

              if (!snapshot.hasData) {
                return const Center(
                    child: Text('Failed to load profile'));
              }

              final user = snapshot.data!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),

                  // -------- Header --------
                  Text(
                    'Profile',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // -------- Profile Card --------
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.grey.shade300,
                          backgroundImage: user.avatarUrl != null
                              ? NetworkImage(user.avatarUrl!)
                              : null,
                          child: user.avatarUrl == null
                              ? const Icon(Icons.person)
                              : null,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${user.age} yrs, ${user.weightKg} kg',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: const Color(0xFF6B7280),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // -------- Menu --------
                  _menuItem(Icons.favorite_border,
                      'Favorite doctors'),
                  _menuItem(Icons.warning_amber_outlined,
                      'Emergency contact'),
                  _menuItem(Icons.assignment_outlined,
                      'Insurance information'),
                  _menuItem(Icons.notifications_none,
                      'Notification settings'),
                  _menuItem(Icons.credit_card,
                      'Payment settings'),
                  _menuItem(Icons.email_outlined,
                      'Change email'),
                  _menuItem(Icons.lock_outline,
                      'Security settings'),
                  _menuItem(Icons.logout, 'Log out'),

                  const SizedBox(height: 100),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // ---------- MENU ITEM ----------
  Widget _menuItem(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF12B8A6)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(fontSize: 14),
            ),
          ),
          const Icon(Icons.chevron_right),
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
