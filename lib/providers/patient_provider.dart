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
      _dashboardData = await _patientService.getDashboardData();
      _user = await _patientService.getProfile();
    } catch (e) {
      debugPrint("Error loading dashboard: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
