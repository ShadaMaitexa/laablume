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
      backgroundColor: const Color(0xFFF9FAFB),
      body: Stack(
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
    );
  }

  // Bottom navigation bar widget - Updated design
  Widget _bottomNavigationBar() {
    return Container(
      height: 72,
      margin: const EdgeInsets.only(left: 24, right: 24, bottom: 32),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_navItems.length, (index) {
          return _navItem(
            _navItems[index]['icon'] as IconData,
            _navItems[index]['activeIcon'] as IconData,
            _navItems[index]['label'] as String,
            index,
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
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        color: Colors.transparent, // Expand tap area
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                isActive ? activeIcon : icon,
                key: ValueKey(isActive),
                size: 24,
                color: isActive ? const Color(0xFF12B8A6) : Colors.white.withOpacity(0.5),
              ),
            ),
            if (isActive) ...[
              const SizedBox(height: 4),
              Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: Color(0xFF12B8A6),
                  shape: BoxShape.circle,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
