import 'package:e_learning_app/utils/api_config/http_util.dart';

class ProfileService {
  static Future updateToInstructor(Map<String, dynamic> request) async {
    return await HttpUtil().post('/User/UpdateToInstructor', data: request);
  }
}
