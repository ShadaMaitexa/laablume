import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../services/lab_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

class LabBookingsScreen extends StatefulWidget {
  const LabBookingsScreen({super.key});

  @override
  State<LabBookingsScreen> createState() => _LabBookingsScreenState();
}

class _LabBookingsScreenState extends State<LabBookingsScreen> {
  int _selectedFilter = 0;
  List<dynamic> _bookings = [];
  bool _isLoading = true;
  final LabService _labService = LabService();

  @override
  void initState() {
    super.initState();
    _fetchBookings();
  }

  Future<void> _fetchBookings() async {
    setState(() => _isLoading = true);
    try {
      String? status;
      if (_selectedFilter == 1) status = 'Pending';
      if (_selectedFilter == 2) status = 'In-Progress';
      if (_selectedFilter == 3) status = 'Completed';

      final data = await _labService.getBookings(status: status);
      setState(() {
        _bookings = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error fetching bookings: $e')));
    }
  }

  Future<void> _updateStatus(String id, String newStatus) async {
    try {
      await _labService.updateBookingStatus(id, newStatus);
      _fetchBookings();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Status updated to $newStatus')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error updating status: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Test Bookings',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1F2937),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  _showManualBooking(context);
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Offline Booking'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF12B8A6),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      _statusChip('All', 0),
                      _statusChip('Pending', 1),
                      _statusChip('In-Progress', 2),
                      _statusChip('Completed', 3),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF12B8A6),
                            ),
                          )
                        : _bookings.isEmpty
                        ? const Center(child: Text('No bookings found'))
                        : ListView.separated(
                            itemCount: _bookings.length,
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemBuilder: (context, index) =>
                                _bookingListItem(_bookings[index]),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusChip(String text, int index) {
    bool active = _selectedFilter == index;
    return GestureDetector(
      onTap: () {
        setState(() => _selectedFilter = index);
        _fetchBookings();
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF12B8A6) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: active ? null : Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: active ? FontWeight.bold : FontWeight.w500,
            color: active ? Colors.white : const Color(0xFF6B7280),
          ),
        ),
      ),
    );
  }

  Widget _bookingListItem(dynamic booking) {
    String id = booking['id']?.toString() ?? booking['_id']?.toString() ?? '';
    String patientName =
        booking['patient_name'] ?? booking['userName'] ?? 'Unknown';
    String testName =
        booking['test_name'] ?? booking['testName'] ?? 'General Test';
    String status = booking['status'] ?? 'Pending';
    String date = booking['createdAt'] != null
        ? DateFormat(
            'dd MMM yyyy, hh:mm a',
          ).format(DateTime.parse(booking['createdAt']))
        : 'Date Unavailable';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.receipt_long_rounded,
              color: Color(0xFF12B8A6),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Booking #$id',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                Text(
                  date,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              patientName,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              testName,
              style: GoogleFonts.poppins(color: const Color(0xFF12B8A6)),
            ),
          ),
          Expanded(
            child: Text(
              '₹${booking['price'] ?? booking['total_price'] ?? '0'}',
            ),
          ),
          _statusActions(id, status),
        ],
      ),
    );
  }

  Widget _statusActions(String id, String currentStatus) {
    if (currentStatus == 'Completed') {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'Completed',
          style: GoogleFonts.poppins(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      );
    }

    return PopupMenuButton<String>(
      onSelected: (val) => _updateStatus(id, val),
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'Collected',
          child: Text('Sample Collected'),
        ),
        const PopupMenuItem(value: 'In-Lab', child: Text('In Lab Analysis')),
        const PopupMenuItem(value: 'Completed', child: Text('Completed')),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF12B8A6)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              currentStatus,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF12B8A6),
              ),
            ),
            const Icon(
              Icons.arrow_drop_down,
              color: Color(0xFF12B8A6),
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  void _showManualBooking(BuildContext context) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final testController = TextEditingController();
    final priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Offline Booking'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Patient Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Contact Number'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: testController,
              decoration: const InputDecoration(labelText: 'Test Type'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price'),
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
                await _labService.createBooking({
                  'patient_name': nameController.text,
                  'patient_phone': phoneController.text,
                  'test_name': testController.text,
                  'price': priceController.text,
                  'isOffline': true,
                  'status': 'Pending',
                });
                _fetchBookings();
                Navigator.pop(context);
              } catch (e) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Error: $e')));
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF12B8A6),
            ),
            child: const Text('Save Booking'),
          ),
        ],
      ),
    );
  }
}

