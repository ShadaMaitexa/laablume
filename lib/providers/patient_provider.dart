import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/appointment_model.dart';
import '../models/health_metric_model.dart';
import '../models/report_model.dart';
import '../models/prescription_model.dart';
import '../services/patient_service.dart';

class PatientProvider with ChangeNotifier {
  final PatientService _patientService = PatientService();

  UserModel? _user;
  DashboardData? _dashboardData;
  List<AppointmentModel> _appointments = [];
  List<HealthMetric> _healthMetrics = [];
  List<Report> _reports = [];
  List<Prescription> _prescriptions = [];
  Map<String, dynamic> _onboardingData = {};
  bool _isLoading = false;

  UserModel? get user => _user;
  DashboardData? get dashboardData => _dashboardData;
  List<AppointmentModel> get appointments => _appointments;
  List<HealthMetric> get healthMetrics => _healthMetrics;
  List<Report> get reports => _reports;
  List<Prescription> get prescriptions => _prescriptions;
  Map<String, dynamic> get onboardingData => _onboardingData;
  bool get isLoading => _isLoading;

  void updateOnboardingData(Map<String, dynamic> data) {
    // Deep merge or specific nesting based on Step requirements
    if (data.containsKey('personalData')) {
      _onboardingData['personalData'] =
          (_onboardingData['personalData'] as Map<String, dynamic>? ?? {})
            ..addAll(data['personalData']);
    } else if (data.containsKey('emergencyContact')) {
      _onboardingData['emergencyContact'] = data['emergencyContact'];
    } else if (data.containsKey('healthProfile')) {
      _onboardingData['healthProfile'] = data['healthProfile'];
    } else if (data.containsKey('lifestyle')) {
      _onboardingData['lifestyle'] = data['lifestyle'];
    } else if (data.containsKey('insurance')) {
      _onboardingData['insurance'] = data['insurance'];
    } else {
      _onboardingData.addAll(data);
    }
    notifyListeners();
  }

  void clearOnboardingData() {
    _onboardingData = {};
    notifyListeners();
  }

