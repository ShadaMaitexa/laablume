import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminWebPortal extends StatefulWidget {
  const AdminWebPortal({super.key});

  @override
  State<AdminWebPortal> createState() => _AdminWebPortalState();
}

class _AdminWebPortalState extends State<AdminWebPortal> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(child: _buildContent()),
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
      color: const Color(0xFF111827),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                const Icon(Icons.admin_panel_settings_rounded, color: Color(0xFF12B8A6), size: 32),
                const SizedBox(width: 12),
                Text(
                  'Admin Panel',
                  style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),
          _sidebarItem(0, Icons.insert_chart_outlined_rounded, 'Overview'),
          _sidebarItem(1, Icons.how_to_reg_outlined, 'Approvals'),
          _sidebarItem(2, Icons.people_outline_rounded, 'User Management'),
          _sidebarItem(3, Icons.payments_outlined, 'Payments'),
          _sidebarItem(4, Icons.rate_review_outlined, 'Reviews & Feedback'),
          _sidebarItem(5, Icons.campaign_outlined, 'System Notifications'),
          const Spacer(),
          _sidebarItem(6, Icons.logout_rounded, 'Logout'),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _sidebarItem(int index, IconData icon, String title) {
    bool isSelected = _selectedIndex == index;
    return ListTile(
      onTap: () => setState(() => _selectedIndex = index),
      leading: Icon(icon, color: isSelected ? const Color(0xFF12B8A6) : const Color(0xFF9CA3AF)),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          color: isSelected ? const Color(0xFF12B8A6) : const Color(0xFF9CA3AF),
        ),
      ),
      selected: isSelected,
      selectedTileColor: const Color(0xFF12B8A6).withOpacity(0.1),
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
            'System Administration Portal',
            style: GoogleFonts.poppins(fontSize: 14, color: const Color(0xFF6B7280), fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          _iconButton(Icons.settings_outlined),
          const SizedBox(width: 20),
          const CircleAvatar(
            backgroundColor: Color(0xFFF3F4F6),
            child: Icon(Icons.shield_rounded, color: Color(0xFF1F2937), size: 20),
          ),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, size: 20, color: const Color(0xFF6B7280)),
    );
  }

  Widget _buildContent() {
    switch (_selectedIndex) {
      case 0:
        return _buildOverview();
      case 1:
        return _buildApprovals();
      case 2:
        return _buildUserManagement();
      case 3:
        return _buildPayments();
      case 4:
        return _buildFeedback();
      default:
        return const Center(child: Text('Coming Soon'));
    }
  }

  Widget _buildOverview() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('System Overview (DFD 7.0)', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          Row(
            children: [
              _statCard('Total Patients', '18,542', Icons.person, Colors.blue),
              const SizedBox(width: 24),
              _statCard('Doctors', '452', Icons.medical_services, Colors.teal),
              const SizedBox(width: 24),
              _statCard('Labs', '84', Icons.science, Colors.orange),
              const SizedBox(width: 24),
              _statCard('Revenue', '₹4.2M', Icons.payments, Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildApprovals() {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Approve Registrations (DFD 3.0)', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: ListView.separated(
                itemCount: 4,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) => ListTile(
                  contentPadding: const EdgeInsets.all(20),
                  leading: const CircleAvatar(backgroundColor: Color(0xFFEAF8F6), child: Icon(Icons.business, color: Color(0xFF12B8A6))),
                  title: Text('New Provider: Apollo Diagnostic Lab ${index + 1}', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                  subtitle: const Text('Registration Date: 12 Jan 2026'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(onPressed: () {}, child: const Text('Reject', style: TextStyle(color: Colors.red))),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF12B8A6)),
                        child: const Text('Approve'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserManagement() {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('User Management (DFD 2.0)', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => ListTile(
                  title: Text('User Account #$index'),
                  trailing: IconButton(icon: const Icon(Icons.edit_outlined), onPressed: () {}),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPayments() {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Payment Records (DFD 4.0)', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Center(child: Text('Transaction Logs and Settlement Module', style: GoogleFonts.poppins(color: Colors.grey))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedback() {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Review Feedback (DFD 5.0)', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) => ListTile(
                  title: const Text('Highly satisfied with Process 6.0'),
                  subtitle: const Text('By Patient #9012'),
                  trailing: const Icon(Icons.star, color: Colors.amber),
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
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 24),
            Text(val, style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold)),
            Text(title, style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF9CA3AF), fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