// LabInventoryScreen removed as per requirement: "no need an inventory management and reagent add area"

class LabResultsApprovalScreen extends StatefulWidget {
  const LabResultsApprovalScreen({super.key});

  @override
  State<LabResultsApprovalScreen> createState() =>
      _LabResultsApprovalScreenState();
}

class _LabResultsApprovalScreenState extends State<LabResultsApprovalScreen> {
  final LabService _labService = LabService();
  List<dynamic> _pendingValidations = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPending();
  }

  Future<void> _fetchPending() async {
    setState(() => _isLoading = true);
    try {
      // Fetching bookings that are in 'In-Lab' status for validation
      final data = await _labService.getBookings(status: 'In-Lab');
      setState(() {
        _pendingValidations = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _approveReport(String id) async {
    try {
      await _labService.validateReport(id);
      _fetchPending();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Report validated successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Results Validation',
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Pathologist review and final approval for clinical reports.',
            style: GoogleFonts.poppins(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _pendingValidations.isEmpty
                  ? const Center(child: Text('No reports pending validation'))
                  : ListView.separated(
                      itemCount: _pendingValidations.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final item = _pendingValidations[index];
                        final id =
                            item['id']?.toString() ??
                            item['_id']?.toString() ??
                            '';
                        return ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Color(0xFFE0F2F1),
                            child: Icon(
                              Icons.verified_user_rounded,
                              color: Color(0xFF12B8A6),
                            ),
                          ),
                          title: Text(
                            'Sample #$id - ${item['patient_name'] ?? item['userName']}',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            '${item['test_name'] ?? 'General Test'} • Received for review',
                            style: GoogleFonts.poppins(fontSize: 12),
                          ),
                          trailing: ElevatedButton(
                            onPressed: () => _approveReport(id),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF12B8A6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Approve & Sign'),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class LabTechniciansScreen extends StatefulWidget {
  const LabTechniciansScreen({super.key});

  @override
  State<LabTechniciansScreen> createState() => _LabTechniciansScreenState();
}

class _LabTechniciansScreenState extends State<LabTechniciansScreen> {
  final LabService _labService = LabService();
  List<dynamic> _staff = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchStaff();
  }

  Future<void> _fetchStaff() async {
    setState(() => _isLoading = true);
    try {
      final data = await _labService.getStaff();
      setState(() {
        _staff = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lab Staff',
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 24,
                          childAspectRatio: 3,
                        ),
                    itemCount: _staff.length,
                    itemBuilder: (context, index) {
                      final member = _staff[index];
                      return Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.02),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                    member['photo'] ??
                                        'https://i.pravatar.cc/150?u=${member['name']}',
                                  ),
                                  onBackgroundImageError: (e, s) =>
                                      const Icon(Icons.person),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        member['name'],
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        member['role'],
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: const Color(0xFF12B8A6),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete_outline,
                                        size: 18,
                                        color: Colors.redAccent,
                                      ),
                                      onPressed: () {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Staff deletion not yet supported by API',
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Divider(),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _staffDetail(
                                  'Experience',
                                  member['experience'],
                                ),
                                _staffDetail(
                                  'Specialization',
                                  member['specialization'],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _staffDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 10,
            color: const Color(0xFF9CA3AF),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class LabSettingsScreen extends StatefulWidget {
  const LabSettingsScreen({super.key});

  @override
  State<LabSettingsScreen> createState() => _LabSettingsScreenState();
}

class _LabSettingsScreenState extends State<LabSettingsScreen> {
  int _currentView = 0;
  final List<Map<String, dynamic>> _equipment = [
    {'name': 'Chemical Analyzer A1', 'status': 'Online', 'isActive': true},
    {'name': 'Hematology Auto-Sys', 'status': 'Online', 'isActive': true},
    {'name': 'Centrifuge Unit 4', 'status': 'Offline', 'isActive': false},
    {'name': 'Microscope Digital X1', 'status': 'Online', 'isActive': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (_currentView != 0)
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => setState(() => _currentView = 0),
                ),
              Text(
                _currentView == 0
                    ? 'Lab Configuration'
                    : _currentView == 1
                    ? 'Diagnostic Equipment'
                    : _currentView == 2
                    ? 'Report Templates'
                    : 'Data Export Preferences',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(child: _buildMainContent()),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    switch (_currentView) {
      case 1:
        return _buildEquipmentSetup();
      case 2:
        return _buildTemplateEditor();
      case 3:
        return _buildExportSettings();
      default:
        return _buildSettingsList();
    }
  }

  Widget _buildSettingsList() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.settings_outlined,
            size: 80,
            color: Color(0xFF12B8A6),
          ),
          const SizedBox(height: 48),
          _labSettingItem(
            'Diagnostic Equipment Setup',
            Icons.biotech_outlined,
            () => setState(() => _currentView = 1),
          ),
          _labSettingItem(
            'Report Templates',
            Icons.description_outlined,
            () => setState(() => _currentView = 2),
          ),
          _labSettingItem(
            'Data Export Preferences',
            Icons.ios_share_rounded,
            () => setState(() => _currentView = 3),
          ),
        ],
      ),
    );
  }

  Widget _buildEquipmentSetup() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _equipment.length,
              itemBuilder: (context, index) {
                final item = _equipment[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFF3F4F6)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'],
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              item['status'],
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: item['isActive']
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: item['isActive'],
                        onChanged: (v) {
                          setState(() {
                            _equipment[index]['isActive'] = v;
                            _equipment[index]['status'] = v
                                ? 'Online'
                                : 'Offline';
                          });
                        },
                        activeColor: const Color(0xFF12B8A6),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.redAccent,
                        ),
                        onPressed: () =>
                            setState(() => _equipment.removeAt(index)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              final controller = TextEditingController();
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Add New Equipment'),
                  content: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      labelText: 'Equipment Name',
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _equipment.add({
                            'name': controller.text,
                            'status': 'Online',
                            'isActive': true,
                          });
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF12B8A6),
                      ),
                      child: const Text('Add'),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('Add New Equipment'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF12B8A6),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExportSettings() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Format Preferences',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _radioOption('PDF (Standard Human Readable)'),
          _radioOption('JSON (Digital Integration)'),
          _radioOption('CSV (Bulk Data Processing)'),
          const SizedBox(height: 32),
          Text(
            'Automation Frequency',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _radioOption('Real-time (on validation)'),
          _radioOption('Daily Batch (at 11:59 PM)'),
          _radioOption('Manual Export only'),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => setState(() => _currentView = 0),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF12B8A6),
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Save Export Config'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateEditor() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _templateTile('Standard Blood Report', 'Last edited 2 days ago'),
          _templateTile('Full Body Checkup Summary', 'Last edited 1 week ago'),
          _templateTile(
            'COVID-19 Result Certificate',
            'Last edited 1 month ago',
          ),
        ],
      ),
    );
  }

  Widget _templateTile(String title, String subtitle) {
    return ListTile(
      leading: const Icon(Icons.article_outlined, color: Color(0xFF12B8A6)),
      title: Text(
        title,
        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(subtitle, style: GoogleFonts.poppins(fontSize: 12)),
      trailing: const Icon(Icons.edit_outlined),
      onTap: () {},
    );
  }

  Widget _radioOption(String text) {
    return Row(
      children: [
        Radio(
          value: text,
          groupValue: 'PDF (Standard Human Readable)',
          onChanged: (v) {},
        ),
        Text(text, style: GoogleFonts.poppins(fontSize: 14)),
      ],
    );
  }

  Widget _labSettingItem(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 500,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.01), blurRadius: 5),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF12B8A6), size: 20),
            const SizedBox(width: 16),
            Text(
              title,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            const Icon(Icons.chevron_right, color: Color(0xFFE5E7EB)),
          ],
        ),
      ),
    );
  }
}

