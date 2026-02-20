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
  bool _isLoading = false;

  UserModel? get user => _user;
  DashboardData? get dashboardData => _dashboardData;
  List<AppointmentModel> get appointments => _appointments;
  List<HealthMetric> get healthMetrics => _healthMetrics;
  List<Report> get reports => _reports;
  List<Prescription> get prescriptions => _prescriptions;
  bool get isLoading => _isLoading;

  Future<void> loadDashboardData() async {
    _isLoading = true;
    notifyListeners();
    try {
      final dashboardResponse = await _patientService.getDashboard();

      _dashboardData = DashboardData(
        upcomingAppointments:
            dashboardResponse['upcomingAppointments'] ??
            dashboardResponse['upcoming_appointments'] ??
            0,
        pendingReports:
            dashboardResponse['pendingReports'] ??
            dashboardResponse['pending_reports'] ??
            0,
        healthScore:
            dashboardResponse['healthScore'] ??
            dashboardResponse['health_score'] ??
            0,
      );

      await loadProfile();
    } catch (e) {
      debugPrint("Error loading dashboard: $e");
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
    } catch (e) {
      debugPrint("Error loading appointments: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
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
    } catch (e) {
      debugPrint("Error loading reports: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadPrescriptions() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _patientService.getPrescriptions();
      _prescriptions = response
          .map((json) => Prescription.fromJson(json))
          .toList();
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

  Future<bool> uploadProfileImage(Map<String, dynamic> imageData) async {
    try {
      await _patientService.uploadProfileImage(imageData);
      await loadProfile();
      return true;
    } catch (e) {
      debugPrint("Error uploading profile image: $e");
      return false;
    }
  }
}
