import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'doctor_subsections.dart';

class DoctorWebDashboard extends StatefulWidget {
  const DoctorWebDashboard({super.key});

  @override
  State<DoctorWebDashboard> createState() => _DoctorWebDashboardState();
}

class _DoctorWebDashboardState extends State<DoctorWebDashboard> {
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();

  final Color _primaryColor = const Color(0xFF12B8A6);
  final Color _darkAccent = const Color(0xFF0D9488);
  final Color _bgColor = const Color(0xFFF0F9F8); // Refined background
  final Color _cardColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width >= 1100;
    
    return Scaffold(
      key: GlobalKey<ScaffoldState>(),
      backgroundColor: _bgColor,
      drawer: isDesktop ? null : Drawer(
        width: 280,
        child: _buildSidebar(isDrawer: true),
      ),
      body: Row(
        children: [
          // Navigation Sidebar (Desktop only)
          if (isDesktop) _buildSidebar(),
          
          // Main Content Area
          Expanded(
            child: Column(
              children: [
                _buildProfessionalHeader(!isDesktop),
                Expanded(
                  child: IndexedStack(
                    index: _selectedIndex,
                    children: [
                      _buildDashboardContent(isDesktop), // Index 0
                      const DoctorAppointmentsScreen(), // Index 1
                      const DoctorPatientsScreen(), // Index 2
                      const DoctorReportsScreen(), // Index 3
                      const DoctorConsultationsScreen(), // Index 4
                      const DoctorSettingsScreen(), // Index 5
                      const DoctorHelpScreen(), // Index 6
                    ],
                  ),
                ),
              ],
            ),
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
          Icon(Icons.construction_rounded, size: 80, color: _primaryColor.withOpacity(0.3)),
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
      controller: _scrollController,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 40 : 20,
        vertical: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGreetingSection(),
          const SizedBox(height: 32),
          _buildStatsSummary(isDesktop),
          const SizedBox(height: 40),
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: _buildAppointmentQueue()),
                const SizedBox(width: 32),
                Expanded(flex: 2, child: _buildPatientPerformance()),
              ],
            )
          else
            Column(
              children: [
                _buildAppointmentQueue(),
                const SizedBox(height: 32),
                _buildPatientPerformance(),
              ],
            ),
          const SizedBox(height: 40),
          _buildUpcomingConsultations(isDesktop),
        ],
      ),
    );
  }

  Widget _buildSidebar({bool isDrawer = false}) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(4, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 48),
          // Logo
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: _primaryColor.withOpacity(0.1),
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: const Icon(Icons.auto_awesome_rounded, color: Color(0xFF12B8A6), size: 24),
                ),
                const SizedBox(width: 14),
                Text(
                  'LabLume',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1F2937),
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 64),
                  // Menu Items
                  _sidebarSection('MAIN MENU'),
                  _refinedSidebarItem(Icons.grid_view_rounded, 'Dashboard', 0, isDrawer),
                  _refinedSidebarItem(Icons.calendar_today_rounded, 'Appointments', 1, isDrawer),
                  _refinedSidebarItem(Icons.people_alt_rounded, 'My Patients', 2, isDrawer),
                  _refinedSidebarItem(Icons.description_rounded, 'Reports & AI', 3, isDrawer),
                  _refinedSidebarItem(Icons.question_answer_rounded, 'Consultations', 4, isDrawer),
                  const SizedBox(height: 32),
                  _sidebarSection('SYSTEM'),
                  _refinedSidebarItem(Icons.settings_rounded, 'Settings', 5, isDrawer),
                  _refinedSidebarItem(Icons.help_outline_rounded, 'Help Center', 6, isDrawer),
                ],
              ),
            ),
          ),
          // User Profile at bottom
          _buildSidebarUser(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _sidebarSection(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF9CA3AF),
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }

  Widget _refinedSidebarItem(IconData icon, String title, int index, bool isDrawer) {
    bool isSelected = _selectedIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: () {
          setState(() => _selectedIndex = index);
          if (isDrawer) Navigator.pop(context);
        },
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? _primaryColor.withOpacity(0.08) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected ? _primaryColor : const Color(0xFF6B7280),
                size: 22,
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? _primaryColor : const Color(0xFF6B7280),
                ),
              ),
              if (isSelected) const Spacer(),
              if (isSelected)
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(color: _primaryColor, shape: BoxShape.circle),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSidebarUser() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundColor: Color(0xFF12B8A6),
            child: Icon(Icons.person, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dr. Sarah Wilson',
                  style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Cardiologist',
                  style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF9CA3AF)),
                ),
              ],
            ),
          ),
          const Icon(Icons.logout, size: 18, color: Color(0xFF6B7280)),
        ],
      ),
    );
  }

  Widget _buildProfessionalHeader(bool showMenu) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: showMenu ? 20 : 40, vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFF3F4F6))),
      ),
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
            Container(
              width: 350,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Color(0xFF9CA3AF), size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search patients...',
                        hintStyle: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF9CA3AF)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            )
          else 
            Text(
              'Dashboard',
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xFF111827)),
            ),
          const Spacer(),
          _headerAction(Icons.notifications_none_rounded),
          const SizedBox(width: 12),
          if (!showMenu) _headerAction(Icons.chat_bubble_outline_rounded),
          if (!showMenu) const SizedBox(width: 32),
          if (!showMenu) Container(width: 1, height: 32, color: const Color(0xFFF3F4F6)),
          if (!showMenu) const SizedBox(width: 32),
          if (!showMenu)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '01 January 2026',
                  style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF1F2937)),
                ),
                Text(
                  '16:35 PM',
                  style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF6B7280)),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _headerAction(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFF3F4F6)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: const Color(0xFF6B7280), size: 22),
    );
  }

  Widget _buildGreetingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello, Dr. Sarah 👋',
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1F2937),
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Have a nice day at work! Here\'s what\'s happening today.',
          style: GoogleFonts.poppins(fontSize: 15, color: const Color(0xFF6B7280)),
        ),
      ],
    );
  }

  Widget _buildStatsSummary(bool isDesktop) {
    if (isDesktop) {
      return Row(
        children: [
          Expanded(child: _refinedStatCard('Total Patients', '1.2k', '+12%', Icons.people_rounded, Colors.blue)),
          const SizedBox(width: 24),
          Expanded(child: _refinedStatCard('Today Appointments', '18', '+4%', Icons.calendar_today_rounded, Colors.orange)),
          const SizedBox(width: 24),
          Expanded(child: _refinedStatCard('Consultations', '560', '+8%', Icons.medical_services_rounded, Colors.deepPurple)),
          const SizedBox(width: 24),
          Expanded(child: _refinedStatCard('Average Rating', '4.9', '0%', Icons.star_rounded, Colors.amber)),
        ],
      );
    } else {
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: _refinedStatCard('Total Patients', '1.2k', '+12%', Icons.people_rounded, Colors.blue)),
              const SizedBox(width: 16),
              Expanded(child: _refinedStatCard('Today Appointments', '18', '+4%', Icons.calendar_today_rounded, Colors.orange)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _refinedStatCard('Consultations', '560', '+8%', Icons.medical_services_rounded, Colors.deepPurple)),
              const SizedBox(width: 16),
              Expanded(child: _refinedStatCard('Average Rating', '4.9', '0%', Icons.star_rounded, Colors.amber)),
            ],
          ),
        ],
      );
    }
  }

  Widget _refinedStatCard(String title, String value, String growth, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: growth.startsWith('+') ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  growth,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: growth.startsWith('+') ? Colors.green : Colors.red,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            value,
            style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937)),
          ),
          Text(
            title,
            style: GoogleFonts.poppins(fontSize: 14, color: const Color(0xFF6B7280), fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentQueue() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Appointment Queue', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
              IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {}),
            ],
          ),
          const SizedBox(height: 32),
          _appointmentItem('Alice Brown', 'Video Consultation', '10:30 AM', 'In Progress', Colors.teal),
          _appointmentItem('Mark Wilson', 'In-Person Visit', '11:15 AM', 'Upcoming', Colors.blue),
          _appointmentItem('James Lee', 'Follow-up', '12:00 PM', 'Waiting', Colors.orange),
          _appointmentItem('Sarah Parker', 'New Patient', '13:30 PM', 'Confirmed', Colors.green),
        ],
      ),
    );
  }

  Widget _appointmentItem(String name, String type, String time, String status, Color statusColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(name[0], style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: statusColor)),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold)),
                Text(type, style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF6B7280))),
              ],
            ),
          ),
          Text(time, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xFF1F2937))),
          const SizedBox(width: 32),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              status,
              style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: statusColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientPerformance() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Activity Overview', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          // Synthetic chart view
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_primaryColor.withOpacity(0.1), Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Icon(Icons.show_chart_rounded, size: 80, color: _primaryColor.withOpacity(0.5)),
            ),
          ),
          const SizedBox(height: 24),
          _activityMetric('Active Consultations', '124', 0.8),
          const SizedBox(height: 16),
          _activityMetric('Completed Treatment', '86', 0.6),
        ],
      ),
    );
  }

  Widget _activityMetric(String title, String val, double progress) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF6B7280))),
            Text(val, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: const Color(0xFFF3F4F6),
            valueColor: AlwaysStoppedAnimation<Color>(_primaryColor),
            minHeight: 6,
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingConsultations(bool isDesktop) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(24),
      ),
      child: isDesktop 
        ? Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Upcoming Multi-Specialty Webinar',
                      style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Join other 1,200 specialists to discuss advancements in AI-driven cardiology.',
                      style: GoogleFonts.poppins(fontSize: 14, color: Colors.white60),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 40),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: Text(
                  'Register Now',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Upcoming Multi-Specialty Webinar',
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 12),
              Text(
                'Join other 1,200 specialists to discuss advancements in AI-driven cardiology.',
                style: GoogleFonts.poppins(fontSize: 13, color: Colors.white60),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: Text(
                    'Register Now',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
