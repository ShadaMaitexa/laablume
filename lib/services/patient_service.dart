import 'package:laablume/models/user_model.dart';
import 'package:laablume/models/health_metric_model.dart';
import 'package:laablume/services/api_base_service.dart';

class PatientService extends ApiBaseService {
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

  Future<List<HealthMetric>> getHealthMetrics({String? type}) async {
    final endpoint =
        '/patients/health-metrics${type != null ? '?type=$type' : ''}';
    final response = await get(endpoint);
    if (response is List) {
      return response.map((e) => HealthMetric.fromJson(e)).toList();
    }
    return [];
  }

  Future<void> logHealthMetric(Map<String, dynamic> data) async {
    await post('/patients/health-metrics', data);
  }

  // Appointments
  Future<List<dynamic>> getMyAppointments() async {
    final response = await get('/patients/appointments/me');
    if (response is List) return response;
    if (response is Map && response.containsKey('appointments'))
      return response['appointments'];
    return [];
  }

  Future<void> bookAppointment(Map<String, dynamic> data) async {
    await post('/patients/appointments', data);
  }

  // Bookings
  Future<List<dynamic>> getMyBookings() async {
    final response = await get('/patients/bookings/me');
    if (response is List) return response;
    if (response is Map && response.containsKey('bookings'))
      return response['bookings'];
    return [];
  }

  Future<void> bookLabTest(Map<String, dynamic> data) async {
    await post('/patients/bookings', data);
  }

  // Search
  Future<List<dynamic>> searchDoctors({
    String? query,
    String? specialization,
  }) async {
    String params = '';
    if (query != null) params += 'query=$query&';
    if (specialization != null) params += 'specialization=$specialization';
    final response = await get(
      '/patients/doctors${params.isNotEmpty ? '?$params' : ''}',
    );
    if (response is List) return response;
    return [];
  }

  Future<List<dynamic>> getLabs({String? city}) async {
    final response = await get(
      '/patients/labs${city != null ? '?city=$city' : ''}',
    );
    if (response is List) return response;
    return [];
  }

  // Records
  Future<List<dynamic>> getReports() async {
    final response = await get('/patients/reports');
    if (response is List) return response;
    return [];
  }

  Future<List<dynamic>> getPrescriptions() async {
    final response = await get('/patients/prescriptions');
    if (response is List) return response;
    return [];
  }
}