  Future<void> loadDashboardData() async {
    _isLoading = true;
    notifyListeners();
    try {
      final dashboardResponse = await _patientService.getDashboard();
      _dashboardData = DashboardData.fromJson(dashboardResponse);
      await loadProfile();
    } catch (e) {
      debugPrint("Error loading dashboard, using fallback: $e");
      // Fallback for presentation
      _dashboardData = DashboardData(
        upcomingAppointments: 2,
        pendingReports: 1,
        healthScore: 85,
        summary:
            "Your health is excellent! Your BMI is in the normal range, and your recent lab results show optimal vitamin D levels. Keep staying active!",
      );
      if (_user == null) {
        _user = UserModel(
          id: 'mock_1',
          name: 'John Doe',
          email: 'john@example.com',
          mobileNumber: '+1234567890',
          role: 'patient',
          isOnboarded: true,
        );
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadProfile() async {
    try {
      final response = await _patientService.getProfile();
      _user = UserModel.fromJson(response);
      notifyListeners();
    } catch (e) {
      debugPrint("Error loading profile: $e");
    }
  }

  Future<bool> updateProfile(Map<String, dynamic> profileData) async {
    try {
      await _patientService.updateProfile(profileData);
      await loadProfile();
      return true;
    } catch (e) {
      debugPrint("Error updating profile: $e");
      return false;
    }
  }

  Future<void> loadAppointments() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _patientService.getMyAppointments();
      _appointments = response
          .map((json) => AppointmentModel.fromJson(json))
          .toList();

      if (_appointments.isEmpty) {
        _appointments = _getMockAppointments();
      }
    } catch (e) {
      debugPrint("Error loading appointments, using fallback: $e");
      _appointments = _getMockAppointments();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<AppointmentModel> _getMockAppointments() {
    return [
      AppointmentModel(
        id: 'mock_app_1',
        userID: 'user_1',
        doctorID: 'doc_1',
        doctorName: 'Dr. Sarah Wilson',
        doctorSpecialty: 'Cardiologist',
        appointmentDateTime: DateTime.now().add(const Duration(days: 2)),
        reasonForVisit: 'Routine heart checkup and blood pressure monitoring.',
        status: 'Confirmed',
      ),
      AppointmentModel(
        id: 'mock_app_2',
        userID: 'user_1',
        doctorID: 'doc_2',
        doctorName: 'Dr. Michael Chen',
        doctorSpecialty: 'General Physician',
        appointmentDateTime: DateTime.now().subtract(const Duration(days: 5)),
        reasonForVisit: 'Annual physical examination and blood tests.',
        status: 'Completed',
        labReport: Report(
          id: 'mock_rep_1',
          title: 'Complete Blood Count',
          category: 'Blood Test',
          date: DateTime.now().subtract(const Duration(days: 5)),
          status: 'Verified',
          type: 'lab_test',
          aiAnalysis: {
            'summary': 'All parameters are within normal limits.',
            'findings': [
              'Hemoglobin: 14.5 g/dL (Normal)',
              'WBC: 7.2 x10³/µL (Normal)',
            ],
            'recommendations': ['Continue balanced diet', 'Stay hydrated'],
            'note': 'AI analysis for demonstration purposes.',
          },
        ),
      ),
    ];
  }

  Future<bool> bookAppointment(Map<String, dynamic> data) async {
    try {
      await _patientService.bookAppointment(data);
      loadAppointments();
      return true;
    } catch (e) {
      debugPrint("Error booking appointment: $e");
      return false;
    }
  }

  Future<void> loadHealthMetrics({String? type}) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _patientService.getHealthMetrics(type: type);
      _healthMetrics = response
          .map((json) => HealthMetric.fromJson(json))
          .toList();
    } catch (e) {
      debugPrint("Error loading health metrics: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addHealthMetric(Map<String, dynamic> data) async {
    try {
      await _patientService.addHealthMetric(data);
      loadHealthMetrics();
      return true;
    } catch (e) {
      debugPrint("Error adding health metric: $e");
      return false;
    }
  }

  Future<void> loadReports() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _patientService.getReports();
      _reports = response.map((json) => Report.fromJson(json)).toList();

      if (_reports.isEmpty) {
        _reports = _getMockReports();
      }
    } catch (e) {
      debugPrint("Error loading reports, using fallback: $e");
      _reports = _getMockReports();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<Report> _getMockReports() {
    return [
      Report(
        id: 'mock_rep_1',
        title: 'Complete Blood Count',
        category: 'Blood Test',
        date: DateTime.now().subtract(const Duration(days: 5)),
        status: 'Verified',
        type: 'lab_test',
        aiAnalysis: {
          'summary': 'Your blood count is optimal.',
          'findings': [
            'Hemoglobin is stable at 14.2 g/dL',
            'Platelet count is healthy at 250k',
            'White blood cell count is within range',
          ],
          'recommendations': [
            'Maintain current iron intake',
            'Consider Vitamin C for better iron absorption',
            'Regular exercise is recommended',
          ],
          'note': 'This is a mock AI analysis for presentation.',
        },
      ),
      Report(
        id: 'mock_rep_2',
        title: 'Lipid Profile',
        category: 'Cardiology',
        date: DateTime.now().subtract(const Duration(days: 12)),
        status: 'Verified',
        type: 'lab_test',
        aiAnalysis: {
          'summary': 'Your cholesterol levels are excellent.',
          'findings': [
            'LDL is low at 85 mg/dL',
            'HDL is high at 65 mg/dL (GOOD)',
            'Total cholesterol is 160 mg/dL',
          ],
          'recommendations': [
            'Keep up the low-saturated fat diet',
            'Great work with the avocado and nut consumption',
            'Continue daily walking',
          ],
          'note': 'Stay heart-healthy!',
        },
      ),
    ];
  }

  Future<void> loadPrescriptions() async {
    _isLoading = true;
    notifyListeners();
    try {
      final List<dynamic> response = await _patientService.getPrescriptions();

      // Backend returns flattened list of medications. Group them by bookingId.
      final Map<String, List<Medication>> groupedMeds = {};
      final Map<String, Map<String, dynamic>> bookingData = {};

      for (var json in response) {
        final bookingId = json['bookingId'] ?? 'unknown';
        if (!groupedMeds.containsKey(bookingId)) {
          groupedMeds[bookingId] = [];
          bookingData[bookingId] = json; // Sample data for doctorName/date
        }
        groupedMeds[bookingId]!.add(Medication.fromJson(json));
      }

      _prescriptions = groupedMeds.entries.map((entry) {
        final data = bookingData[entry.key]!;
        return Prescription(
          id: entry.key,
          patientId: '', // Not provided in flattened list
          doctorId: '', // Not provided in flattened list
          date: DateTime.parse(
            data['date'] ?? DateTime.now().toIso8601String(),
          ),
          medications: entry.value,
          diagnosis: data['description'] ?? data['specialization'],
          notes: data['specialInstructions'],
        );
      }).toList();

      _prescriptions.sort((a, b) => b.date.compareTo(a.date));
    } catch (e) {
      debugPrint("Error loading prescriptions: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> submitFeedback(Map<String, dynamic> data) async {
    try {
      await _patientService.submitFeedback(data);
      return true;
    } catch (e) {
      debugPrint("Error submitting feedback: $e");
      return false;
    }
  }

  Future<bool> uploadProfileImage(
    String? filePath, {
    Uint8List? bytes,
    String? filename,
  }) async {
    try {
      await _patientService.uploadProfileImage(
        filePath,
        bytes: bytes,
        filename: filename,
      );
      await loadProfile();
      return true;
    } catch (e) {
      debugPrint("Error uploading profile image: $e");
      return false;
    }
  }

  Future<bool> completeOnboarding(Map<String, dynamic> onboardingData) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _patientService.completeOnboarding(onboardingData);
      await loadProfile(); // Refresh user state to reflect completion
      return true;
    } catch (e) {
      debugPrint("Error completing onboarding: $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // discovery methods
  Future<List<dynamic>> searchDoctors({
    String? specialty,
    String? search,
    String? city,
  }) async {
    try {
      return await _patientService.searchDoctors(
        specialty: specialty,
        search: search,
        city: city,
      );
    } catch (e) {
      debugPrint("Error searching doctors: $e");
      return [];
    }
  }

  Future<List<dynamic>> getDoctorSlots(String doctorId) async {
    try {
      return await _patientService.getDoctorSlots(doctorId);
    } catch (e) {
      debugPrint("Error getting doctor slots: $e");
      return [];
    }
  }

  Future<List<dynamic>> searchLabs({String? city}) async {
    try {
      return await _patientService.searchLabs(city: city);
    } catch (e) {
      debugPrint("Error searching labs: $e");
      return [];
    }
  }

  Future<List<dynamic>> searchHospitals({String? city, String? search}) async {
    try {
      return await _patientService.searchHospitals(city: city, search: search);
    } catch (e) {
      debugPrint("Error searching hospitals: $e");
      return [];
    }
  }

  Future<Map<String, dynamic>> getHospitalDetails(String hospitalId) async {
    try {
      return await _patientService.getHospitalDetails(hospitalId);
    } catch (e) {
      debugPrint("Error getting hospital details: $e");
      return {};
    }
  }

  Future<List<dynamic>> getLabTests(String labId) async {
    try {
      return await _patientService.getLabTestsByLab(labId);
    } catch (e) {
      debugPrint("Error getting lab tests: $e");
      return [];
    }
  }

  Future<bool> bookTest(Map<String, dynamic> testData) async {
    try {
      await _patientService.bookTest(testData);
      return true;
    } catch (e) {
      debugPrint("Error booking test: $e");
      return false;
    }
  }

  Future<bool> uploadReport(
    String bookingId,
    String? filePath, {
    Uint8List? bytes,
    String? filename,
  }) async {
    try {
      await _patientService.uploadPatientReport(
        bookingId: bookingId,
        filePath: filePath,
        bytes: bytes,
        filename: filename,
      );
      await loadReports();
      return true;
    } catch (e) {
      debugPrint("Error uploading report: $e");
      return false;
    }
  }
}
