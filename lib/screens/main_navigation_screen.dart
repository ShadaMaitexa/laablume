import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'patient_homescreen.dart';
import 'medical_records_screen.dart';
import 'chat_screen.dart';
import 'profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  // List of screens for bottom navigation
  final List<Widget> _screens = [
    const PatientHomeScreen(),
    const MedicalRecordsScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];

  // Bottom navigation items with improved icons and labels
  final List<Map<String, dynamic>> _navItems = [
    {'icon': Icons.home_outlined, 'activeIcon': Icons.home, 'label': 'Home'},
    {'icon': Icons.folder_outlined, 'activeIcon': Icons.folder, 'label': 'Records'},
    {'icon': Icons.chat_bubble_outline, 'activeIcon': Icons.chat_bubble, 'label': 'Messages'},
    {'icon': Icons.person_outline, 'activeIcon': Icons.person, 'label': 'Profile'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF7F6),
      body: SafeArea(
        child: Stack(
          children: [
            // Main content area
            IndexedStack(
              index: _currentIndex,
              children: _screens,
            ),
            
            // Bottom navigation bar
            Align(
              alignment: Alignment.bottomCenter,
              child: _bottomNavigationBar(),
            ),
          ],
        ),
      ),
    );
  }

  // Bottom navigation bar widget - Updated design
  Widget _bottomNavigationBar() {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(_navItems.length, (index) {
          return Expanded(
            child: _navItem(
              _navItems[index]['icon'] as IconData,
              _navItems[index]['activeIcon'] as IconData,
              _navItems[index]['label'] as String,
              index,
            ),
          );
        }),
      ),
    );
  }

  // Individual navigation item - Completely redesigned
  Widget _navItem(IconData icon, IconData activeIcon, String label, int index) {
    final isActive = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() => _currentIndex = index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        decoration: BoxDecoration(
          color: isActive 
              ? const Color(0xFF12B8A6).withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF12B8A6) : Colors.transparent,
                shape: BoxShape.circle,
                boxShadow: isActive ? [
                  BoxShadow(
                    color: const Color(0xFF12B8A6).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ] : null,
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: Icon(
                  key: ValueKey(isActive),
                  isActive ? activeIcon : icon,
                  size: 24,
                  color: isActive ? Colors.white : const Color(0xFF6B7280),
                ),
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive ? const Color(0xFF12B8A6) : const Color(0xFF6B7280),
              ),
              child: Text(
                label,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
