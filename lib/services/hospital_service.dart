import 'api_base_service.dart';

class HospitalService extends ApiBaseService {
  static final HospitalService _instance = HospitalService._internal();
  factory HospitalService() => _instance;
  HospitalService._internal();

  Future<List<dynamic>> getPatients() async {
    final response = await get('/hospitals/patients');
    return response is List ? response : [];
  }

  Future<Map<String, dynamic>> getBedAvailability() async {
    final response = await get('/hospitals/beds');
    return response is Map<String, dynamic> ? response : {};
  }

  Future<void> admitPatient(Map<String, dynamic> patientData) async {
    await post('/hospitals/patients/admit', patientData);
  }

  Future<void> dischargePatient(String patientId) async {
    await post('/hospitals/patients/$patientId/discharge', {});
  }

  Future<List<dynamic>> getHospitalDoctors() async {
    final response = await get('/hospitals/doctors');
    return response is List ? response : [];
  }

  Future<void> addDoctor(Map<String, dynamic> doctorData) async {
    await post('/hospitals/doctors', doctorData);
  }
}
