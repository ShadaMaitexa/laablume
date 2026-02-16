import 'api_base_service.dart';

class HospitalService extends ApiBaseService {
  static final HospitalService _instance = HospitalService._internal();
  factory HospitalService() => _instance;
  HospitalService._internal();

  // Associate a doctor with the hospital
  Future<Map<String, dynamic>> addDoctor(Map<String, dynamic> data) async {
    final response = await post('/hospital/add-doctor', data);
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
