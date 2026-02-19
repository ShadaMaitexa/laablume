import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../providers/user_provider.dart';
import 'package:laablume/screens/web/common/landing_page.dart';
import 'package:laablume/services/admin_service.dart';
import 'package:laablume/services/test_service.dart';

class AdminWebPortal extends StatefulWidget {
  const AdminWebPortal({super.key});

  @override
  State<AdminWebPortal> createState() => _AdminWebPortalState();
}

class _AdminWebPortalState extends State<AdminWebPortal> {
  int _selectedIndex = 0;
  int _approvalTypeIndex = 0; // 0 for Hospitals, 1 for Doctors, 2 for Labs
  final Color _primaryColor = const Color(0xFF12B8A6);
  final Color _sidebarBg = const Color(0xFF111827);
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
                _sidebarItem(3, Icons.biotech_rounded, 'Test Catalog'),
                _sidebarItem(
                  4,
                  Icons.calendar_month_rounded,
                  'Global Bookings',
                ),
                _sidebarItem(5, Icons.rate_review_rounded, 'Patient Feedback'),
              ],
            ),
          ),
          _sidebarItem(
            6,
            Icons.logout_rounded,
            'Sign Out',
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
            color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
          ),
        ),
        selected: isSelected,
        selectedTileColor: _primaryColor.withOpacity(0.1),
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
                isDesktop ? 'Master Governance Terminal' : 'Admin Panel',
                style: GoogleFonts.poppins(
                  fontSize: showMenu ? 18 : 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF111827),
                ),
              ),
              if (user != null)
                Text(
                  'Connected as: ${user.name}',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFF6B7280),
                  ),
                ),
            ],
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
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'SYSTEM LIVE',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          const CircleAvatar(
            backgroundColor: Color(0xFFF3F4F6),
            child: Icon(
              Icons.shield_rounded,
              color: Color(0xFF1F2937),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  bool get isDesktop => MediaQuery.of(context).size.width >= 1100;

  Widget _buildContent(bool isDesktop) {
    switch (_selectedIndex) {
      case 0:
        return _buildOverview(isDesktop);
      case 1:
        return _buildApprovals(isDesktop);
      case 2:
        return _buildUserDirectory(isDesktop);
      case 3:
        return _buildTestCatalog(isDesktop);
      case 4:
        return _buildBookingsTerminal(isDesktop);
      case 5:
        return _buildFeedbackTerminal(isDesktop);
      default:
        return _buildPlaceholder('Feature Module');
    }
  }

  Widget _buildOverview(bool isDesktop) {
    return FutureBuilder<Map<String, dynamic>>(
      future: AdminService().getSystemReports(),
      builder: (context, snapshot) {
        final data = snapshot.data ?? {};
        final stats = Map<String, dynamic>.from(
          data['stats'] ?? data['data'] ?? {},
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(
              'Ecosystem Vitals',
              'Real-time platform performance metrics.',
            ),
            const SizedBox(height: 32),
            _buildStatsGrid(isDesktop, stats),
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
      },
    );
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

  Widget _buildStatsGrid(bool isDesktop, Map data) {
    List<Widget> stats = [
      _statCard(
        'Total Patients',
        data['totalPatients']?.toString() ?? '--',
        Icons.person_rounded,
        Colors.blue,
      ),
      _statCard(
        'Active Doctors',
        data['activeDoctors']?.toString() ?? '--',
        Icons.medical_services_rounded,
        Colors.teal,
      ),
      _statCard(
        'Partner Labs',
        data['totalLabs']?.toString() ?? '--',
        Icons.biotech_rounded,
        Colors.orange,
      ),
      _statCard(
        'Platform Revenue',
        data['revenue'] != null ? '₹${data['revenue']}' : '--',
        Icons.payments_rounded,
        Colors.green,
      ),
    ];

    if (isDesktop) {
      return Row(
        children: stats
            .map(
              (e) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: e,
                ),
              ),
            )
            .toList(),
      );
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                val,
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1F2937),
                ),
              ),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: const Color(0xFF9CA3AF),
                  fontWeight: FontWeight.w500,
                ),
              ),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSectionHeader(
              'Provider Verification',
              'Review and authorize new medical partners.',
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _primaryColor.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  _tabBtn('Hospitals', 0),
                  _tabBtn('Doctors', 1),
                  _tabBtn('Labs', 2),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        FutureBuilder<List<dynamic>>(
          future: _approvalTypeIndex == 0
              ? AdminService().getPendingHospitals()
              : _approvalTypeIndex == 1
              ? AdminService().getPendingDoctors()
              : AdminService().getPendingLabs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(50.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            final pending = snapshot.data ?? [];

            if (pending.isEmpty) {
              return _emptyState(
                'No pending ${_approvalTypeIndex == 0
                    ? "hospitals"
                    : _approvalTypeIndex == 1
                    ? "doctors"
                    : "labs"} found.',
              );
            }

            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: pending.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final partner = pending[index];
                  final name =
                      partner['hospitalName'] ??
                      partner['labName'] ??
                      partner['name'] ??
                      'Unnamed Partner';
                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: _primaryColor.withOpacity(0.1),
                          child: Icon(
                            _approvalTypeIndex == 0
                                ? Icons.business_rounded
                                : _approvalTypeIndex == 1
                                ? Icons.local_hospital_rounded
                                : Icons.science_rounded,
                            color: _primaryColor,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Email: ${partner['email']} • Phone: ${partner['mobileNumber'] ?? partner['phone']}',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: const Color(0xFF6B7280),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isDesktop)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _actionBtn(
                                'Approve Partner',
                                _primaryColor,
                                true,
                                () async {
                                  try {
                                    if (_approvalTypeIndex == 0) {
                                      await AdminService().approveHospital(
                                        partner['id'] ?? partner['_id'],
                                      );
                                    } else if (_approvalTypeIndex == 1) {
                                      await AdminService().approveDoctor(
                                        partner['id'] ?? partner['_id'],
                                      );
                                    } else {
                                      await AdminService().approveLab(
                                        partner['id'] ?? partner['_id'],
                                      );
                                    }
                                    if (mounted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Partner approved successfully',
                                          ),
                                        ),
                                      );
                                      setState(() {});
                                    }
                                  } catch (e) {
                                    if (mounted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(content: Text('Error: $e')),
                                      );
                                    }
                                  }
                                },
                              ),
                            ],
                          )
                        else
                          IconButton(
                            icon: const Icon(Icons.more_vert),
                            onPressed: () =>
                                _showMobileActionMenu(context, partner),
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

  Widget _tabBtn(String label, int index) {
    bool isSelected = _approvalTypeIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _approvalTypeIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? _primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFF6B7280),
          ),
        ),
      ),
    );
  }

  Widget _emptyState(String msg) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            Icon(
              Icons.check_circle_outline_rounded,
              size: 64,
              color: Colors.green.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(msg, style: GoogleFonts.poppins(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildUserDirectory(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          'User Directory',
          'Manage and audit platform users and their access status.',
        ),
        const SizedBox(height: 32),
        FutureBuilder<List<dynamic>>(
          future: AdminService().getUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final users = snapshot.data ?? [];
            if (users.isEmpty)
              return _emptyState('No users found in the system.');

            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.01),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: users.length,
                separatorBuilder: (c, i) => const Divider(height: 1),
                itemBuilder: (c, i) {
                  final user = users[i];
                  bool isActive = user['isActive'] ?? true;
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: _primaryColor.withOpacity(0.1),
                          child: Text(
                            (user['name'] ?? 'U')[0].toUpperCase(),
                            style: TextStyle(
                              color: _primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user['name'] ?? 'Anonymous User',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '${user['role']?.toString().toUpperCase()} • ${user['phone'] ?? user['mobileNumber']}',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isActive
                                ? Colors.green.withOpacity(0.1)
                                : Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            isActive ? 'ACTIVE' : 'SUSPENDED',
                            style: TextStyle(
                              color: isActive ? Colors.green : Colors.red,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        _actionBtn(
                          isActive ? 'Suspend' : 'Activate',
                          isActive ? Colors.red : Colors.green,
                          false,
                          () async {
                            try {
                              await AdminService().updateUserStatus(
                                user['id'] ?? user['_id'],
                                !isActive,
                              );
                              setState(() {});
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error: $e')),
                              );
                            }
                          },
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

  Widget _buildTestCatalog(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSectionHeader(
              'Test Catalog',
              'Global directory of diagnostic tests available on the platform.',
            ),
            _actionBtn(
              'Add New Test',
              _primaryColor,
              true,
              () => _showAddTestDialog(context),
            ),
          ],
        ),
        const SizedBox(height: 32),
        FutureBuilder<List<dynamic>>(
          future: TestService().getAllTests(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final tests = snapshot.data ?? [];
            if (tests.isEmpty)
              return _emptyState('No tests found in the catalog.');

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isDesktop ? 3 : 1,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 2.5,
              ),
              itemCount: tests.length,
              itemBuilder: (context, index) {
                final test = tests[index];
                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.01),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _primaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.biotech_rounded,
                          color: _primaryColor,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              test['name'] ?? 'Medical Test',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              test['category'] ?? 'Diagnostic',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '₹${test['price'] ?? '0'}',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: _primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildBookingsTerminal(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          'Global Bookings',
          'Audit and track every medical engagement across the LabLume ecosystem.',
        ),
        const SizedBox(height: 32),
        FutureBuilder<List<dynamic>>(
          future: AdminService().getAllBookings(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final bookings = snapshot.data ?? [];
            if (bookings.isEmpty)
              return _emptyState('No bookings found on the platform.');

            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.01),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: bookings.length,
                separatorBuilder: (c, i) => const Divider(height: 1),
                itemBuilder: (c, i) {
                  final booking = bookings[i];
                  final patientName =
                      booking['patientName'] ??
                      booking['userName'] ??
                      'Anonymous';
                  final providerName =
                      booking['hospitalName'] ??
                      booking['labName'] ??
                      'Platform Provider';
                  final status = (booking['status'] ?? 'pending')
                      .toString()
                      .toUpperCase();
                  final date = booking['date'] ?? 'N/A';

                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: _primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.event_note_rounded,
                            color: _primaryColor,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$patientName • $providerName',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '${booking['type']?.toString().toUpperCase() ?? 'ENGAGEMENT'} • $date',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        _statusBadge(status),
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

  Widget _statusBadge(String status) {
    Color color = Colors.orange;
    if (status == 'COMPLETED' || status == 'APPROVED') color = Colors.green;
    if (status == 'CANCELLED' || status == 'REJECTED') color = Colors.red;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildFeedbackTerminal(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          'Patient Feedback',
          'Insights into patient satisfaction and service quality platform-wide.',
        ),
        const SizedBox(height: 32),
        FutureBuilder<List<dynamic>>(
          future: AdminService().getFeedback(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final feedbackList = snapshot.data ?? [];
            if (feedbackList.isEmpty) {
              return _emptyState('No recent feedback available.');
            }

            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.01),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: feedbackList.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final feedback = feedbackList[index];
                  final patientName =
                      feedback['patientName'] ??
                      feedback['userName'] ??
                      'Anonymous'; // Fallback
                  final rating = (feedback['rating'] is int)
                      ? feedback['rating']
                      : int.tryParse(feedback['rating'].toString()) ?? 5;
                  final comment =
                      feedback['comment'] ??
                      feedback['message'] ??
                      'No comments provided.';
                  final date = feedback['date'] ?? 'Recent';

                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: _primaryColor.withOpacity(0.1),
                          child: Text(
                            'P${index + 1}',
                            style: TextStyle(
                              color: _primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    patientName,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  ...List.generate(
                                    5,
                                    (s) => Icon(
                                      Icons.star_rounded,
                                      color: s < rating
                                          ? Colors.amber
                                          : Colors.grey.shade300,
                                      size: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                comment,
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          date,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
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

  void _showAddTestDialog(BuildContext context) {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final categoryController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Add New Test',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Test Name'),
            ),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price (₹)'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                await TestService().createTest({
                  'name': nameController.text.trim(),
                  'category': categoryController.text.trim(),
                  'price': double.tryParse(priceController.text.trim()) ?? 0.0,
                  'description': descriptionController.text.trim(),
                });
                if (context.mounted) {
                  Navigator.pop(context);
                  setState(() {});
                }
              } catch (e) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Error: $e')));
              }
            },
            child: const Text('Add Test'),
          ),
        ],
      ),
    );
  }

  void _showMobileActionMenu(BuildContext context, dynamic partner) {
    final name =
        partner['hospitalName'] ??
        partner['labName'] ??
        partner['name'] ??
        'Partner';
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              name,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Review Details'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
              ),
              title: const Text(
                'Approve Partner',
                style: TextStyle(color: Colors.green),
              ),
              onTap: () async {
                Navigator.pop(context);
                try {
                  if (_approvalTypeIndex == 0) {
                    await AdminService().approveHospital(
                      partner['id'] ?? partner['_id'],
                    );
                  } else {
                    await AdminService().approveLab(
                      partner['id'] ?? partner['_id'],
                    );
                  }
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Partner approved successfully'),
                      ),
                    );
                    setState(() {});
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Error: $e')));
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionBtn(
    String label,
    Color color,
    bool filled,
    VoidCallback onTap,
  ) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: filled ? color : Colors.white,
        foregroundColor: filled ? Colors.white : color,
        elevation: 0,
        side: filled
            ? BorderSide.none
            : BorderSide(color: color.withOpacity(0.2)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildRegistrationTrends() {
    return FutureBuilder<Map<String, dynamic>>(
      future: AdminService().getGrowthTrends(),
      builder: (context, snapshot) {
        final data = snapshot.data ?? {};
        final growth = data['growth'] ?? '+0%';
        final newUsers = data['newUsers'] ?? 0;
        final period = data['period'] ?? 'This Month';

        return Container(
          height: 400,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Growth Analytics',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '$newUsers New Users',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: _primaryColor,
                ),
              ),
              Text(
                'Growth: $growth ($period)',
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
              ),
              const Spacer(),
              // Simple Visual Bar Chart Placeholder using Containers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(7, (index) {
                  // Mock visual height based on index if data not granular
                  final height = 50.0 + (index * 20) % 150;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 30,
                        height: height,
                        decoration: BoxDecoration(
                          color: _primaryColor.withOpacity(0.2 + (index * 0.1)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Day ${index + 1}',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  );
                }),
              ),
              const Spacer(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSecurityAlerts() {
    return FutureBuilder<List<dynamic>>(
      future: AdminService().getSecurityLogs(),
      builder: (context, snapshot) {
        final logs = snapshot.data ?? [];

        return Container(
          height: 400,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: const Color(0xFF1F2937),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Security Log',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              if (logs.isEmpty)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.security,
                          color: Colors.green,
                          size: 48,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No active threats.',
                          style: GoogleFonts.poppins(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: logs.length,
                    itemBuilder: (context, index) {
                      final log = logs[index];
                      final msg = log['message'] ?? 'System Event';
                      final sub = log['details'] ?? 'No details';
                      final type = log['type'] ?? 'info';

                      Color color = Colors.blue;
                      if (type == 'warning') color = Colors.orange;
                      if (type == 'critical' || type == 'error')
                        color = Colors.red;
                      if (type == 'success') color = Colors.green;

                      return _securityItem(msg, sub, color);
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _securityItem(String msg, String sub, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  msg,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  sub,
                  style: GoogleFonts.poppins(
                    color: Colors.white60,
                    fontSize: 11,
                  ),
                ),
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
          Icon(
            Icons.auto_awesome_rounded,
            size: 60,
            color: _primaryColor.withOpacity(0.3),
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
