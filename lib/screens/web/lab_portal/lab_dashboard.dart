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
  final Color _darkBg = const Color(0xFF111827); // Very dark for a modern lab feel
  final Color _lightBg = const Color(0xFFF9FAFB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _lightBg,
      body: Row(
        children: [
          _buildLabSidebar(),
          Expanded(
            child: Column(
              children: [
                _buildLabHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildWelcomeSection(),
                        const SizedBox(height: 40),
                        _buildLabStats(),
                        const SizedBox(height: 40),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 3, child: _buildRecentTestsTable()),
                            const SizedBox(width: 30),
                            Expanded(flex: 1, child: _buildLabCapacity()),
                          ],
                        ),
                      ],
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

  Widget _buildLabSidebar() {
    return Container(
      width: 280,
      color: _darkBg,
      child: Column(
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                const Icon(Icons.biotech_rounded, color: Color(0xFF12B8A6), size: 32),
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
          _labSidebarItem(Icons.analytics_outlined, 'Lab Analytics', 0),
          _labSidebarItem(Icons.science_outlined, 'Manage Tests', 1),
          _labSidebarItem(Icons.assignment_turned_in_outlined, 'Results Approval', 2),
          _labSidebarItem(Icons.inventory_2_outlined, 'Equipment & Supplies', 3),
          _labSidebarItem(Icons.people_outline_rounded, 'Technicians', 4),
          const Spacer(),
          _labSidebarItem(Icons.settings_outlined, 'Portal Settings', 5),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _labSidebarItem(IconData icon, String title, int index) {
    bool isSelected = _selectedIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: InkWell(
        onTap: () => setState(() => _selectedIndex = index),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? _primaryColor.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: isSelected ? Border.all(color: _primaryColor.withOpacity(0.3)) : null,
          ),
          child: Row(
            children: [
              Icon(icon, color: isSelected ? _primaryColor : Colors.white60, size: 22),
              const SizedBox(width: 16),
              Text(
                title,
                style: GoogleFonts.poppins(
                  color: isSelected ? Colors.white : Colors.white60,
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabHeader() {
    return Container(
      height: 80,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        children: [
          Text(
            'Terminal ID: LK-901-B',
            style: GoogleFonts.poppins(fontSize: 14, color: const Color(0xFF6B7280), fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          _statusIndicator('Lab Status: ACTIVE', Colors.green),
          const SizedBox(width: 30),
          const CircleAvatar(
            backgroundColor: Color(0xFFF3F4F6),
            child: Icon(Icons.science, color: Color(0xFF1F2937)),
          ),
        ],
      ),
    );
  }

  Widget _statusIndicator(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 10),
          Text(
            text,
            style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Laboratory Management',
          style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.bold, color: _darkBg),
        ),
        Text(
          'Automated tracking and result management system.',
          style: GoogleFonts.poppins(fontSize: 16, color: const Color(0xFF6B7280)),
        ),
      ],
    );
  }

  Widget _buildLabStats() {
    return Row(
      children: [
        Expanded(child: _labStatCard('Tests Processed', '14,204', Icons.copy_rounded, Colors.blue)),
        const SizedBox(width: 24),
        Expanded(child: _labStatCard('Pending Samples', '42', Icons.hourglass_top_rounded, Colors.orange)),
        const SizedBox(width: 24),
        Expanded(child: _labStatCard('Ready for Approval', '18', Icons.check_circle_rounded, Colors.green)),
        const SizedBox(width: 24),
        Expanded(child: _labStatCard('System Uptime', '99.9%', Icons.cloud_done_rounded, _primaryColor)),
      ],
    );
  }

  Widget _labStatCard(String title, String val, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 20),
          Text(val, style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: _darkBg)),
          Text(title, style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF9CA3AF), fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildRecentTestsTable() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Sample Processing Queue', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(color: _primaryColor, borderRadius: BorderRadius.circular(10)),
                child: Text('Register Batch', style: GoogleFonts.poppins(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 32),
          _tableHeaderRow(),
          const Divider(),
          _testDataRow('SAM-9011', 'Liam Henderson', 'Blood Glucose', 'Processing', 0.65),
          _testDataRow('SAM-9012', 'Sophia Garcia', 'Lipid Panel', 'In Queue', 0.1),
          _testDataRow('SAM-9013', 'Noah Smith', 'CBC Analysis', 'Scanning', 0.9),
          _testDataRow('SAM-9014', 'Olivia Brown', 'Thyroid T3/T4', 'Processing', 0.4),
        ],
      ),
    );
  }

  Widget _tableHeaderRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text('SAMPLE ID', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF9CA3AF)))),
          Expanded(flex: 2, child: Text('PATIENT', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF9CA3AF)))),
          Expanded(flex: 2, child: Text('TEST TYPE', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF9CA3AF)))),
          Expanded(flex: 2, child: Text('PROGRESS', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF9CA3AF)))),
        ],
      ),
    );
  }

  Widget _testDataRow(String id, String patient, String test, String status, double progress) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text(id, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text(patient, style: GoogleFonts.poppins(fontSize: 14))),
          Expanded(flex: 2, child: Text(test, style: GoogleFonts.poppins(fontSize: 14, color: _primaryColor, fontWeight: FontWeight.w600))),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(status, style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF6B7280))),
                    Text('${(progress * 100).toInt()}%', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: const Color(0xFFF3F4F6),
                    valueColor: AlwaysStoppedAnimation<Color>(_primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabCapacity() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: _darkBg,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Lab Capacity', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 10),
          Text('78% of analyzers active', style: GoogleFonts.poppins(fontSize: 13, color: Colors.white60)),
          const SizedBox(height: 40),
          _analyzerStat('Chemical Analyzer-1', 0.85),
          const SizedBox(height: 24),
          _analyzerStat('Hematology Auto', 0.40),
          const SizedBox(height: 24),
          _analyzerStat('Immunoassay Sys', 0.95),
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: [
                const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 24),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Reagent levels low for Glucose Panel.',
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

  Widget _analyzerStat(String name, double val) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12)),
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
}
