import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorAppointmentsScreen extends StatefulWidget {
  const DoctorAppointmentsScreen({super.key});

  @override
  State<DoctorAppointmentsScreen> createState() => _DoctorAppointmentsScreenState();
}

class _DoctorAppointmentsScreenState extends State<DoctorAppointmentsScreen> {
  int _activeTab = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Patient Appointments',
            style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937)),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 20)],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      _tabItem('Upcoming', 0),
                      _tabItem('Completed', 1),
                      _tabItem('Cancelled', 2),
                    ],
                  ),
                  const Divider(height: 40),
                  Expanded(
                    child: ListView.separated(
                      itemCount: _activeTab == 2 ? 2 : 8,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) => _appointmentRow(index),
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

  Widget _tabItem(String text, int index) {
    bool active = _activeTab == index;
    return GestureDetector(
      onTap: () => setState(() => _activeTab = index),
      child: Container(
        margin: const EdgeInsets.only(right: 24),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: active ? const Border(bottom: BorderSide(color: Color(0xFF12B8A6), width: 2)) : null,
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: active ? FontWeight.bold : FontWeight.w500,
            color: active ? const Color(0xFF12B8A6) : const Color(0xFF6B7280),
          ),
        ),
      ),
    );
  }

  Widget _appointmentRow(int index) {
    String status = _activeTab == 0 ? 'Confirmed' : (_activeTab == 1 ? 'Completed' : 'Cancelled');
    Color statusColor = _activeTab == 0 ? Colors.green : (_activeTab == 1 ? Colors.blue : Colors.red);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFF12B8A6).withOpacity(0.1),
            child: Text('${index + 1}', style: const TextStyle(color: Color(0xFF12B8A6))),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Patient Name ${index + 1}', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold)),
                Text('ID: #PT-880$index', style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF9CA3AF))),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Video Consultation', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
                Text('Cardiology', style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF9CA3AF))),
              ],
            ),
          ),
          Expanded(
            child: Text('10:30 AM', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: statusColor),
            ),
          ),
          const SizedBox(width: 20),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'view', child: Text('View Details')),
              const PopupMenuItem(value: 'reschedule', child: Text('Reschedule')),
              const PopupMenuItem(value: 'cancel', child: Text('Cancel Appointment', style: TextStyle(color: Colors.red))),
            ],
            onSelected: (value) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Action "$value" selected for Patient ${index + 1}')),
              );
            },
          ),
        ],
      ),
    );
  }
}

class DoctorPatientsScreen extends StatelessWidget {
  const DoctorPatientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Patients',
            style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937)),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: 2.5,
              ),
              itemCount: 12,
              itemBuilder: (context, index) => _patientGridCard(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _patientGridCard(int index) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Patient Jane Doe', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold)),
                Text('Last visit: 2 days ago', style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF9CA3AF))),
              ],
            ),
          ),
          IconButton(icon: const Icon(Icons.chevron_right, color: Color(0xFF12B8A6)), onPressed: () {}),
        ],
      ),
    );
  }
}

class DoctorReportsScreen extends StatelessWidget {
  const DoctorReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reports & AI Analysis',
            style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937)),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _summaryCard('Critical Reports', '12', Colors.red),
              const SizedBox(width: 24),
              _summaryCard('Needs Review', '24', Colors.orange),
              const SizedBox(width: 24),
              _summaryCard('Recently AI-Analyzed', '156', const Color(0xFF12B8A6)),
            ],
          ),
          const SizedBox(height: 32),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: ListView.separated(
                itemCount: 10,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) => _reportListItem(index, context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryCard(String title, String count, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.poppins(fontSize: 12, color: color, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(count, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _reportListItem(int index, BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.description_rounded, color: Color(0xFF12B8A6)),
      title: Text('Lab Report - Patient ${index + 1}', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      subtitle: Text('Analyzed by AI on 01 Jan 2026', style: GoogleFonts.poppins(fontSize: 12)),
      trailing: ElevatedButton(
        onPressed: () {
          _showAISummary(context, index);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF12B8A6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text('View AI Summary'),
      ),
    );
  }

  void _showAISummary(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          padding: const EdgeInsets.all(32),
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.auto_awesome, color: Color(0xFF12B8A6)),
                  const SizedBox(width: 12),
                  Text('AI Analysis: Report #LB-880$index', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 24),
              _aiPoint('Glucose levels are slightly elevated (145 mg/dL).'),
              _aiPoint('Low risk of cardiovascular complications based on age/history.'),
              _aiPoint('Recommendation: Follow-up HbA1c test in 3 months.'),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF12B8A6),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Understood'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _aiPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 16),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF4B5563)))),
        ],
      ),
    );
  }
}

class DoctorConsultationsScreen extends StatelessWidget {
  const DoctorConsultationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Live Consultations', style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.video_camera_front, size: 80, color: Color(0xFF12B8A6)),
                          const SizedBox(height: 20),
                          Text('No Active Call', style: GoogleFonts.poppins(fontSize: 18, color: const Color(0xFF6B7280))),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Upcoming Queue', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        _queueItem('Mark Wilson', '11:15 AM'),
                        _queueItem('Saira Banu', '11:45 AM'),
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

  Widget _queueItem(String name, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500)),
          Text(time, style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF12B8A6))),
        ],
      ),
    );
  }
}

class DoctorSettingsScreen extends StatefulWidget {
  const DoctorSettingsScreen({super.key});

  @override
  State<DoctorSettingsScreen> createState() => _DoctorSettingsScreenState();
}

