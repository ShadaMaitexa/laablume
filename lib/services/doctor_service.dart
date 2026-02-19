import 'api_base_service.dart';

class DoctorService extends ApiBaseService {
  static final DoctorService _instance = DoctorService._internal();
  factory DoctorService() => _instance;
  DoctorService._internal();

  // --- Doctor Portal Endpoints ---

  // Get doctor's daily schedule
  Future<List<dynamic>> getAppointments({String? status, String? date}) async {
    final queryParams = <String, String>{};
    if (status != null) queryParams['status'] = status;
    if (date != null) queryParams['date'] = date;

    final response = await get(
      '/doctor/appointments',
      queryParams: queryParams.isNotEmpty ? queryParams : null,
    );
    return response['appointments'] ?? response['data'] ?? [];
  }

  // Get doctor's patient list
  Future<List<dynamic>> getPatients({String? search}) async {
    final queryParams = search != null ? {'search': search} : null;
    final response = await get('/doctor/patients', queryParams: queryParams);
    return response['patients'] ?? response['data'] ?? [];
  }

  // Update appointment status (Accept/Complete/Cancel)
  Future<Map<String, dynamic>> updateAppointmentStatus(
    String id,
    String status,
  ) async {
    final response = await patch('/doctor/appointments/$id/status', {
      'status': status,
    });
    return response;
  }

  // Get detailed appointment view
  Future<Map<String, dynamic>> getAppointmentDetails(String id) async {
    final response = await get('/doctor/appointments/$id');
    return response;
  }

  // Get authorized patient medical history
  Future<Map<String, dynamic>> getPatientHistory(String id) async {
    final response = await get('/doctor/patients/$id/history');
    return response;
  }

  // Save diagnosis and clinical notes
  Future<Map<String, dynamic>> saveConsultationRecords(
    String appointmentId,
    Map<String, dynamic> records,
  ) async {
    final response = await post(
      '/doctor/consultations/$appointmentId/records',
      records,
    );
    return response;
  }

  // Issue digital prescription
  Future<Map<String, dynamic>> issuePrescription(
    String appointmentId,
    List<Map<String, dynamic>> prescriptions,
  ) async {
    final response = await post(
      '/doctor/consultations/$appointmentId/prescribe',
      {'prescriptions': prescriptions},
    );
    return response;
  }

  // --- Legacy / Compatibility ---

  // Get lab reports for doctor's patients
  Future<List<dynamic>> getLabReports() async {
    final response = await get('/doctor/lab-reports');
    return response['reports'] ?? response['data'] ?? [];
  }

  // Get patient reviews for the doctor
  Future<List<dynamic>> getReviews() async {
    final response = await get('/doctor/reviews');
    return response['reviews'] ?? response['data'] ?? [];
  }

  // Get list of all doctors (for patient view)
  Future<List<dynamic>> getAllDoctors({
    String? specialty,
    String? search,
  }) async {
    final queryParams = <String, String>{};
    if (specialty != null) queryParams['specialty'] = specialty;
    if (search != null) queryParams['search'] = search;

    final response = await get(
      '/patients/doctors',
      queryParams: queryParams.isNotEmpty ? queryParams : null,
    );
    return response['doctors'] ?? response['data'] ?? [];
  }

  // Get doctor by ID
  Future<Map<String, dynamic>> getDoctorById(String id) async {
    final response = await get('/patients/doctors/$id');
    return response;
  }

  // --- Public Doctors Search & Discovery ---

  // Get all doctors (V2 path)
  Future<List<dynamic>> getDoctorsPublic() async {
    final response = await get('/doctors');
    return response['doctors'] ?? response['data'] ?? [];
  }

  // Search doctors by name, specialty, or hospital
  Future<List<dynamic>> searchDoctors({
    String? query,
    String? specialty,
    String? hospital,
  }) async {
    final queryParams = <String, String>{};
    if (query != null) queryParams['name'] = query;
    if (specialty != null) queryParams['specialty'] = specialty;
    if (hospital != null) queryParams['hospital'] = hospital;

    final response = await get(
      '/doctors/search',
      queryParams: queryParams.isNotEmpty ? queryParams : null,
    );
    return response['doctors'] ?? response['data'] ?? [];
  }

  // Seed sample doctors (Dev only)
  Future<Map<String, dynamic>> seedDoctors() async {
    final response = await post('/doctors/seed', {});
    return response;
  }

  // Get doctor bio, experience, consultation fee, and patient reviews
  Future<Map<String, dynamic>> getDoctorDetails(String id) async {
    final response = await get('/doctors/$id/details');
    return response;
  }

  // Get available time slots for a doctor
  Future<List<dynamic>> getDoctorSlots(String id) async {
    final response = await get('/doctors/$id/slots');
    return response['slots'] ?? response['data'] ?? [];
  }

  // Get doctor by ID (V2 path)
  Future<Map<String, dynamic>> getDoctorByIdPublic(String id) async {
    final response = await get('/doctors/$id');
    return response;
  }
}
