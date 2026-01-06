import '../models/doctor_model.dart';

import '../models/doctor_model.dart';
import 'api_base_service.dart';

class DoctorService extends ApiBaseService {
  Future<List<DoctorModel>> getAllDoctors() async {
    try {
      final response = await get('/doctors');
      if (response['doctors'] != null) {
        return (response['doctors'] as List)
            .map((e) => DoctorModel.fromJson(e))
            .toList();
      }
      return [];
    } catch (e) {
      // Return empty list on error for now or rethrow
      return [];
    }
  }

  Future<DoctorModel?> getDoctorById(String id) async {
    try {
      final response = await get('/doctors/$id');
      if (response['doctor'] != null) {
        return DoctorModel.fromJson(response['doctor']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> createDoctor(DoctorModel doctor) async {
    await post('/doctors', doctor.toJson());
  }
}
