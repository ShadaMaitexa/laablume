import '../models/doctor_model.dart';
import 'api_base_service.dart';

class DoctorService extends ApiBaseService {
  Future<List<dynamic>> getAppointments({String? status, String? date}) async {
    String params = '';
    if (status != null) params += 'status=$status&';
    if (date != null) params += 'date=$date';
    final response = await get(
      '/doctor/appointments${params.isNotEmpty ? '?$params' : ''}',
    );
    if (response is List) return response;
    if (response is Map && response.containsKey('appointments'))
      return response['appointments'];
    return [];
  }

  Future<Map<String, dynamic>> getAppointmentById(String id) async {
    return await get('/doctor/appointments/$id');
  }

  Future<void> updateAppointmentStatus(String id, String status) async {
    await patch('/doctor/appointments/$id/status', {'status': status});
  }

  Future<List<dynamic>> getPatients({String? search}) async {
    final response = await get(
      '/doctor/patients${search != null ? '?search=$search' : ''}',
    );
    if (response is List) return response;
    return [];
  }

  Future<List<dynamic>> getPatientHistory(String patientId) async {
    final response = await get('/doctor/patients/$patientId/history');
    if (response is List) return response;
    return [];
  }

  Future<void> saveConsultationRecords(
    String appointmentId,
    Map<String, dynamic> data,
  ) async {
    await post('/doctor/consultations/$appointmentId/records', data);
  }

  Future<void> issuePrescription(
    String appointmentId,
    Map<String, dynamic> data,
  ) async {
    await post('/doctor/consultations/$appointmentId/prescribe', data);
  }

  // For UI Compatibility (mostly used by patient role)
  Future<List<DoctorModel>> getAllDoctors() async {
    final response = await get('/patients/doctors');
    if (response is List) {
      return response.map((e) => DoctorModel.fromJson(e)).toList();
    }
    return [];
  }

  Future<DoctorModel?> getDoctorById(String id) async {
    // The list doesn't have a specific get-by-id for patients,
    // but typically it's the same or filtered. For now:
    final response = await get('/patients/doctors?query=$id');
    if (response is List && response.isNotEmpty) {
      return DoctorModel.fromJson(response.first);
    }
    return null;
  }
}
