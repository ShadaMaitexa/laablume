import '../models/user_model.dart';
import '../models/health_metric_model.dart';
import 'api_base_service.dart';

class PatientService extends ApiBaseService {
  Future<DashboardData> getDashboardData() async {
    // Mocking API call for now
    await Future.delayed(const Duration(seconds: 1));
    return DashboardData(
      upcomingAppointments: 2,
      pendingReports: 1,
      healthScore: 85,
    );
    
    // Actual implementation would be:
    // final response = await get('/dashboard');
    // return DashboardData.fromJson(response);
  }

  Future<UserModel> getProfile() async {
    await Future.delayed(const Duration(seconds: 1));
    return UserModel(
      id: "1",
      name: "John Doe",
      email: "john.doe@example.com",
    );
  }

  Future<List<HealthMetric>> getHealthMetrics() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      HealthMetric(
        id: "1",
        type: "Blood Glucose",
        value: "95",
        unit: "mg/dL",
        timestamp: DateTime.now(),
        status: "Normal",
      ),
      HealthMetric(
        id: "2",
        type: "Blood Pressure",
        value: "120/80",
        unit: "mmHg",
        timestamp: DateTime.now(),
        status: "Normal",
      ),
    ];
  }
}
