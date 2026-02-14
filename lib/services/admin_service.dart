import 'api_base_service.dart';

class AdminService extends ApiBaseService {
  static final AdminService _instance = AdminService._internal();
  factory AdminService() => _instance;
  AdminService._internal();

  Future<List<dynamic>> getPendingHospitals() async {
    final response = await get('/admin/pending-hospitals');
    if (response is List) return response;
    if (response is Map && response.containsKey('hospitals')) {
      return response['hospitals'];
    }
    return [];
  }

  Future<void> approveHospital(String hospitalId) async {
    await post('/admin/approve-hospital/$hospitalId', {});
  }

  Future<void> rejectHospital(String hospitalId) async {
    await post('/admin/reject-hospital/$hospitalId', {});
  }
}
