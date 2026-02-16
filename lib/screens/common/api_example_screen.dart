import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/patient_service.dart';
import '../../services/doctor_service.dart';
import '../../services/test_service.dart';
import '../../models/appointment_model.dart';
import '../../models/doctor_model.dart';

/// Complete API Integration Example Screen
/// This demonstrates how to use all the Labloom API services
class ApiExampleScreen extends StatefulWidget {
  const ApiExampleScreen({super.key});

  @override
  State<ApiExampleScreen> createState() => _ApiExampleScreenState();
}

class _ApiExampleScreenState extends State<ApiExampleScreen> {
  final PatientService _patientService = PatientService();
  final DoctorService _doctorService = DoctorService();
  final TestService _testService = TestService();

  Map<String, dynamic>? _dashboardData;
  List<dynamic> _appointments = [];
  List<DoctorModel> _doctors = [];
  List<dynamic> _tests = [];
  
  bool _isLoading = false;
  String _selectedTab = 'dashboard';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    
    try {
      // Load all data in parallel
      final results = await Future.wait([
        _patientService.getDashboard(),
        _patientService.getMyAppointments(),
        _doctorService.getAllDoctors(),
        _testService.getAllTests(),
      ]);

      setState(() {
        _dashboardData = results[0] as Map<String, dynamic>;
        _appointments = results[1] as List<dynamic>;
        final doctorResponse = results[2] as List<dynamic>;
        _doctors = doctorResponse.map((json) => DoctorModel.fromJson(json)).toList();
        _tests = results[3] as List<dynamic>;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      _showError('Failed to load data: ${e.toString()}');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message.replaceAll('Exception: ', '')),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> _bookAppointment(String doctorId) async {
    try {
      await _patientService.bookAppointment({
        'doctorId': doctorId,
        'date': DateTime.now().add(const Duration(days: 1)).toIso8601String(),
        'time': '10:00',
        'consultationType': 'online',
        'symptoms': 'Test appointment from API',
      });
      
      _showSuccess('Appointment booked successfully!');
      _loadData(); // Refresh data
    } catch (e) {
      _showError('Failed to book appointment: ${e.toString()}');
    }
  }

  Future<void> _bookTest(String testId) async {
    try {
      await _patientService.bookTest({
        'testId': testId,
        'date': DateTime.now().add(const Duration(days: 2)).toIso8601String(),
        'homeCollection': true,
        'address': 'Test address',
      });
      
      _showSuccess('Test booked successfully!');
      _loadData(); // Refresh data
    } catch (e) {
      _showError('Failed to book test: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF12B8A6),
        elevation: 0,
        title: Text(
          'API Integration Example',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadData,
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTab('Dashboard', 'dashboard'),
                  _buildTab('Appointments', 'appointments'),
                  _buildTab('Doctors', 'doctors'),
                  _buildTab('Tests', 'tests'),
                ],
              ),
            ),
          ),
          
          // Content
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF12B8A6),
                    ),
                  )
                : _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, String value) {
    final isSelected = _selectedTab == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected? const Color(0xFF12B8A6) : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? const Color(0xFF12B8A6) : const Color(0xFF6B7280),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (_selectedTab) {
      case 'dashboard':
        return _buildDashboard();
      case 'appointments':
        return _buildAppointments();
      case 'doctors':
        return _buildDoctors();
      case 'tests':
        return _buildTests();
      default:
        return const SizedBox();
    }
  }

  Widget _buildDashboard() {
    if (_dashboardData == null) {
      return const Center(child: Text('No dashboard data'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dashboard Overview',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),
          
          Row(
            children: [
              Expanded(
                child: _buildDashboardCard(
                  'Appointments',
                  '${_appointments.length}',
                  Icons.calendar_today,
                  const Color(0xFF12B8A6),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDashboardCard(
                  'Doctors',
                  '${_doctors.length}',
                  Icons.person,
                  const Color(0xFF3B82F6),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                child: _buildDashboardCard(
                  'Tests',
                  '${_tests.length}',
                  Icons.science,
                  const Color(0xFFF59E0B),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDashboardCard(
                  'Health Score',
                  '${_dashboardData?['healthScore'] ?? 'N/A'}',
                  Icons.favorite,
                  const Color(0xFFEF4444),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          _buildInfoCard(
            'API Status',
            'All services connected to:\nhttps://labloom-new.onrender.com/api',
            Icons.check_circle,
            Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String subtitle, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointments() {
    if (_appointments.isEmpty) {
      return Center(
        child: Text(
          'No appointments yet',
          style: GoogleFonts.poppins(fontSize: 16),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(24),
      itemCount: _appointments.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final appointment = _appointments[index];
        return _buildCard(
          title: 'Appointment #${index + 1}',
          subtitle: appointment['doctorId'] ?? 'Unknown doctor',
          trailing: Text(
            appointment['status'] ?? 'Unknown',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF12B8A6),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDoctors() {
    if (_doctors.isEmpty) {
      return Center(
        child: Text(
          'No doctors available',
          style: GoogleFonts.poppins(fontSize: 16),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(24),
      itemCount: _doctors.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final doctor = _doctors[index];
        return _buildCard(
          title: doctor.name,
          subtitle: '${doctor.specialty} • ${doctor.experience} years',
          trailing: ElevatedButton(
            onPressed: () => _bookAppointment(doctor.id),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF12B8A6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Book',
              style: GoogleFonts.poppins(fontSize: 12),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTests() {
    if (_tests.isEmpty) {
      return Center(
        child: Text(
          'No tests available',
          style: GoogleFonts.poppins(fontSize: 16),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(24),
      itemCount: _tests.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final test = _tests[index];
        return _buildCard(
          title: test['name'] ?? 'Unknown test',
          subtitle: 'Price: ₹${test['price'] ?? 'N/A'}',
          trailing: ElevatedButton(
            onPressed: () => _bookTest(test['_id'] ?? test['id']),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF12B8A6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Book',
              style: GoogleFonts.poppins(fontSize: 12),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCard({
    required String title,
    required String subtitle,
    Widget? trailing,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }
}