class LabReportUploadScreen extends StatefulWidget {
  const LabReportUploadScreen({super.key});

  @override
  State<LabReportUploadScreen> createState() => _LabReportUploadScreenState();
}

class _LabReportUploadScreenState extends State<LabReportUploadScreen> {
  final LabService _labService = LabService();
  List<dynamic> _patients = [];
  bool _isLoading = true;
  String? _selectedPatientId;
  String? _selectedPatientName;
  String? _selectedFileName;

  @override
  void initState() {
    super.initState();
    _fetchPatients();
  }

  Future<void> _fetchPatients() async {
    setState(() => _isLoading = true);
    try {
      // Fetching completed bookings to upload reports
      final data = await _labService.getBookings(status: 'Completed');
      setState(() {
        _patients = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _selectedFileName = result.files.single.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Upload Lab Reports',
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Select a patient with completed test status and upload their report.',
            style: GoogleFonts.poppins(color: const Color(0xFF6B7280)),
          ),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ready for Report',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : _patients.isEmpty
                          ? const Center(
                              child: Text('No completed tests pending report'),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              itemCount: _patients.length,
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemBuilder: (context, index) {
                                final p = _patients[index];
                                bool isSelected =
                                    _selectedPatientId == p['id'].toString();
                                return ListTile(
                                  onTap: () => setState(() {
                                    _selectedPatientId = p['id'].toString();
                                    _selectedPatientName =
                                        p['patient_name'] ?? p['userName'];
                                  }),
                                  leading: CircleAvatar(
                                    backgroundColor: isSelected
                                        ? const Color(0xFF12B8A6)
                                        : const Color(0xFFF3F4F6),
                                    child: Text(
                                      (p['patient_name'] ?? 'P')[0],
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : const Color(0xFF1F2937),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    p['patient_name'] ??
                                        p['userName'] ??
                                        'Unknown',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Test: ${p['test_name'] ?? 'General'}',
                                    style: GoogleFonts.poppins(fontSize: 12),
                                  ),
                                  trailing: isSelected
                                      ? const Icon(
                                          Icons.check_circle,
                                          color: Color(0xFF12B8A6),
                                        )
                                      : null,
                                );
                              },
                            ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE5E7EB)),
                        ),
                        child: InkWell(
                          onTap: _pickFile,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.cloud_upload_outlined,
                                size: 64,
                                color: Color(0xFF12B8A6),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                _selectedFileName ??
                                    'Click to browse report PDF',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF4B5563),
                                ),
                              ),
                              if (_selectedPatientName != null)
                                Text(
                                  'For: $_selectedPatientName',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: const Color(0xFF12B8A6),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed:
                              _selectedPatientId == null ||
                                  _selectedFileName == null
                              ? null
                              : () async {
                                  try {
                                    await _labService.uploadReport({
                                      'booking_id': _selectedPatientId,
                                      'file_name': _selectedFileName,
                                      // In real app, we would upload actual file
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Report uploaded and patient notified!',
                                        ),
                                      ),
                                    );
                                    setState(() {
                                      _selectedPatientId = null;
                                      _selectedFileName = null;
                                    });
                                    _fetchPatients();
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Error: $e')),
                                    );
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF12B8A6),
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Finalize & Send Report',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LabTestCatalogScreen extends StatefulWidget {
  const LabTestCatalogScreen({super.key});

