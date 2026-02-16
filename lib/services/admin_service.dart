import 'api_base_service.dart';

class AdminService extends ApiBaseService {
  static final AdminService _instance = AdminService._internal();
  factory AdminService() => _instance;
  AdminService._internal();

  // Get list of hospitals awaiting verification
  Future<List<dynamic>> getPendingHospitals() async {
    final response = await get('/admin/pending-hospitals');
    return response['hospitals'] ?? response['data'] ?? [];
  }

  // Approve/Enable a hospital entity
  Future<Map<String, dynamic>> approveHospital(String id) async {
    final response = await post('/admin/approve-hospital/$id', {});
    return response;
  }

  // Get list of diagnostic centers awaiting verification
  Future<List<dynamic>> getPendingLabs() async {
    final response = await get('/admin/pending-labs');
    return response['labs'] ?? response['data'] ?? [];
  }

  // Approve/Enable a lab entity
  Future<Map<String, dynamic>> approveLab(String id) async {
    final response = await post('/admin/approve-lab/$id', {});
    return response;
  }

  // Search and manage all platform users
  Future<List<dynamic>> getUsers({String? search}) async {
    final queryParams = search != null ? {'search': search} : null;
    final response = await get('/admin/users', queryParams: queryParams);
    return response['users'] ?? response['data'] ?? [];
  }

  // Suspend or deactivate accounts
  Future<Map<String, dynamic>> updateUserStatus(
    String id,
    bool isActive,
  ) async {
    final response = await patch('/admin/users/$id/status', {
      'isActive': isActive,
    });
    return response;
  }

  // Platform-wide usage and growth analytics
  Future<Map<String, dynamic>> getSystemReports() async {
    final response = await get('/admin/reports/system');
    return response;
  }
}
