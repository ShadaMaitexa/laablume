import 'package:laablume/models/user_model.dart';
import 'package:laablume/models/health_metric_model.dart';
import 'package:laablume/services/api_base_service.dart';

class PatientService extends ApiBaseService {
  Future<DashboardData> getDashboardData() async {
    // Mocking API call for now
    await Future.delayed(const Duration(seconds: 1));
    return DashboardData(
      upcomingAppointments: 2,
      pendingReports: 1,
      healthScore: 85,
    );
  }

  Future<UserModel> getProfile() async {
    await Future.delayed(const Duration(seconds: 1));
    return UserModel(
      id: "1",
      name: "John Doe",
      email: "john.doe@example.com",
      mobileNumber: "+910000000000",
      role: "patient",
      isApproved: true,
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
