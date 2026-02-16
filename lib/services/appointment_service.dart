import 'api_base_service.dart';

class AppointmentService extends ApiBaseService {
  static final AppointmentService _instance = AppointmentService._internal();
  factory AppointmentService() => _instance;
  AppointmentService._internal();

  // Get patient's appointments
  Future<List<dynamic>> getMyAppointments({String? status}) async {
    final queryParams = status != null ? {'status': status} : null;
    final response = await get(
      '/patients/appointments/me',
      queryParams: queryParams,
    );
    return response['appointments'] ?? response['data'] ?? [];
  }

  // Book new appointment
  Future<Map<String, dynamic>> bookAppointment(
    Map<String, dynamic> appointmentData,
  ) async {
    final response = await post('/patients/appointments', appointmentData);
    return response;
  }

  // Get appointment details
  Future<Map<String, dynamic>> getAppointmentDetails(String id) async {
    final response = await get('/doctor/appointments/$id');
    return response;
  }

  // Update appointment status (for doctors)
  Future<Map<String, dynamic>> updateAppointmentStatus(
    String id,
    String status, {
    String? reason,
  }) async {
    final response = await patch('/doctor/appointments/$id/status', {
      'status': status,
      if (reason != null) 'reason': reason,
    });
    return response;
  }

  // Cancel appointment (for patients)
  Future<Map<String, dynamic>> cancelAppointment(
    String id, {
    String? reason,
  }) async {
    return updateAppointmentStatus(id, 'cancelled', reason: reason);
  }
}
