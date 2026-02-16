import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/patient_service.dart';

class PatientProvider with ChangeNotifier {
  final PatientService _patientService = PatientService();

  UserModel? _user;
  DashboardData? _dashboardData;
  bool _isLoading = false;

  UserModel? get user => _user;
  DashboardData? get dashboardData => _dashboardData;
  bool get isLoading => _isLoading;

  Future<void> loadDashboardData() async {
    _isLoading = true;
    notifyListeners();
    try {
      final dashboardResponse = await _patientService.getDashboard();

      // Map dashboard data and handle potential null/structure differences
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

      final profileResponse = await _patientService.getProfile();
      _user = UserModel.fromJson(profileResponse);
    } catch (e) {
      debugPrint("Error loading dashboard: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
