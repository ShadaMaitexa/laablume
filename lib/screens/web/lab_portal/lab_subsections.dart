import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LabBookingsScreen extends StatefulWidget {
  const LabBookingsScreen({super.key});

  @override
  State<LabBookingsScreen> createState() => _LabBookingsScreenState();
}

class _LabBookingsScreenState extends State<LabBookingsScreen> {
  int _selectedFilter = 0;

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
                style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937)),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  _showManualBooking(context);
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Offline Booking'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF12B8A6),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  Row(
                    children: [
                      _statusChip('All Bookings (245)', 0),
                      _statusChip('Pending (18)', 1),
                      _statusChip('In-Progress (12)', 2),
                      _statusChip('Completed (215)', 3),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView.separated(
                      itemCount: 10,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) => _bookingListItem(index),
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
      onTap: () => setState(() => _selectedFilter = index),
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

  Widget _bookingListItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.receipt_long_rounded, color: Color(0xFF12B8A6)),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Booking #LB-220$index', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                Text('01 Jan 2026, 10:00 AM', style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF9CA3AF))),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text('Patient Name ${index + 1}', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
          ),
          Expanded(
            flex: 2,
            child: Text('Full Body Checkup', style: GoogleFonts.poppins(color: const Color(0xFF12B8A6))),
          ),
          const Expanded(child: Text('₹2,499')),
          _clickableActionButton('Process', index),
        ],
      ),
    );
  }

  Widget _clickableActionButton(String text, int index) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Processing sample for Booking #LB-220$index')),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF12B8A6)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF12B8A6)),
        ),
      ),
    );
  }

  void _showManualBooking(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Offline Booking'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(decoration: InputDecoration(labelText: 'Patient Name')),
            SizedBox(height: 16),
            TextField(decoration: InputDecoration(labelText: 'Contact Number')),
            SizedBox(height: 16),
            TextField(decoration: InputDecoration(labelText: 'Test Type')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF12B8A6)),
            child: const Text('Save Booking'),
          ),
        ],
      ),
    );
  }
}

// LabInventoryScreen removed as per requirement: "no need an inventory management and reagent add area"

