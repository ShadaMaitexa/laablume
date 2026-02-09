import 'api_base_service.dart';

class HospitalService extends ApiBaseService {
  Future<List<dynamic>> getPatients({String? status}) async {
    final endpoint =
        '/hospital/patients${status != null ? '?status=$status' : ''}';
    final response = await get(endpoint);
    if (response is List) return response;
    return [];
  }

  Future<void> admitPatient(Map<String, dynamic> data) async {
    await post('/hospital/patients/admit', data);
  }

  Future<void> dischargePatient(String patientId) async {
    await post('/hospital/patients/$patientId/discharge', {});
  }

  Future<List<dynamic>> getBeds() async {
    final response = await get('/hospital/beds');
    if (response is List) return response;
    return [];
  }

  Future<void> updateBedStatus(String bedId, Map<String, dynamic> data) async {
    await patch('/hospital/beds/$bedId', data);
  }

  // Compatibility methods for old code
  Future<void> addDoctor(Map<String, dynamic> data) async {
    // This was previously in AuthService, assuming same endpoint or logical replacement
    await post('/hospital/add-doctor', data);
  }

  Future<List<dynamic>> getHospitalDoctors() async {
    final response = await get('/hospital/doctors');
    if (response is List) return response;
    return [];
  }
}
