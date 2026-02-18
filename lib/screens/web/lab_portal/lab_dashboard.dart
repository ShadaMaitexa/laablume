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
                  child: SingleChildScrollView(
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
                _sidebarItem(2, Icons.list_alt_rounded, 'Manage Test Catalog'),
                _sidebarItem(
                  3,
                  Icons.event_available_rounded,
                  'Update Availability',
                ),
              ],
            ),
          ),
          _sidebarItem(
            5,
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
        return _buildTestCatalog(isDesktop);
      case 3:
        return _buildAvailability(isDesktop);
      default:
        return _buildPlaceholder('Module');
    }
  }

  Widget _buildSectionHeader(String title, String sub) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1F2937),
          ),
        ),
        Text(
          sub,
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: const Color(0xFF6B7280),
          ),
        ),
      ],
    );
  }

  Widget _statusBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget _buildTestCatalog(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          'Service Catalog',
          'Manage the types of tests and diagnostics offered by this facility.',
        ),
        const SizedBox(height: 32),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isDesktop ? 3 : 1,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 2.5,
          ),
          itemCount: 6,
          itemBuilder: (context, index) => Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(Icons.biotech_rounded, color: _primaryColor),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Blood Glucose Profile',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '₹499 • 24h Turnaround',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: true,
                  onChanged: (v) {},
                  activeColor: _primaryColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAvailability(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          'Operating Hours',
          'Set and update your facility’s diagnostic service hours.',
        ),
        const SizedBox(height: 32),
        Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: List.generate(
              7,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        [
                          'Mon',
                          'Tue',
                          'Wed',
                          'Thu',
                          'Fri',
                          'Sat',
                          'Sun',
                        ][index],
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '08:00 AM - 08:00 PM',
                      style: GoogleFonts.poppins(color: Colors.grey),
                    ),
                    const SizedBox(width: 40),
                    _statusBadge('Active', Colors.green),
                    const SizedBox(width: 20),
                    IconButton(
                      icon: const Icon(Icons.edit_note_rounded),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
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