  @override
  State<LabTestCatalogScreen> createState() => _LabTestCatalogScreenState();
}

class _LabTestCatalogScreenState extends State<LabTestCatalogScreen> {
  final LabService _labService = LabService();
  List<dynamic> _tests = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTests();
  }

  Future<void> _fetchTests() async {
    setState(() => _isLoading = true);
    try {
      final data = await _labService.getTests();
      setState(() {
        _tests = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _showTestDialog({dynamic test}) {
    final nameController = TextEditingController(text: test?['name'] ?? '');
    final priceController = TextEditingController(
      text: test?['price']?.toString() ?? '',
    );
    final turnaroundController = TextEditingController(
      text: test?['turnaround'] ?? '',
    );
    bool isAvailable = test?['isAvailable'] ?? true;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(test == null ? 'Add New Test' : 'Edit Test'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Test Name'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Fee (₹)'),
              ),
              TextField(
                controller: turnaroundController,
                decoration: const InputDecoration(
                  labelText: 'Turnaround Time (e.g. 24h)',
                ),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Available for Booking'),
                value: isAvailable,
                onChanged: (v) => setDialogState(() => isAvailable = v),
                activeColor: const Color(0xFF12B8A6),
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
                final data = {
                  'name': nameController.text,
                  'price': priceController.text,
                  'turnaround': turnaroundController.text,
                  'isAvailable': isAvailable,
                };
                try {
                  if (test == null) {
                    await _labService.addTest(data);
                  } else {
                    await _labService.updateTest(test['id'].toString(), data);
                  }
                  _fetchTests();
                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Error: $e')));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF12B8A6),
              ),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Service Catalog',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Manage your available tests and pricing.',
                    style: GoogleFonts.poppins(color: Colors.grey),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () => _showTestDialog(),
                icon: const Icon(Icons.add),
                label: const Text('Add New Test'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF12B8A6),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _tests.isEmpty
                ? const Center(child: Text('No tests registered yet'))
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 2.5,
                        ),
                    itemCount: _tests.length,
                    itemBuilder: (context, index) {
                      final test = _tests[index];
                      return Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.biotech_rounded,
                              color: Color(0xFF12B8A6),
                              size: 32,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    test['name'] ?? 'Unknown Test',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '₹${test['price']} • ${test['turnaround']}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Switch(
                                  value: test['isAvailable'] ?? true,
                                  onChanged: (v) async {
                                    await _labService.updateTest(
                                      test['id'].toString(),
                                      {'isAvailable': v},
                                    );
                                    _fetchTests();
                                  },
                                  activeColor: const Color(0xFF12B8A6),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit, size: 18),
                                  onPressed: () => _showTestDialog(test: test),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    size: 18,
                                    color: Colors.redAccent,
                                  ),
                                  onPressed: () async {
                                    try {
                                      await _labService.deleteTest(
                                        test['id'].toString(),
                                      );
                                      _fetchTests();
                                    } catch (e) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(content: Text('Error: $e')),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class LabFeedbackScreen extends StatefulWidget {
  const LabFeedbackScreen({super.key});

  @override
  State<LabFeedbackScreen> createState() => _LabFeedbackScreenState();
}

class _LabFeedbackScreenState extends State<LabFeedbackScreen> {
  final LabService _labService = LabService();
  List<dynamic> _feedbacks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFeedbacks();
  }

  Future<void> _fetchFeedbacks() async {
    setState(() => _isLoading = true);
    try {
      final data = await _labService.getFeedbacks();
      setState(() {
        _feedbacks = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Patient Reviews',
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _feedbacks.isEmpty
                ? const Center(child: Text('No feedbacks yet'))
                : ListView.separated(
                    itemCount: _feedbacks.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final f = _feedbacks[index];
                      return Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  child: Text((f['patient_name'] ?? 'P')[0]),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      f['patient_name'] ?? 'Anonymous',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: List.generate(
                                        5,
                                        (i) => Icon(
                                          Icons.star,
                                          size: 14,
                                          color: i < (f['rating'] ?? 5)
                                              ? Colors.orange
                                              : Colors.grey[300],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Text(
                                  f['date'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              f['comment'] ?? 'No comment provided',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF4B5563),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class LabProfileScreen extends StatefulWidget {
  const LabProfileScreen({super.key});

  @override
  State<LabProfileScreen> createState() => _LabProfileScreenState();
}

class _LabProfileScreenState extends State<LabProfileScreen> {
  final LabService _labService = LabService();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    setState(() => _isLoading = true);
    try {
      final p = await _labService.getProfile();
      _nameController.text = p['name'] ?? '';
      _addressController.text = p['address'] ?? '';
      _phoneController.text = p['phone'] ?? '';
      _emailController.text = p['email'] ?? '';
      setState(() => _isLoading = false);
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Center(child: CircularProgressIndicator());

    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lab Profile',
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Basic Information',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 24),
                _profileField('Laboratory Name', _nameController),
                const SizedBox(height: 20),
                _profileField('Address', _addressController, maxLines: 3),
                const SizedBox(height: 20),
                _profileField('Contact Phone', _phoneController),
                const SizedBox(height: 20),
                _profileField('Email Address', _emailController),
                const SizedBox(height: 40),
                const Divider(),
                const SizedBox(height: 40),
                Text(
                  'Operating Schedule',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Set your facility hours to manage booking availability.',
                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: _profileField(
                        'Opens At',
                        TextEditingController(text: '08:00 AM'),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _profileField(
                        'Closes At',
                        TextEditingController(text: '08:00 PM'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        await _labService.updateSettings({
                          'name': _nameController.text,
                          'address': _addressController.text,
                          'phone': _phoneController.text,
                          'email': _emailController.text,
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Portal configurations updated!'),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text('Error: $e')));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF12B8A6),
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Save Configurations',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
