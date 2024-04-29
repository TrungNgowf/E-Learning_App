import 'package:e_learning_app/services/profile/profile_service.dart';

class ProfileRepository {
  Future updateToInstructor(Map<String, dynamic> map) async {
    try {
      var response = await ProfileService.updateToInstructor(map);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
