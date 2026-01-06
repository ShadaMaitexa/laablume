import '../models/appointment_model.dart';
import 'api_base_service.dart';

class AppointmentService extends ApiBaseService {
  Future<AppointmentModel> createAppointment({
    required String doctorID,
    required DateTime appointmentDateTime,
    required String reasonForVisit,
    String status = "Scheduled",
  }) async {
    final response = await post('/appointments', {
      'doctorID': doctorID,
      'appointmentDateTime': appointmentDateTime.toUtc().toIso8601String(),
      'reasonForVisit': reasonForVisit,
      'status': status,
    });
    
    return AppointmentModel.fromJson(response['appointment']);
  }

  Future<List<AppointmentModel>> getMyAppointments() async {
    final response = await get('/appointments/me');
    
    if (response['appointments'] != null) {
      return (response['appointments'] as List)
          .map((e) => AppointmentModel.fromJson(e))
          .toList();
    }
    return [];
  }

  Future<AppointmentModel> updateStatus(String appointmentID, String status) async {
    final response = await patch('/appointments/$appointmentID/status', {
      'status': status,
    });
    
    return AppointmentModel.fromJson(response['appointment']);
  }
}
