import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      drawer: isDesktop ? null : Drawer(
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
                _sidebarItem(0, Icons.analytics_outlined, 'Laboratory Analytics'),
                _sidebarItem(1, Icons.biotech_rounded, 'Manage Samples'),
                _sidebarItem(2, Icons.fact_check_rounded, 'Results Validation'),
                _sidebarItem(3, Icons.cloud_upload_rounded, 'Report Publishing'),
                _sidebarItem(4, Icons.settings_rounded, 'Station Configuration'),
              ],
            ),
          ),
          _sidebarItem(5, Icons.logout_rounded, 'Secure Sign Out'),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _sidebarItem(int index, IconData icon, String title) {
    bool isSelected = _selectedIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        onTap: () => setState(() => _selectedIndex = index),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: Icon(icon, color: isSelected ? _primaryColor : const Color(0xFF9CA3AF), size: 22),
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
                'Central Diagnostic Hub',
                style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF111827)),
              ),
              Text(
                'Terminal Status: ONLINE',
                style: GoogleFonts.poppins(fontSize: 11, color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Spacer(),
          _headerAction(Icons.notifications_none_rounded),
          const SizedBox(width: 20),
          const CircleAvatar(
            backgroundColor: Color(0xFFF3F4F6),
            child: Icon(Icons.science_rounded, color: Color(0xFF1F2937), size: 20),
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
      case 0: return _buildAnalytics(isDesktop);
      case 1: return _buildSampleManagement(isDesktop);
      default: return _buildPlaceholder('Module');
    }
  }

  Widget _buildAnalytics(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Laboratory Intelligence', 'Real-time tracking of diagnostic throughput.'),
        const SizedBox(height: 32),
        _buildStatsGrid(isDesktop),
        const SizedBox(height: 40),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: _recentSamples(isDesktop)),
            if (isDesktop) const SizedBox(width: 32),
            if (isDesktop) Expanded(flex: 1, child: _reagentStatus()),
          ],
        ),
        if (!isDesktop) ...[
          const SizedBox(height: 32),
          _reagentStatus(),
        ],
      ],
    );
  }

  Widget _buildSectionHeader(String title, String sub) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937))),
        Text(sub, style: GoogleFonts.poppins(fontSize: 15, color: const Color(0xFF6B7280))),
      ],
    );
  }

  Widget _buildStatsGrid(bool isDesktop) {
    List<Widget> stats = [
      _statCard('Samples Pending', '42', Icons.hourglass_empty_rounded, Colors.orange),
      _statCard('Tests Processed', '1,402', Icons.check_circle_outline_rounded, Colors.green),
      _statCard('Urgent Requests', '08', Icons.bolt_rounded, Colors.red),
      _statCard('Avg. Turnaround', '4.2h', Icons.timer_outlined, Colors.blue),
    ];

    if (isDesktop) {
      return Row(children: stats.map((e) => Expanded(child: Padding(padding: const EdgeInsets.only(right: 20), child: e))).toList());
    } else {
      return GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 1.2,
        children: stats,
      );
    }
  }

  Widget _statCard(String title, String val, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 16),
          Text(val, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(title, style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF9CA3AF), fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _recentSamples(bool isDesktop) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Sample Flow', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('View All', style: GoogleFonts.poppins(fontSize: 12, color: _primaryColor, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 32),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            separatorBuilder: (context, index) => const Divider(height: 32),
            itemBuilder: (context, index) => Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(12)),
                  child: Icon(Icons.science_outlined, color: _primaryColor, size: 20),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Sample #LK-7023${index+1}', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14)),
                      Text('Blood Glucose Analysis', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
                if (isDesktop) _statusBadge('Processing', Colors.blue),
                const SizedBox(width: 20),
                Text('10:30 AM', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(30)),
      child: Text(label, style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color: color)),
    );
  }

  Widget _reagentStatus() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: const Color(0xFF1F2937), borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('System Health', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 32),
          _healthMetric('Analyzer Connectivity', 0.98),
          const SizedBox(height: 20),
          _healthMetric('Sample Queue Load', 0.65),
          const SizedBox(height: 20),
          _healthMetric('Storage Temp (Critical)', 0.15),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 18),
                const SizedBox(width: 12),
                Expanded(child: Text('Calibration due for Station-4', style: GoogleFonts.poppins(color: Colors.red, fontSize: 12))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _healthMetric(String title, double val) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12)),
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

  Widget _buildSampleManagement(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Scan & Register', 'Register incoming physical samples into the digital tracking system.'),
        const SizedBox(height: 32),
        Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: _primaryColor.withOpacity(0.2), style: BorderStyle.none),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.qr_code_scanner_rounded, size: 80, color: _primaryColor.withOpacity(0.3)),
              const SizedBox(height: 20),
              Text('Align barcode to scan sample', style: GoogleFonts.poppins(color: Colors.grey)),
            ],
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
          Icon(Icons.science_rounded, size: 60, color: _primaryColor.withOpacity(0.2)),
          const SizedBox(height: 16),
          Text('$title Terminal is active.', style: GoogleFonts.poppins(color: Colors.grey)),
        ],
      ),
    );
  }
}
