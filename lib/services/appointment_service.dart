import '../models/appointment_model.dart';
import 'api_base_service.dart';

class AppointmentService extends ApiBaseService {
  Future<AppointmentModel> createAppointment({
    required String doctorID,
    required DateTime appointmentDateTime,
    required String reasonForVisit,
    String status = "Scheduled",
  }) async {
    final response = await post('/patients/appointments', {
      'doctorID': doctorID,
      'appointmentDateTime': appointmentDateTime.toUtc().toIso8601String(),
      'reasonForVisit': reasonForVisit,
      'status': status,
    });

    return AppointmentModel.fromJson(response['appointment'] ?? response);
  }

  Future<List<AppointmentModel>> getMyAppointments() async {
    final response = await get('/patients/appointments/me');

    final List<dynamic> list = (response is List)
        ? response
        : (response['appointments'] ?? []);
    return list.map((e) => AppointmentModel.fromJson(e)).toList();
  }

  Future<AppointmentModel> updateStatus(
    String appointmentID,
    String status,
  ) async {
    // Note: status update is typically for doctors
    final response = await patch('/doctor/appointments/$appointmentID/status', {
      'status': status,
    });

    return AppointmentModel.fromJson(response['appointment'] ?? response);
  }
}
