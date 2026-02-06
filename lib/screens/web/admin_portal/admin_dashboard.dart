import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laablume/services/auth_service.dart';

class AdminWebPortal extends StatefulWidget {
  const AdminWebPortal({super.key});

  @override
  State<AdminWebPortal> createState() => _AdminWebPortalState();
}

class _AdminWebPortalState extends State<AdminWebPortal> {
  int _selectedIndex = 0;
  final Color _primaryColor = const Color(0xFF12B8A6);
  final Color _sidebarBg = const Color(0xFF111827);
  final Color _bgColor = const Color(0xFFF9FAFB);

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width >= 1100;
    
    return Scaffold(
      backgroundColor: _bgColor,
      key: GlobalKey<ScaffoldState>(),
      drawer: isDesktop ? null : Drawer(
        width: 280,
        backgroundColor: _sidebarBg,
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
      color: _sidebarBg,
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
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),
          Expanded(
            child: ListView(
              children: [
                _sidebarItem(0, Icons.grid_view_rounded, 'System Overview'),
                _sidebarItem(1, Icons.how_to_reg_rounded, 'Provider Approvals'),
                _sidebarItem(2, Icons.people_alt_rounded, 'User Directories'),
                _sidebarItem(3, Icons.account_balance_wallet_rounded, 'Financial Logs'),
                _sidebarItem(4, Icons.thumbs_up_down_rounded, 'Platform Quality'),
                _sidebarItem(5, Icons.notifications_active_rounded, 'Broadcasts'),
              ],
            ),
          ),
          _sidebarItem(6, Icons.logout_rounded, 'Sign Out'),
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
            color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
          ),
        ),
        selected: isSelected,
        selectedTileColor: _primaryColor.withOpacity(0.1),
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
          Text(
            isDesktop ? 'Master Governance Terminal' : 'Admin Panel',
            style: GoogleFonts.poppins(
              fontSize: showMenu ? 18 : 20, 
              fontWeight: FontWeight.bold, 
              color: const Color(0xFF111827)
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                const SizedBox(width: 8),
                Text('SYSTEM LIVE', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.green)),
              ],
            ),
          ),
          const SizedBox(width: 20),
          const CircleAvatar(
            backgroundColor: Color(0xFFF3F4F6),
            child: Icon(Icons.shield_rounded, color: Color(0xFF1F2937), size: 20),
          ),
        ],
      ),
    );
  }

  bool get isDesktop => MediaQuery.of(context).size.width >= 1100;

  Widget _buildContent(bool isDesktop) {
    switch (_selectedIndex) {
      case 0: return _buildOverview(isDesktop);
      case 1: return _buildApprovals(isDesktop);
      case 2: return _buildPlaceholder('User Management');
      default: return _buildPlaceholder('Feature Module');
    }
  }

  Widget _buildOverview(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Ecosystem Vitals', 'Real-time platform performance metrics.'),
        const SizedBox(height: 32),
        _buildStatsGrid(isDesktop),
        const SizedBox(height: 40),
        if (isDesktop)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: _buildRegistrationTrends()),
              const SizedBox(width: 32),
              Expanded(flex: 1, child: _buildSecurityAlerts()),
            ],
          )
        else
          Column(
            children: [
              _buildRegistrationTrends(),
              const SizedBox(height: 32),
              _buildSecurityAlerts(),
            ],
          ),
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
      _statCard('Total Patients', '18,542', Icons.person_rounded, Colors.blue),
      _statCard('Active Doctors', '452', Icons.medical_services_rounded, Colors.teal),
      _statCard('Partner Labs', '84', Icons.biotech_rounded, Colors.orange),
      _statCard('Platform Revenue', '₹4.2M', Icons.payments_rounded, Colors.green),
    ];

    if (isDesktop) {
      return Row(children: stats.map((e) => Expanded(child: Padding(padding: const EdgeInsets.only(right: 20), child: e))).toList());
    } else {
      return GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: MediaQuery.of(context).size.width < 600 ? 1 : 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 1.5,
        children: stats,
      );
    }
  }

  Widget _statCard(String title, String val, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(14)),
            child: Icon(icon, color: color, size: 24),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(val, style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937))),
              Text(title, style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF9CA3AF), fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildApprovals(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Provider Verification', 'Review and authorize new medical partners.'),
        const SizedBox(height: 32),
        FutureBuilder<List<dynamic>>(
          future: AuthService().getPendingHospitals(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Padding(
                padding: EdgeInsets.all(50.0),
                child: CircularProgressIndicator(),
              ));
            }
            
            final pending = snapshot.data ?? [];
            
            if (pending.isEmpty) {
              return Center(
                child: Container(
                  padding: const EdgeInsets.all(48),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.check_circle_outline_rounded, size: 64, color: Colors.green.withOpacity(0.5)),
                      const SizedBox(height: 16),
                      Text('No pending approvals at the moment.', style: GoogleFonts.poppins(color: Colors.grey)),
                    ],
                  ),
                ),
              );
            }

            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 20)],
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: pending.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final partner = pending[index];
                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: _primaryColor.withOpacity(0.1),
                          child: Icon(Icons.business_rounded, color: _primaryColor),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(partner['hospitalName'] ?? 'Unnamed Partner', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
                              const SizedBox(height: 4),
                              Text('Email: ${partner['email']} • Phone: ${partner['mobileNumber']}', style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF6B7280))),
                            ],
                          ),
                        ),
                        if (isDesktop) 
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _actionBtn('Review Details', Colors.grey, false, () {}),
                              const SizedBox(width: 12),
                              _actionBtn('Approve Partner', _primaryColor, true, () async {
                                try {
                                  await AuthService().approveHospital(partner['id']);
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Hospital approved successfully')));
                                    setState(() {}); // Refresh
                                  }
                                } catch (e) {
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                                  }
                                }
                              }),
                            ],
                          )
                        else
                          IconButton(
                            icon: const Icon(Icons.more_vert), 
                            onPressed: () => _showMobileActionMenu(context, partner)
                          ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  void _showMobileActionMenu(BuildContext context, dynamic partner) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(partner['hospitalName'], style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Review Details'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.check_circle_outline, color: Colors.green),
              title: const Text('Approve Partner', style: TextStyle(color: Colors.green)),
              onTap: () async {
                Navigator.pop(context);
                try {
                  await AuthService().approveHospital(partner['id']);
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Hospital approved successfully')));
                    setState(() {});
                  }
                } catch (e) {
                   if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionBtn(String label, Color color, bool filled, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: filled ? color : Colors.white,
        foregroundColor: filled ? Colors.white : color,
        elevation: 0,
        side: filled ? BorderSide.none : BorderSide(color: color.withOpacity(0.2)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(label, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildRegistrationTrends() {
    return Container(
      height: 400,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Growth Analytics', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
          const Spacer(),
          Center(child: Icon(Icons.insights_rounded, size: 80, color: _primaryColor.withOpacity(0.2))),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildSecurityAlerts() {
    return Container(
      height: 400,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: const Color(0xFF1F2937), borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Security Log', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 24),
          _securityItem('Suspicious login attempt blocked', 'IP: 192.168.1.45', Colors.orange),
          _securityItem('Database backup successful', 'Cloud Cluster A', Colors.green),
          _securityItem('SSL Certificate renewal due', 'Expires in 14 days', Colors.red),
        ],
      ),
    );
  }

  Widget _securityItem(String msg, String sub, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(width: 4, height: 40, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10))),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(msg, style: GoogleFonts.poppins(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
                Text(sub, style: GoogleFonts.poppins(color: Colors.white60, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder(String title) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.auto_awesome_rounded, size: 60, color: _primaryColor.withOpacity(0.3)),
          const SizedBox(height: 16),
          Text('$title Terminal is active.', style: GoogleFonts.poppins(color: Colors.grey)),
        ],
      ),
    );
  }
}
