import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HospitalWebDashboard extends StatefulWidget {
  const HospitalWebDashboard({super.key});

  @override
  State<HospitalWebDashboard> createState() => _HospitalWebDashboardState();
}

class _HospitalWebDashboardState extends State<HospitalWebDashboard> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: _buildContent(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 280,
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                const Icon(Icons.local_hospital_rounded, color: Color(0xFF12B8A6), size: 32),
                const SizedBox(width: 12),
                Text(
                  'Hospital Hub',
                  style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),
          _sidebarItem(0, Icons.dashboard_outlined, 'Health Analytics'),
          _sidebarItem(1, Icons.assignment_outlined, 'Shared Reports'),
          _sidebarItem(2, Icons.calendar_today_outlined, 'Linked Bookings'),
          _sidebarItem(3, Icons.settings_outlined, 'Portal Settings'),
          const Spacer(),
          _sidebarItem(4, Icons.logout, 'Logout'),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _sidebarItem(int index, IconData icon, String title) {
    bool isSelected = _selectedIndex == index;
    return ListTile(
      onTap: () => setState(() => _selectedIndex = index),
      leading: Icon(icon, color: isSelected ? const Color(0xFF12B8A6) : const Color(0xFF6B7280)),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          color: isSelected ? const Color(0xFF12B8A6) : const Color(0xFF6B7280),
        ),
      ),
      selected: isSelected,
      tileColor: isSelected ? const Color(0xFF12B8A6).withOpacity(0.05) : null,
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 80,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        children: [
          Text(
            'St. Mary Medical Center Portal',
            style: GoogleFonts.poppins(fontSize: 14, color: const Color(0xFF6B7280), fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          const CircleAvatar(
            backgroundColor: Color(0xFFF3F4F6),
            child: Icon(Icons.person_outline, color: Color(0xFF1F2937)),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (_selectedIndex) {
      case 0:
        return _buildAnalyticsView();
      case 1:
        return _buildSharedReportsView();
      case 2:
        return _buildBookingsView();
      default:
        return const Center(child: Text('Under Development'));
    }
  }

  Widget _buildAnalyticsView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Health Analytics (DFD 4.0)', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          Row(
            children: [
              _statCard('Total Patients', '1,284', Icons.people_outline, Colors.blue),
              const SizedBox(width: 24),
              _statCard('Active Cases', '245', Icons.medical_services_outlined, Colors.orange),
              const SizedBox(width: 24),
              _statCard('Recovery Rate', '94%', Icons.trending_up, Colors.green),
            ],
          ),
          const SizedBox(height: 40),
          Container(
            height: 400,
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Text(
                'Aggregated Patient Health Trends Visualization',
                style: GoogleFonts.poppins(color: const Color(0xFF9CA3AF)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSharedReportsView() {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Reports with Consent (DFD 2.0)', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: ListView.separated(
                itemCount: 5,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) => ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text('Jane Doe - Full Blood Count', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                  subtitle: Text('Shared via Opt-in: 02 Jan 2026', style: GoogleFonts.poppins(fontSize: 12)),
                  trailing: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF12B8A6)),
                    child: const Text('View Analysis'),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingsView() {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Linked Patient Bookings (DFD 3.0)', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: ListView.separated(
                itemCount: 8,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) => ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  title: Text('Appointment #${1000 + index}', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                  subtitle: Text('Referred by St. Mary Internal Medicine', style: GoogleFonts.poppins(fontSize: 12)),
                  trailing: const Chip(label: Text('Confirmed')),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(String title, String val, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 16),
            Text(val, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(title, style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF9CA3AF))),
          ],
        ),
      ),
    );
  }
}
