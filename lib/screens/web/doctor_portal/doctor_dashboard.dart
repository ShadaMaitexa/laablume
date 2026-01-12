import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorWebDashboard extends StatefulWidget {
  const DoctorWebDashboard({super.key});

  @override
  State<DoctorWebDashboard> createState() => _DoctorWebDashboardState();
}

class _DoctorWebDashboardState extends State<DoctorWebDashboard> {
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
                _sidebarItem(0, Icons.dashboard_rounded, 'Doctor Dashboard'),
                _sidebarItem(1, Icons.calendar_today_rounded, 'Patient Schedule'),
                _sidebarItem(2, Icons.people_alt_rounded, 'My Patients'),
                _sidebarItem(3, Icons.psychology_rounded, 'AI Recommendations'),
                _sidebarItem(4, Icons.settings_rounded, 'Practice Settings'),
              ],
            ),
          ),
          _sidebarItem(5, Icons.logout_rounded, 'Logout Practice'),
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
                'Dr. Sarah Wilson',
                style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF111827)),
              ),
              Text(
                'Clinical Hub: Cardiology',
                style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF6B7280)),
              ),
            ],
          ),
          const Spacer(),
          _headerAction(Icons.search_rounded),
          const SizedBox(width: 12),
          _headerAction(Icons.notifications_none_rounded),
          const SizedBox(width: 20),
          const CircleAvatar(
            backgroundColor: Color(0xFFF3F4F6),
            child: Icon(Icons.person_rounded, color: Color(0xFF1F2937), size: 20),
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
      case 0: return _buildDoctorOverview(isDesktop);
      case 1: return _buildSchedule(isDesktop);
      default: return _buildPlaceholder('Module');
    }
  }

  Widget _buildDoctorOverview(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Practice Insights', 'A complete overview of your clinical activity today.'),
        const SizedBox(height: 32),
        _buildStatsGrid(isDesktop),
        const SizedBox(height: 40),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: _appointmentQueue(isDesktop)),
            if (isDesktop) const SizedBox(width: 32),
            if (isDesktop) Expanded(flex: 1, child: _recentActivity()),
          ],
        ),
        if (!isDesktop) ...[
          const SizedBox(height: 32),
          _recentActivity(),
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
      _statCard('Today Patients', '18', Icons.people_outline_rounded, Colors.blue),
      _statCard('Consultations', '562', Icons.medical_services_outlined, Colors.purple),
      _statCard('Avg. Rating', '4.9', Icons.star_outline_rounded, Colors.amber),
      _statCard('Reports Pending', '04', Icons.description_outlined, Colors.red),
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

  Widget _appointmentQueue(bool isDesktop) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Up Next', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
              _statusBadge('4 Active', _primaryColor),
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
                const CircleAvatar(
                  radius: 24,
                  backgroundColor: Color(0xFFF3F4F6),
                  child: Icon(Icons.person_rounded, color: Color(0xFF9CA3AF)),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Alice Brown', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14)),
                      Text('Video Consultation • Heart Rate Issues', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
                Text('10:30 AM', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold)),
                const SizedBox(width: 20),
                if (isDesktop) _statusBadge(index == 0 ? 'In Progress' : 'Upcoming', index == 0 ? Colors.green : Colors.blue),
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

  Widget _recentActivity() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: const Color(0xFF1F2937), borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Clinical Journal', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 32),
          _journalItem('Prescription signed for PT-9011', '10 mins ago', Colors.green),
          _journalItem('Lab report reviewed for PT-9012', '25 mins ago', _primaryColor),
          _journalItem('Emergency referral: PT-8114', '1 hour ago', Colors.orange),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: [
                const Icon(Icons.auto_awesome_rounded, color: Colors.purpleAccent, size: 24),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'AI analysis suggests follow-up for PT-9023.',
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

  Widget _journalItem(String msg, String time, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(msg, style: GoogleFonts.poppins(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
                Text(time, style: GoogleFonts.poppins(color: Colors.white60, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSchedule(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Patient Schedule', 'Keep track of all your upcoming medical sessions.'),
        const SizedBox(height: 32),
        Container(
          height: 400,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
          child: Center(child: Text('Clinical Calendar View', style: GoogleFonts.poppins(color: Colors.grey))),
        ),
      ],
    );
  }

  Widget _buildPlaceholder(String title) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.medical_services_rounded, size: 60, color: _primaryColor.withOpacity(0.2)),
          const SizedBox(height: 16),
          Text('$title Feature Module is active.', style: GoogleFonts.poppins(color: Colors.grey)),
        ],
      ),
    );
  }
}
