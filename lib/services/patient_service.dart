import 'api_base_service.dart';

class PatientService extends ApiBaseService {
  static final PatientService _instance = PatientService._internal();
  factory PatientService() => _instance;
  PatientService._internal();

  // Get patient dashboard summary
  Future<Map<String, dynamic>> getDashboard() async {
    final response = await get('/patients/dashboard');
    return response;
  }

  // Fetch patient profile and preferences
  Future<Map<String, dynamic>> getProfile() async {
    final response = await get('/patients/me');
    return response;
  }

  // Update personal information
  Future<Map<String, dynamic>> updateProfile(
    Map<String, dynamic> profileData,
  ) async {
    final response = await patch('/patients/me', profileData);
    return response;
  }

  // Fetch historical health data
  Future<List<dynamic>> getHealthMetrics({String? type}) async {
    final queryParams = type != null ? {'type': type} : null;
    final response = await get(
      '/patients/health-metrics',
      queryParams: queryParams,
    );
    return response['metrics'] ?? response['data'] ?? [];
  }

  // Log new health readings manually
  Future<Map<String, dynamic>> addHealthMetric(
    Map<String, dynamic> metricData,
  ) async {
    final response = await post('/patients/health-metrics', metricData);
    return response;
  }

  // List patient's consultation history and upcoming visits
  Future<List<dynamic>> getMyAppointments() async {
    final response = await get('/patients/appointments/me');
    return response['appointments'] ?? response['data'] ?? [];
  }

  // Book a new consultation with a doctor
  Future<Map<String, dynamic>> bookAppointment(
    Map<String, dynamic> appointmentData,
  ) async {
    final response = await post('/patients/appointments', appointmentData);
    return response;
  }

  // History of lab tests and current statuses
  Future<List<dynamic>> getMyBookings() async {
    final response = await get('/patients/bookings/me');
    return response['bookings'] ?? response['data'] ?? [];
  }

  // Book a specific diagnostic test
  Future<Map<String, dynamic>> bookTest(Map<String, dynamic> testData) async {
    final response = await post('/patients/bookings', testData);
    return response;
  }

  // Search/filter available doctors
  Future<List<dynamic>> searchDoctors({
    String? specialty,
    String? search,
    String? city,
  }) async {
    final queryParams = <String, String>{};
    if (specialty != null) queryParams['specialty'] = specialty;
    if (search != null) queryParams['search'] = search;
    if (city != null) queryParams['city'] = city;

    final response = await get(
      '/patients/doctors',
      queryParams: queryParams.isNotEmpty ? queryParams : null,
    );
    return response['doctors'] ?? response['data'] ?? [];
  }

  // Find available labs
  Future<List<dynamic>> searchLabs({String? city}) async {
    final queryParams = city != null ? {'city': city} : null;
    final response = await get('/patients/labs', queryParams: queryParams);
    return response['labs'] ?? response['data'] ?? [];
  }

  // Access and download finalized lab reports
  Future<List<dynamic>> getReports() async {
    final response = await get('/patients/reports');
    return response['reports'] ?? response['data'] ?? [];
  }

  // View digital prescriptions
  Future<List<dynamic>> getPrescriptions() async {
    final response = await get('/patients/prescriptions');
    return response['prescriptions'] ?? response['data'] ?? [];
  }
}
