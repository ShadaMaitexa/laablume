import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../providers/user_provider.dart';
import 'package:laablume/screens/web/common/landing_page.dart';
import 'lab_subsections.dart';

class LabWebDashboard extends StatefulWidget {
  const LabWebDashboard({super.key});

  @override
  State<LabWebDashboard> createState() => _LabWebDashboardState();
}

class _LabWebDashboardState extends State<LabWebDashboard> {
  int _selectedIndex = 0;
  final Color _primaryColor = const Color(0xFF12B8A6);
  final Color _sidebarBg = Colors.white;
  final Color _bgColor = const Color(0xFFF9FAFB);

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width >= 1100;

    return Scaffold(
      backgroundColor: _bgColor,
      key: GlobalKey<ScaffoldState>(),
      drawer: isDesktop
          ? null
          : Drawer(
              width: 280,
              backgroundColor: Colors.white,
              child: _buildSidebar(isDrawer: true),
            ),
      body: Row(
        children: [
          if (isDesktop) _buildSidebar(),
          Expanded(
            child: Column(
              children: [
                _buildHeader(!isDesktop),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(isDesktop ? 40 : 20),
                    child: _buildContent(isDesktop),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar({bool isDrawer = false}) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: _sidebarBg,
        border: const Border(right: BorderSide(color: Color(0xFFF3F4F6))),
      ),
      child: Column(
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: _primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset('assets/logo.png', width: 24, height: 24),
                ),
                const SizedBox(width: 14),
                Text(
                  'LabLume',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),
          Expanded(
            child: ListView(
              children: [
                _sidebarItem(0, Icons.event_note_rounded, 'Booked Tests'),
                _sidebarItem(1, Icons.cloud_upload_rounded, 'Upload Reports'),
                _sidebarItem(2, Icons.verified_user_rounded, 'Sign & Validate'),
                _sidebarItem(3, Icons.list_alt_rounded, 'Manage Test Catalog'),
                _sidebarItem(4, Icons.people_rounded, 'Manage Staff'),
                _sidebarItem(5, Icons.reviews_rounded, 'Patient Feedback'),
                _sidebarItem(6, Icons.business_rounded, 'Lab Profile'),
              ],
            ),
          ),
          _sidebarItem(
            99,
            Icons.logout_rounded,
            'Secure Sign Out',
            onTap: () {
              context.read<UserProvider>().logout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LandingPage()),
                (route) => false,
              );
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _sidebarItem(
    int index,
    IconData icon,
    String title, {
    VoidCallback? onTap,
  }) {
    bool isSelected = _selectedIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        onTap: onTap ?? () => setState(() => _selectedIndex = index),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: Icon(
          icon,
          color: isSelected ? _primaryColor : const Color(0xFF9CA3AF),
          size: 22,
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? _primaryColor : const Color(0xFF6B7280),
          ),
        ),
        selected: isSelected,
        selectedTileColor: _primaryColor.withOpacity(0.05),
      ),
    );
  }

  Widget _buildHeader(bool showMenu) {
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.currentUser;

    return Container(
      height: 80,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: showMenu ? 16 : 40),
      child: Row(
        children: [
          if (showMenu)
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu_rounded, color: Color(0xFF111827)),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user?.name ?? 'Central Diagnostic Hub',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF111827),
                ),
              ),
              Text(
                user?.email ?? 'Terminal Status: ONLINE',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          _headerAction(Icons.notifications_none_rounded),
          const SizedBox(width: 20),
          const CircleAvatar(
            backgroundColor: Color(0xFFF3F4F6),
            child: Icon(
              Icons.science_rounded,
              color: Color(0xFF1F2937),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerAction(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, size: 20, color: const Color(0xFF6B7280)),
    );
  }

  Widget _buildContent(bool isDesktop) {
    switch (_selectedIndex) {
      case 0:
        return const LabBookingsScreen();
      case 1:
        return const LabReportUploadScreen();
      case 2:
        return const LabResultsApprovalScreen();
      case 3:
        return const LabTestCatalogScreen();
      case 4:
        return const LabTechniciansScreen();
      case 5:
        return const LabFeedbackScreen();
      case 6:
        return const LabProfileScreen();
      default:
        return _buildPlaceholder('Module');
    }
  }

  Widget _buildPlaceholder(String title) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.science_rounded,
            size: 60,
            color: _primaryColor.withOpacity(0.2),
          ),
          const SizedBox(height: 16),
          Text(
            '$title Terminal is active.',
            style: GoogleFonts.poppins(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
