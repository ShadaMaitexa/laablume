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

class LabInventoryScreen extends StatefulWidget {
  const LabInventoryScreen({super.key});

  @override
  State<LabInventoryScreen> createState() => _LabInventoryScreenState();
}

class _LabInventoryScreenState extends State<LabInventoryScreen> {
  final List<Map<String, dynamic>> _inventoryItems = [
    {'name': 'Test Tubes', 'count': 85, 'isLow': false},
    {'name': 'Contact Lenses', 'count': 42, 'isLow': false},
    {'name': 'Chemical Reagent A', 'count': 12, 'isLow': true},
    {'name': 'Gloves (L)', 'count': 95, 'isLow': false},
    {'name': 'Gloves (M)', 'count': 110, 'isLow': false},
    {'name': 'Syringes', 'count': 15, 'isLow': true},
  ];

  void _addItem(String name, int count) {
    setState(() {
      _inventoryItems.add({'name': name, 'count': count, 'isLow': count < 20});
    });
  }

  void _editItem(int index, String name, int count) {
    setState(() {
      _inventoryItems[index] = {'name': name, 'count': count, 'isLow': count < 20};
    });
  }

  void _removeItem(int index) {
    setState(() {
      _inventoryItems.removeAt(index);
    });
  }

  void _showItemDialog({int? index}) {
    final nameController = TextEditingController(text: index != null ? _inventoryItems[index]['name'] : '');
    final countController = TextEditingController(text: index != null ? _inventoryItems[index]['count'].toString() : '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(index == null ? 'Add New Item' : 'Edit Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Item Name')),
            const SizedBox(height: 16),
            TextField(controller: countController, decoration: const InputDecoration(labelText: 'Stock Count'), keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (index == null) {
                _addItem(nameController.text, int.tryParse(countController.text) ?? 0);
              } else {
                _editItem(index, nameController.text, int.tryParse(countController.text) ?? 0);
              }
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
              Text(
                'Inventory & Supplies',
                style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937)),
              ),
              ElevatedButton.icon(
                onPressed: () => _showItemDialog(),
                icon: const Icon(Icons.add),
                label: const Text('Add Supply'),
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
                crossAxisCount: 4,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: 1.2,
              ),
              itemCount: _inventoryItems.length,
              itemBuilder: (context, index) => _inventoryCard(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inventoryCard(int index) {
    final item = _inventoryItems[index];
    bool isLow = item['isLow'];
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isLow ? Border.all(color: Colors.red.withOpacity(0.3)) : null,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(item['name'], style: GoogleFonts.poppins(fontWeight: FontWeight.bold))),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, size: 18, color: Color(0xFF9CA3AF)),
                    onPressed: () => _showItemDialog(index: index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 18, color: Colors.redAccent),
                    onPressed: () => _removeItem(index),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('In Stock: ${item['count']} units', style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF6B7280))),
          const Spacer(),
          LinearProgressIndicator(
            value: (item['count'] as int) / 100,
            backgroundColor: const Color(0xFFF3F4F6),
            valueColor: AlwaysStoppedAnimation<Color>(isLow ? Colors.red : const Color(0xFF12B8A6)),
          ),
          if (isLow) ...[
            const SizedBox(height: 8),
            Text('Low Stock!', style: GoogleFonts.poppins(fontSize: 11, color: Colors.red, fontWeight: FontWeight.bold)),
          ],
        ],
      ),
    );
  }
}

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
    {'name': 'Robert Fox', 'role': 'Senior Pathologist', 'status': 'Active'},
    {'name': 'Jane Cooper', 'role': 'Lab Technician', 'status': 'On Break'},
    {'name': 'Guy Hawkins', 'role': 'Assistant Technician', 'status': 'Active'},
    {'name': 'Eleanor Pena', 'role': 'Bio-analyst', 'status': 'Active'},
  ];

  void _showStaffDialog({int? index}) {
    final nameController = TextEditingController(text: index != null ? _staff[index]['name'] : '');
    final roleController = TextEditingController(text: index != null ? _staff[index]['role'] : '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(index == null ? 'Add Staff Member' : 'Edit Staff'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Full Name')),
            const SizedBox(height: 16),
            TextField(controller: roleController, decoration: const InputDecoration(labelText: 'Role/Position')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (index == null) {
                  _staff.add({'name': nameController.text, 'role': roleController.text, 'status': 'Active'});
                } else {
                  _staff[index] = {'name': nameController.text, 'role': roleController.text, 'status': _staff[index]['status']};
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
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(backgroundColor: Color(0xFF12B8A6), child: Icon(Icons.person, color: Colors.white)),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(member['name'], style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                            Text(member['role'], style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF6B7280))),
                          ],
                        ),
                      ),
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
                );
              },
            ),
          ),
        ],
      ),
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
