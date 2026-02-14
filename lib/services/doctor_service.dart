import 'api_base_service.dart';
import '../models/doctor_model.dart';

class DoctorService extends ApiBaseService {
  static final DoctorService _instance = DoctorService._internal();
  factory DoctorService() => _instance;
  DoctorService._internal();

  Future<DoctorModel?> getDoctorById(String doctorId) async {
    try {
      final response = await get('/doctors/$doctorId');
      if (response != null && response is Map<String, dynamic>) {
        return DoctorModel.fromJson(response);
      }
      return null;
    } catch (e) {
      print('Error fetching doctor by ID: $e');
      return null;
    }
  }

  Future<List<DoctorModel>> getAllDoctors() async {
    try {
      final response = await get('/doctors');
      if (response != null && response is List) {
        return response
            .map((json) => DoctorModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      print('Error fetching all doctors: $e');
      return [];
    }
  }

  Future<List<dynamic>> getAppointments() async {
    final response = await get('/doctors/appointments');
    return response is List ? response : [];
  }

  Future<List<dynamic>> getPatients() async {
    final response = await get('/doctors/patients');
    return response is List ? response : [];
  }

  Future<Map<String, dynamic>> getPatientHistory(String patientId) async {
    final response = await get('/doctors/patients/$patientId/history');
    return response is Map<String, dynamic> ? response : {};
  }

  Future<void> updateAppointmentStatus(
    String appointmentId,
    String status,
  ) async {
    await patch('/doctors/appointments/$appointmentId', {'status': status});
  }

  Future<void> addConsultationNotes(
    String appointmentId,
    Map<String, dynamic> notes,
  ) async {
    await post('/doctors/appointments/$appointmentId/notes', notes);
  }
}
