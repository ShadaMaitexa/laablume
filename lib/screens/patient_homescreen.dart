import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({super.key});

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  int _currentIndex = 0;

  // ---------------- API READY ----------------
  Future<List<String>> fetchRecentTests() async {
    return []; // connect API later
  }

  Future<List<String>> fetchDoctors() async {
    return []; // connect API later
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF7F6),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),

                  // ---------------- HEADER ----------------
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey, // API image later
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good Morning,',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color(0xFF6B7280),
                            ),
                          ),
                          Text(
                            'John',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications_none),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ---------------- TITLE ----------------
                  Text(
                    '"Let\'s check in\non your health."',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ---------------- SEARCH ----------------
                  Container(
                    height: 46,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText:
                                  'Search by test, type, or panel...',
                              hintStyle: GoogleFonts.poppins(
                                fontSize: 13,
                                color: const Color(0xFF9CA3AF),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            color: Color(0xFF12B8A6),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ---------------- RECENT TESTS ----------------
                  _sectionHeader('Recent Tests'),
                  const SizedBox(height: 10),

                  FutureBuilder<List<String>>(
                    future: fetchRecentTests(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData ||
                          snapshot.data!.isEmpty) {
                        return _emptyState(
                            'No recent tests available');
                      }
                      return const SizedBox(height: 90);
                    },
                  ),

                  const SizedBox(height: 24),

                  // ---------------- CONSULT SPECIALIST ----------------
                  _sectionHeader('Consult a specialist'),
                  const SizedBox(height: 10),

                  FutureBuilder<List<String>>(
                    future: fetchDoctors(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData ||
                          snapshot.data!.isEmpty) {
                        return _emptyState(
                            'No specialists available');
                      }
                      return const SizedBox(height: 160);
                    },
                  ),

                  const SizedBox(height: 110),
                ],
              ),
            ),

            // ---------------- BOTTOM NAV ----------------
            Align(
              alignment: Alignment.bottomCenter,
              child: _bottomNav(),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- SECTION HEADER ----------------
  Widget _sectionHeader(String title) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        Text(
          'View all',
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: const Color(0xFF12B8A6),
          ),
        ),
      ],
    );
  }

  // ---------------- EMPTY STATE ----------------
  Widget _emptyState(String text) {
    return Container(
      height: 90,
      alignment: Alignment.center,
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 13,
          color: const Color(0xFF9CA3AF),
        ),
      ),
    );
  }

  // ---------------- BOTTOM NAV ----------------
  Widget _bottomNav() {
    return Container(
      height: 76,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _navItem(Icons.home, 0),
          _navItem(Icons.folder_open, 1),
          _navItem(Icons.chat_bubble_outline, 2),
          _navItem(Icons.person_outline, 3),
        ],
      ),
    );
  }

  // ---------------- NAV ITEM ----------------
  Widget _navItem(IconData icon, int index) {
    final isActive = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() => _currentIndex = index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFF12B8A6)
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Icon(
          icon,
          size: 22,
          color: isActive ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