class _DoctorSettingsScreenState extends State<DoctorSettingsScreen> {
  int _currentView = 0; // 0 for list, 1 for profile info, 2 for security, 3 for credentials, 4 for fees, 5 for availability, 6 for notifications

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
                  ? 'Account Settings' 
                  : _currentView == 1 
                    ? 'Profile Information'
                    : _currentView == 2
                      ? 'Security & Password'
                      : _currentView == 3
                        ? 'Professional Credentials'
                        : _currentView == 4
                          ? 'Consultation Fees'
                          : _currentView == 5
                            ? 'Availability & Hours'
                            : 'Notifications',
                style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: _buildMainContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    switch (_currentView) {
      case 1:
        return _buildProfileEditor();
      case 2:
        return _buildSecuritySettings();
      case 3:
        return _buildCredentialsSettings();
      case 4:
        return _buildFeesSettings();
      case 5:
        return _buildAvailabilitySettings();
      case 6:
        return _buildNotificationSettings();
      default:
        return _buildSettingsList();
    }
  }

  Widget _buildSettingsList() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            _settingRow('Profile Information', Icons.person_outline, () => setState(() => _currentView = 1)),
            _settingRow('Professional Credentials', Icons.badge_outlined, () => setState(() => _currentView = 3)),
            _settingRow('Consultation Fees', Icons.payments_outlined, () => setState(() => _currentView = 4)),
            _settingRow('Availability & Hours', Icons.schedule_outlined, () => setState(() => _currentView = 5)),
            _settingRow('Security & Password', Icons.security_outlined, () => setState(() => _currentView = 2)),
            _settingRow('Notification Preferences', Icons.notifications_none, () => setState(() => _currentView = 6)),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationSettings() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          _notificationToggle('Appointment Reminders', 'Get notified about upcoming visits', true),
          _notificationToggle('New Patient Message', 'Direct messages from patients', true),
          _notificationToggle('Report Ready Alert', 'AI Analysis completion alerts', false),
          _notificationToggle('Portal Security', 'Login alerts from new devices', true),
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
              child: const Text('Save Preferences'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _notificationToggle(String title, String sub, bool val) {
    return SwitchListTile(
      title: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14)),
      subtitle: Text(sub, style: GoogleFonts.poppins(fontSize: 12)),
      value: val,
      onChanged: (v) {},
      activeColor: const Color(0xFF12B8A6),
    );
  }

  Widget _buildCredentialsSettings() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildField('Medical License ID', 'MED-12345678'),
            const SizedBox(height: 20),
            _buildField('Board Certifications', 'American Board of Internal Medicine'),
            const SizedBox(height: 20),
            _buildField('Medical School', 'Harvard Medical School'),
            const SizedBox(height: 20),
            _buildField('Residency', 'Mayo Clinic, Cardiology'),
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
                child: const Text('Save Credentials'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeesSettings() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildField('Online Consultation Fee (₹)', '1500'),
          const SizedBox(height: 20),
          _buildField('In-Clinic Consultation Fee (₹)', '1000'),
          const SizedBox(height: 20),
          _buildField('Follow-up Fee (₹)', '500'),
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
              child: const Text('Update Fees'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailabilitySettings() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Working Days', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'].map((day) {
                bool active = day != 'Sun';
                return FilterChip(
                  label: Text(day),
                  selected: active,
                  onSelected: (val) {},
                  selectedColor: const Color(0xFF12B8A6).withOpacity(0.2),
                  checkmarkColor: const Color(0xFF12B8A6),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),
            Text('Working Hours', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildField('Start Time', '09:00 AM')),
                const SizedBox(width: 20),
                Expanded(child: _buildField('End Time', '05:00 PM')),
              ],
            ),
            const SizedBox(height: 20),
            _buildField('Break Time', '01:00 PM - 02:00 PM'),
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
                child: const Text('Save Availability'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecuritySettings() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildField('Current Password', '••••••••'),
          const SizedBox(height: 20),
          _buildField('New Password', ''),
          const SizedBox(height: 20),
          _buildField('Confirm New Password', ''),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Password updated successfully!')),
                );
                setState(() => _currentView = 0);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF12B8A6),
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Update Password'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileEditor() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: const Color(0xFFF9FAFB),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Image.asset('assets/logo.png'),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(color: Color(0xFF12B8A6), shape: BoxShape.circle),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildField('Full Name', 'Dr. Sarah Wilson'),
            const SizedBox(height: 20),
            _buildField('Specialization', 'Senior Cardiologist'),
            const SizedBox(height: 20),
            _buildField('Email Address', 'sarah.wilson@lablume.com'),
            const SizedBox(height: 20),
            _buildField('Phone Number', '+1 (555) 0123 456'),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile updated successfully!')),
                  );
                  setState(() => _currentView = 0);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF12B8A6),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, String initialValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF6B7280))),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: initialValue),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }

  void _showComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$feature settings coming soon in the next update.')),
    );
  }

  Widget _settingRow(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(border: Border.all(color: const Color(0xFFF3F4F6)), borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF6B7280), size: 20),
            const SizedBox(width: 16),
            Text(title, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
            const Spacer(),
            const Icon(Icons.chevron_right, color: Color(0xFFE5E7EB)),
          ],
        ),
      ),
    );
  }
}

class DoctorHelpScreen extends StatelessWidget {
  const DoctorHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Help & Support', style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(color: const Color(0xFF12B8A6).withOpacity(0.05), borderRadius: BorderRadius.circular(16)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.headset_mic_outlined, size: 64, color: Color(0xFF12B8A6)),
                  const SizedBox(height: 24),
                  Text('Need help with the platform?', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Text('Our support team is available 24/7 for technical assistance.', style: GoogleFonts.poppins(color: const Color(0xFF6B7280))),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF12B8A6), padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20)),
                    child: const Text('Contact Support'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
