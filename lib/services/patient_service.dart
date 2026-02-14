import 'api_base_service.dart';
import '../models/user_model.dart';

class PatientService extends ApiBaseService {
  static final PatientService _instance = PatientService._internal();
  factory PatientService() => _instance;
  PatientService._internal();

  Future<DashboardData> getDashboardData() async {
    final response = await get('/patients/dashboard');
    return DashboardData.fromJson(response);
  }

  Future<UserModel> getProfile() async {
    final response = await get('/patients/me');
    return UserModel.fromJson(response);
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    await patch('/patients/me', data);
  }

  Future<List<dynamic>> getAppointments() async {
    final response = await get('/patients/appointments');
    return response is List ? response : [];
  }

  Future<List<dynamic>> getReports() async {
    final response = await get('/patients/reports');
    return response is List ? response : [];
  }

  Future<Map<String, dynamic>> getHealthMetrics() async {
    final response = await get('/patients/health-metrics');
    return response is Map<String, dynamic> ? response : {};
  }
}