class LabResultsApprovalScreen extends StatelessWidget {
  const LabResultsApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Results Validation', style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: ListView.separated(
                itemCount: 6,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) => ListTile(
                  title: Text('Sample #SAM-88${index + 10} - Alice Brown', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                  subtitle: Text('Sugar Level Test - Ready for Approval', style: GoogleFonts.poppins(fontSize: 12)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Opening detailed review...')));
                        },
                        child: const Text('Review', style: TextStyle(color: Color(0xFF12B8A6))),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sample approved and report generated!')));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF12B8A6),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
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
}

class LabTechniciansScreen extends StatefulWidget {
  const LabTechniciansScreen({super.key});

  @override
  State<LabTechniciansScreen> createState() => _LabTechniciansScreenState();
}

class _LabTechniciansScreenState extends State<LabTechniciansScreen> {
  final List<Map<String, dynamic>> _staff = [
    {
      'name': 'Robert Fox',
      'role': 'Senior Pathologist',
      'status': 'Active',
      'experience': '12 years',
      'specialization': 'Clinical Pathology',
      'photo': 'https://i.pravatar.cc/150?u=robert'
    },
    {
      'name': 'Jane Cooper',
      'role': 'Lab Technician',
      'status': 'On Break',
      'experience': '5 years',
      'specialization': 'Hematology',
      'photo': 'https://i.pravatar.cc/150?u=jane'
    },
    {
      'name': 'Guy Hawkins',
      'role': 'Assistant Technician',
      'status': 'Active',
      'experience': '2 years',
      'specialization': 'Sample Collection',
      'photo': 'https://i.pravatar.cc/150?u=guy'
    },
    {
      'name': 'Eleanor Pena',
      'role': 'Bio-analyst',
      'status': 'Active',
      'experience': '8 years',
      'specialization': 'Biochemistry',
      'photo': 'https://i.pravatar.cc/150?u=eleanor'
    },
  ];

  void _showStaffDialog({int? index}) {
    final nameController = TextEditingController(text: index != null ? _staff[index]['name'] : '');
    final roleController = TextEditingController(text: index != null ? _staff[index]['role'] : '');
    final expController = TextEditingController(text: index != null ? _staff[index]['experience'] : '');
    final specController = TextEditingController(text: index != null ? _staff[index]['specialization'] : '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(index == null ? 'Add Staff Member' : 'Edit Staff'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Full Name')),
              const SizedBox(height: 16),
              TextField(controller: roleController, decoration: const InputDecoration(labelText: 'Role/Position')),
              const SizedBox(height: 16),
              TextField(controller: expController, decoration: const InputDecoration(labelText: 'Years of Experience')),
              const SizedBox(height: 16),
              TextField(controller: specController, decoration: const InputDecoration(labelText: 'Specialization Details')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (index == null) {
                  _staff.add({
                    'name': nameController.text,
                    'role': roleController.text,
                    'status': 'Active',
                    'experience': expController.text,
                    'specialization': specController.text,
                    'photo': 'https://i.pravatar.cc/150?u=${nameController.text.length}'
                  });
                } else {
                  _staff[index] = {
                    'name': nameController.text,
                    'role': roleController.text,
                    'status': _staff[index]['status'],
                    'experience': expController.text,
                    'specialization': specController.text,
                    'photo': _staff[index]['photo']
                  };
                }
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF12B8A6)),
            child: const Text('Save'),
          ),
        ],
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
              Text('Lab Staff', style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                onPressed: () => _showStaffDialog(),
                icon: const Icon(Icons.person_add_alt_1_rounded),
                label: const Text('Add Technician'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF12B8A6),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(member['photo']),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(member['name'], style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
                                Text(member['role'], style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF12B8A6), fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit_outlined, size: 18, color: Color(0xFF9CA3AF)),
                                onPressed: () => _showStaffDialog(index: index),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline, size: 18, color: Colors.redAccent),
                                onPressed: () {
                                  setState(() => _staff.removeAt(index));
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
                          _staffDetail('Experience', member['experience']),
                          _staffDetail('Specialization', member['specialization']),
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
        Text(label, style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF9CA3AF))),
        Text(value, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold)),
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
                style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold),
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
          const Icon(Icons.settings_outlined, size: 80, color: Color(0xFF12B8A6)),
          const SizedBox(height: 48),
          _labSettingItem('Diagnostic Equipment Setup', Icons.biotech_outlined, () => setState(() => _currentView = 1)),
          _labSettingItem('Report Templates', Icons.description_outlined, () => setState(() => _currentView = 2)),
          _labSettingItem('Data Export Preferences', Icons.ios_share_rounded, () => setState(() => _currentView = 3)),
        ],
      ),
    );
  }

  Widget _buildEquipmentSetup() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
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
                            Text(item['name'], style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                            Text(item['status'], style: GoogleFonts.poppins(fontSize: 12, color: item['isActive'] ? Colors.green : Colors.red)),
                          ],
                        ),
                      ),
                      Switch(
                        value: item['isActive'],
                        onChanged: (v) {
                          setState(() {
                            _equipment[index]['isActive'] = v;
                            _equipment[index]['status'] = v ? 'Online' : 'Offline';
                          });
                        },
                        activeColor: const Color(0xFF12B8A6),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                        onPressed: () => setState(() => _equipment.removeAt(index)),
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
                  content: TextField(controller: controller, decoration: const InputDecoration(labelText: 'Equipment Name')),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _equipment.add({'name': controller.text, 'status': 'Online', 'isActive': true});
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF12B8A6)),
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExportSettings() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Format Preferences', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _radioOption('PDF (Standard Human Readable)'),
          _radioOption('JSON (Digital Integration)'),
          _radioOption('CSV (Bulk Data Processing)'),
          const SizedBox(height: 32),
          Text('Automation Frequency', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          _templateTile('Standard Blood Report', 'Last edited 2 days ago'),
          _templateTile('Full Body Checkup Summary', 'Last edited 1 week ago'),
          _templateTile('COVID-19 Result Certificate', 'Last edited 1 month ago'),
        ],
      ),
    );
  }

  Widget _templateTile(String title, String subtitle) {
    return ListTile(
      leading: const Icon(Icons.article_outlined, color: Color(0xFF12B8A6)),
      title: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: GoogleFonts.poppins(fontSize: 12)),
      trailing: const Icon(Icons.edit_outlined),
      onTap: () {},
    );
  }

  Widget _radioOption(String text) {
    return Row(
      children: [
        Radio(value: text, groupValue: 'PDF (Standard Human Readable)', onChanged: (v) {}),
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
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.01), blurRadius: 5)]),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF12B8A6), size: 20),
            const SizedBox(width: 16),
            Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
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
  final List<Map<String, String>> _patients = [
    {'name': 'Alice Brown', 'id': 'PT-8801', 'lastTest': 'Blood Glucose'},
    {'name': 'Liam Henderson', 'id': 'PT-8802', 'lastTest': 'Full Body Checkup'},
    {'name': 'Sophia Garcia', 'id': 'PT-8803', 'lastTest': 'Lipid Panel'},
    {'name': 'Noah Smith', 'id': 'PT-8804', 'lastTest': 'CBC Analysis'},
  ];

  String? _selectedPatientId;
  String? _selectedFileName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Upload Lab Reports', style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Select a patient and upload their completed test results.', style: GoogleFonts.poppins(color: const Color(0xFF6B7280))),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left: Patient Selection
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Select Patient', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 20),
                      ListView.separated(
                        shrinkWrap: true,
                        itemCount: _patients.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          final patient = _patients[index];
                          bool isSelected = _selectedPatientId == patient['id'];
                          return ListTile(
                            onTap: () => setState(() => _selectedPatientId = patient['id']),
                            leading: CircleAvatar(
                              backgroundColor: isSelected ? const Color(0xFF12B8A6) : const Color(0xFFF3F4F6),
                              child: Text(patient['name']![0], style: TextStyle(color: isSelected ? Colors.white : const Color(0xFF1F2937))),
                            ),
                            title: Text(patient['name'] ?? '', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                            subtitle: Text('ID: ${patient['id']} • Last: ${patient['lastTest']}', style: GoogleFonts.poppins(fontSize: 12)),
                            trailing: isSelected ? const Icon(Icons.check_circle, color: Color(0xFF12B8A6)) : null,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 32),
              // Right: Upload Area
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE5E7EB), style: BorderStyle.none), // Using none to avoid double border
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.cloud_upload_outlined, size: 64, color: Color(0xFF12B8A6)),
                              const SizedBox(height: 20),
                              Text(
                                _selectedFileName ?? 'Drag & drop report files here',
                                style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: const Color(0xFF4B5563)),
                              ),
                              Text('Supported formats: PDF, JPG, PNG', style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF9CA3AF))),
                              const SizedBox(height: 24),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() => _selectedFileName = 'test_results_final.pdf');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF12B8A6),
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                child: const Text('Browse Files'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _selectedPatientId == null || _selectedFileName == null
                              ? null
                              : () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Report uploaded successfully and notified to patient!')),
                                  );
                                  setState(() {
                                    _selectedPatientId = null;
                                    _selectedFileName = null;
                                  });
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF12B8A6),
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            disabledBackgroundColor: Colors.grey[200],
                          ),
                          child: Text(
                            'Finalize & Upload Report',
                            style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16),
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
