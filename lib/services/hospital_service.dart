import 'api_base_service.dart';

class HospitalService extends ApiBaseService {
  static final HospitalService _instance = HospitalService._internal();
  factory HospitalService() => _instance;
  HospitalService._internal();

  // List top-rated hospitals for the dashboard
  Future<List<dynamic>> getPopularHospitals() async {
    final response = await get('/hospital/popular');
    return response['hospitals'] ?? response['data'] ?? [];
  }

  // View doctors working at a specific hospital
  Future<List<dynamic>> getDoctorsByHospital(String hospitalId) async {
    final response = await get('/hospital/$hospitalId/doctors');
    return response['doctors'] ?? response['data'] ?? [];
  }

  // Assign a doctor to the hospital staff
  Future<Map<String, dynamic>> assignDoctor(Map<String, dynamic> data) async {
    final response = await post('/hospital/doctors/assign', data);
    return response;
  }

  // Associate a doctor with the hospital (legacy)
  Future<Map<String, dynamic>> addDoctor(Map<String, dynamic> data) async {
    final response = await post('/hospital/add-doctor', data);
    return response;
  }

  // Define and assign time slots to specific doctors
  Future<Map<String, dynamic>> manageSlots(Map<String, dynamic> data) async {
    final response = await post('/hospital/slots/manage', data);
    return response;
  }

  // Mark appointment as completed after the visit
  Future<Map<String, dynamic>> completeAppointment(String id) async {
    final response = await patch('/hospital/appointments/$id/complete', {});
    return response;
  }

  // View revenue reports
  Future<Map<String, dynamic>> getFinanceReport() async {
    final response = await get('/hospital/finance');
    return response;
  }

  // List all doctors in hospital staff
  Future<List<dynamic>> getHospitalDoctors() async {
    final response = await get('/hospital/doctors');
    return response['doctors'] ?? response['data'] ?? [];
  }

  // Remove doctor from hospital staff
  Future<Map<String, dynamic>> removeDoctor(String id) async {
    final response = await delete('/hospital/doctors/$id');
    return response;
  }

  // Overall stats for visits and revenue
  Future<Map<String, dynamic>> getDashboard() async {
    final response = await get('/hospital/dashboard');
    return response;
  }

  // Integrated view of all appointments in the facility
  Future<List<dynamic>> getAllAppointments() async {
    final response = await get('/hospital/appointments');
    return response['appointments'] ?? response['data'] ?? [];
  }
}
