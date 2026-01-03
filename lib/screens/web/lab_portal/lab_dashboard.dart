import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'lab_subsections.dart';

class LabWebDashboard extends StatefulWidget {
  const LabWebDashboard({super.key});

  @override
  State<LabWebDashboard> createState() => _LabWebDashboardState();
}

class _LabWebDashboardState extends State<LabWebDashboard> {
  int _selectedIndex = 0;
  bool _showNotifications = false;

  final Color _primaryColor = const Color(0xFF12B8A6);
  final Color _darkBg = const Color(0xFF111827); // Very dark for a modern lab feel
  final Color _lightBg = const Color(0xFFF9FAFB);

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width >= 1100;

    return Scaffold(
      key: GlobalKey<ScaffoldState>(),
      backgroundColor: _lightBg,
      drawer: isDesktop ? null : Drawer(
        width: 280,
        backgroundColor: _darkBg,
        child: _buildLabSidebar(isDrawer: true),
      ),
      body: Stack(
        children: [
          Row(
            children: [
              if (isDesktop) _buildLabSidebar(),
              Expanded(
                child: Column(
                  children: [
                    _buildLabHeader(!isDesktop),
                    Expanded(
                      child: IndexedStack(
                        index: _selectedIndex,
                        children: [
                          _buildDashboardContent(isDesktop), // Index 0: Lab Analytics
                          const LabBookingsScreen(), // Index 1: Manage Tests
                          const LabResultsApprovalScreen(), // Index 2: Results Approval
                          const LabInventoryScreen(), // Index 3: Equipment & Supplies
                          const LabTechniciansScreen(), // Index 4: Technicians
                          const LabSettingsScreen(), // Index 5: Portal Settings
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (_showNotifications)
            Positioned(
              top: 80,
              right: isDesktop ? 60 : 20,
              child: _buildNotificationsPanel(),
            ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderScreen(String title) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.biotech_rounded, size: 80, color: _primaryColor.withOpacity(0.3)),
          const SizedBox(height: 20),
          Text(
            '$title Screen is under development',
            style: GoogleFonts.poppins(fontSize: 18, color: const Color(0xFF6B7280)),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardContent(bool isDesktop) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(isDesktop ? 40 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeSection(),
          const SizedBox(height: 40),
          _buildLabStats(isDesktop),
          const SizedBox(height: 40),
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: _buildRecentTestsTable(isDesktop)),
                const SizedBox(width: 30),
                Expanded(flex: 1, child: _buildLabCapacity()),
              ],
            )
          else
            Column(
              children: [
                _buildRecentTestsTable(isDesktop),
                const SizedBox(height: 32),
                _buildLabCapacity(),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildLabSidebar({bool isDrawer = false}) {
    return Container(
      width: 280,
      color: _darkBg,
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
                    color: Colors.white,
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
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  _labSidebarItem(Icons.analytics_outlined, 'Lab Analytics', 0, isDrawer),
                  _labSidebarItem(Icons.science_outlined, 'Manage Tests', 1, isDrawer),
                  _labSidebarItem(Icons.assignment_turned_in_outlined, 'Results Approval', 2, isDrawer),
                  _labSidebarItem(Icons.inventory_2_outlined, 'Equipment & Supplies', 3, isDrawer),
                  _labSidebarItem(Icons.people_outline_rounded, 'Technicians', 4, isDrawer),
                ],
              ),
            ),
          ),
          _labSidebarItem(Icons.settings_outlined, 'Portal Settings', 5, isDrawer),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _labSidebarItem(IconData icon, String title, int index, bool isDrawer) {
    bool isSelected = _selectedIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: InkWell(
        onTap: () {
          setState(() => _selectedIndex = index);
          if (isDrawer) Navigator.pop(context);
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? _primaryColor.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: isSelected ? Border.all(color: _primaryColor.withOpacity(0.3)) : null,
          ),
          child: Row(
            children: [
              Icon(icon, color: isSelected ? _primaryColor : Colors.white60, size: 22),
              const SizedBox(width: 16),
              Text(
                title,
                style: GoogleFonts.poppins(
                  color: isSelected ? Colors.white : Colors.white60,
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabHeader(bool showMenu) {
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
          if (!showMenu)
            Text(
              'Terminal ID: LK-901-B',
              style: GoogleFonts.poppins(fontSize: 14, color: const Color(0xFF6B7280), fontWeight: FontWeight.w600),
            )
          else 
            Text(
              'Lab Terminal',
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          const Spacer(),
          if (!showMenu) _statusIndicator('Lab Status: ACTIVE', Colors.green),
          const SizedBox(width: 24),
          _headerAction(
            Icons.notifications_none_rounded, 
            badgeCount: 2,
            onTap: () => setState(() => _showNotifications = !_showNotifications),
          ),
          const SizedBox(width: 12),
          _headerAction(Icons.bolt_rounded), // System status
          const SizedBox(width: 24),
          const CircleAvatar(
            backgroundColor: Color(0xFFF3F4F6),
            child: Icon(Icons.science, color: Color(0xFF1F2937)),
          ),
        ],
      ),
    );
  }

  Widget _headerAction(IconData icon, {VoidCallback? onTap, int badgeCount = 0}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFF3F4F6)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF6B7280), size: 18),
          ),
          if (badgeCount > 0)
            Positioned(
              top: -4,
              right: -4,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(color: Color(0xFF12B8A6), shape: BoxShape.circle),
                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                child: Text(
                  badgeCount.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNotificationsPanel() {
    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('System Alerts', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
                const Icon(Icons.settings_outlined, size: 18, color: Color(0xFF9CA3AF)),
              ],
            ),
          ),
          const Divider(height: 1),
          _notificationItem('Critical Reagent Low', 'Analyzer-1 requires immediate refill.', Icons.warning_amber_rounded, Colors.red),
          _notificationItem('Calibration Required', 'Immunoassay system calibration due.', Icons.build_outlined, Colors.orange),
          _notificationItem('Sample Batch Uploaded', '32 new samples registered for analysis.', Icons.cloud_done_outlined, _primaryColor),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextButton(
              onPressed: () => setState(() => _showNotifications = false),
              child: Text('Close Diagnostics', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: const Color(0xFF6B7280))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _notificationItem(String title, String sub, IconData icon, Color color) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: color, size: 18),
      ),
      title: Text(title, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
      subtitle: Text(sub, style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF6B7280))),
      onTap: () {},
    );
  }

  Widget _statusIndicator(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 10),
          Text(
            text,
            style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Laboratory Management',
          style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.bold, color: _darkBg),
        ),
        Text(
          'Automated tracking and result management system.',
          style: GoogleFonts.poppins(fontSize: 16, color: const Color(0xFF6B7280)),
        ),
      ],
    );
  }

  Widget _buildLabStats(bool isDesktop) {
    if (isDesktop) {
      return Row(
        children: [
          Expanded(child: _labStatCard('Tests Processed', '14,204', Icons.copy_rounded, Colors.blue)),
          const SizedBox(width: 24),
          Expanded(child: _labStatCard('Pending Samples', '42', Icons.hourglass_top_rounded, Colors.orange)),
          const SizedBox(width: 24),
          Expanded(child: _labStatCard('Ready for Approval', '18', Icons.check_circle_rounded, Colors.green)),
          const SizedBox(width: 24),
          Expanded(child: _labStatCard('System Uptime', '99.9%', Icons.cloud_done_rounded, _primaryColor)),
        ],
      );
    } else {
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: _labStatCard('Tests', '14.2k', Icons.copy_rounded, Colors.blue)),
              const SizedBox(width: 16),
              Expanded(child: _labStatCard('Pending', '42', Icons.hourglass_top_rounded, Colors.orange)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _labStatCard('Ready', '18', Icons.check_circle_rounded, Colors.green)),
              const SizedBox(width: 16),
              Expanded(child: _labStatCard('Uptime', '99.9%', Icons.cloud_done_rounded, _primaryColor)),
            ],
          ),
        ],
      );
    }
  }

  Widget _labStatCard(String title, String val, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 20),
          Text(val, style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: _darkBg)),
          Text(title, style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF9CA3AF), fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildRecentTestsTable(bool isDesktop) {
    return Container(
      padding: EdgeInsets.all(isDesktop ? 32 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Sample Processing', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: _primaryColor, borderRadius: BorderRadius.circular(10)),
                child: Text('Register', style: GoogleFonts.poppins(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 32),
          _tableHeaderRow(isDesktop),
          const Divider(),
          _testDataRow('SAM-9011', 'Liam Henderson', 'Blood Glucose', 'Processing', 0.65, isDesktop),
          _testDataRow('SAM-9012', 'Sophia Garcia', 'Lipid Panel', 'In Queue', 0.1, isDesktop),
          _testDataRow('SAM-9013', 'Noah Smith', 'CBC Analysis', 'Scanning', 0.9, isDesktop),
        ],
      ),
    );
  }

  Widget _tableHeaderRow(bool isDesktop) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text('ID', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF9CA3AF)))),
          Expanded(flex: 2, child: Text('PATIENT', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF9CA3AF)))),
          if (isDesktop) Expanded(flex: 2, child: Text('TEST TYPE', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF9CA3AF)))),
          Expanded(flex: 2, child: Text('PROGRESS', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF9CA3AF)))),
        ],
      ),
    );
  }

  Widget _testDataRow(String id, String patient, String test, String status, double progress, bool isDesktop) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text(id, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text(patient, style: GoogleFonts.poppins(fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis)),
          if (isDesktop) Expanded(flex: 2, child: Text(test, style: GoogleFonts.poppins(fontSize: 13, color: _primaryColor, fontWeight: FontWeight.w600))),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: const Color(0xFFF3F4F6),
                    valueColor: AlwaysStoppedAnimation<Color>(_primaryColor),
                    minHeight: 4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabCapacity() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: _darkBg,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Lab Capacity', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 10),
          Text('78% of analyzers active', style: GoogleFonts.poppins(fontSize: 13, color: Colors.white60)),
          const SizedBox(height: 40),
          _analyzerStat('Chemical Analyzer-1', 0.85),
          const SizedBox(height: 24),
          _analyzerStat('Hematology Auto', 0.40),
          const SizedBox(height: 24),
          _analyzerStat('Immunoassay Sys', 0.95),
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: [
                const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 24),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Reagent levels low for Glucose Panel.',
                    style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _analyzerStat(String name, double val) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12)),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: val,
          backgroundColor: Colors.white10,
          valueColor: AlwaysStoppedAnimation<Color>(_primaryColor),
          minHeight: 4,
        ),
      ],
    );
  }
}
