import 'dart:ui';
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
    {'icon': Icons.home_outlined, 'activeIcon': Icons.home_rounded, 'label': 'Home'},
    {'icon': Icons.folder_outlined, 'activeIcon': Icons.folder_rounded, 'label': 'Records'},
    {'icon': Icons.chat_bubble_outline, 'activeIcon': Icons.chat_bubble_rounded, 'label': 'Chat'},
    {'icon': Icons.person_outline, 'activeIcon': Icons.person_rounded, 'label': 'Profile'},
  ];

  @override
  Widget build(BuildContext context) {
    bool isWide = MediaQuery.of(context).size.width >= 1024;

    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFFF9FAFB),
      body: Row(
        children: [
          if (isWide) _sideNavigationRail(),
          Expanded(child: _screens[_currentIndex]),
        ],
      ),
      bottomNavigationBar: isWide ? null : _bottomNavigationBar(),
    );
  }

  Widget _sideNavigationRail() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
          ),
        ],
      ),
      child: NavigationRail(
        backgroundColor: Colors.transparent,
        selectedIndex: _currentIndex,
        onDestinationSelected: (int index) {
          setState(() => _currentIndex = index);
        },
        labelType: NavigationRailLabelType.all,
        selectedLabelTextStyle: GoogleFonts.poppins(
          color: const Color(0xFF12B8A6),
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelTextStyle: GoogleFonts.poppins(
          color: Colors.white.withOpacity(0.5),
          fontSize: 12,
        ),
        leading: Column(
          children: [
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF12B8A6).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.auto_awesome_rounded, color: Color(0xFF12B8A6), size: 28),
            ),
            const SizedBox(height: 48),
          ],
        ),
        destinations: _navItems.map((item) {
          return NavigationRailDestination(
            icon: Icon(item['icon'], color: Colors.white.withOpacity(0.5)),
            selectedIcon: Icon(item['activeIcon'], color: const Color(0xFF12B8A6)),
            label: Text(item['label']),
          );
        }).toList(),
      ),
    );
  }

  // Bottom navigation bar widget - Updated design with floating glass card
  Widget _bottomNavigationBar() {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
      decoration: BoxDecoration(
        color: const Color(0xFF111827).withOpacity(0.9),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withOpacity(0.3),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_navItems.length, (index) {
                return Flexible(
                  flex: _currentIndex == index ? 2 : 1,
                  child: _navItem(
                    _navItems[index]['icon'] as IconData,
                    _navItems[index]['activeIcon'] as IconData,
                    _navItems[index]['label'] as String,
                    index,
                  ),
                );
              }),
            ),
          ),
        ),
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
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(horizontal: isActive ? 16 : 8, vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? Colors.white.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              size: 22,
              color: isActive ? const Color(0xFF12B8A6) : Colors.white.withOpacity(0.5),
            ),
            if (isActive) ...[
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
