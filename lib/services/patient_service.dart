import 'dart:typed_data';
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

  // Patient Report Upload (V2 as per guide)
  // Upload and email report
  Future<Map<String, dynamic>> uploadPatientReport({
    required String bookingId,
    String? filePath,
    Uint8List? bytes,
    String? filename,
  }) async {
    final response = await upload(
      '/upload/patient-report/$bookingId',
      filePath,
      fieldName: 'report',
      bytes: bytes,
      filename: filename,
    );
    return response;
  }

  // Verify Doctor Docs
  Future<Map<String, dynamic>> uploadDoctorDocument(
    String? filePath, {
    Uint8List? bytes,
    String? filename,
  }) async {
    final response = await upload(
      '/upload/doctor-document',
      filePath,
      fieldName: 'document',
      bytes: bytes,
      filename: filename,
    );
    return response;
  }

  // Verify Lab Docs
  Future<Map<String, dynamic>> uploadLabDocument({
    required String labId,
    String? filePath,
    Uint8List? bytes,
    String? filename,
  }) async {
    final response = await upload(
      '/upload/lab-document/$labId',
      filePath,
      fieldName: 'document',
      bytes: bytes,
      filename: filename,
    );
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

  // Get tests provided by a specific lab
  Future<List<dynamic>> getLabTestsByLab(String labId) async {
    final response = await get('/patients/labs/$labId/tests');
    return response['tests'] ?? response['data'] ?? [];
  }

  // Find popular hospitals
  Future<List<dynamic>> getPopularHospitals() async {
    final response = await get('/patients/hospitals/popular');
    return response['hospitals'] ?? response['data'] ?? [];
  }

  // Search/filter available hospitals
  Future<List<dynamic>> searchHospitals({String? city, String? search}) async {
    final queryParams = <String, String>{};
    if (city != null) queryParams['city'] = city;
    if (search != null) queryParams['search'] = search;

    final response = await get(
      '/patients/hospitals',
      queryParams: queryParams.isNotEmpty ? queryParams : null,
    );
    return response['hospitals'] ?? response['data'] ?? [];
  }

  // Get details for a specific hospital
  Future<Map<String, dynamic>> getHospitalDetails(String hospitalId) async {
    final response = await get('/patients/hospitals/$hospitalId');
    return response['hospital'] ?? response['data'] ?? {};
  }

  // Submit feedback for lab, doctor, or hospital
  Future<Map<String, dynamic>> submitFeedback(
    Map<String, dynamic> feedbackData,
  ) async {
    final response = await post('/patients/feedback', feedbackData);
    return response;
  }

  // Get reviews for a specific entity
  Future<List<dynamic>> getReviews(String targetId) async {
    final response = await get(
      '/patients/reviews',
      queryParams: {'targetId': targetId},
    );
    return response['reviews'] ?? response['data'] ?? [];
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

  // View specific slots assigned by the hospital for a doctor
  Future<List<dynamic>> getDoctorSlots(String doctorId, {String? date}) async {
    final queryParams = date != null ? {'date': date} : null;
    final response = await get(
      '/patients/doctors/$doctorId/slots',
      queryParams: queryParams,
    );
    if (response is List) {
      return response;
    }
    return response['slots'] ?? response['data'] ?? [];
  }

  // Get full shared doctor profile (Profile Sharing)
  Future<Map<String, dynamic>> getDoctorDetails(String doctorId) async {
    // Note: The base path for this endpoint is usually /api according to docs, but ApiBaseService adds /api automatically
    final response = await get('/doctors/$doctorId/details');
    return response['doctor'] ?? response['data'] ?? {};
  }

  // History of all reviews the patient has posted
  Future<List<dynamic>> getMyReviews() async {
    final response = await get('/patients/feedback/my');
    return response['reviews'] ?? response['data'] ?? [];
  }

  // Upload profile image
  Future<Map<String, dynamic>> uploadProfileImage(
    String? filePath, {
    Uint8List? bytes,
    String? filename,
  }) async {
    final response = await upload(
      '/patients/upload-profile-image',
      filePath,
      fieldName: 'image',
      bytes: bytes,
      filename: filename,
    );
    return response;
  }

  // Complete initial health profiling/onboarding
  Future<Map<String, dynamic>> completeOnboarding(
    Map<String, dynamic> onboardingData,
  ) async {
    final response = await patch('/patients/health-profile', onboardingData);
    return response;
  }
}
