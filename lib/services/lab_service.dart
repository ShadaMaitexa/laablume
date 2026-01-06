import '../models/lab_model.dart';
import 'api_base_service.dart';

class LabService extends ApiBaseService {
  Future<List<LabModel>> getAllLabs() async {
    final response = await get('/labs');
    if (response['labs'] != null) {
      return (response['labs'] as List)
          .map((e) => LabModel.fromJson(e))
          .toList();
    }
    return [];
  }

  Future<LabModel?> getLabById(String id) async {
    try {
      final response = await get('/labs/$id');
      if (response['lab'] != null) {
        return LabModel.fromJson(response['lab']);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<void> createLab(LabModel lab) async {
    await post('/labs', {
      'labName': lab.labName,
      'location': lab.location,
      'contactInfo': lab.contactInfo,
      'rating': lab.rating,
    });
  }

  Future<void> updateLab(String id, Map<String, dynamic> updates) async {
    await patch('/labs/$id', updates);
  }

  // DELETE method not supported in ApiBaseService yet, but if needed:
  // Future<void> deleteLab(String id) async { ... }
}
