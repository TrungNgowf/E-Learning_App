import 'package:e_learning_app/utils/api_config/http_util.dart';

class AuthService {
  static Future signUpWithEmail(Map<String, dynamic> request) async {
    return await HttpUtil().post('/Auth/Register', data: request);
  }

  static Future loginWithEmail(Map<String, dynamic> request) async {
    return await HttpUtil().post('/Auth/Login', data: request);
  }

  static Future refreshAccessToken(int userId, String refreshToken) async {
    return await HttpUtil().get('/Auth/RefreshToken', query: {
      'userId': userId,
      'refreshToken': refreshToken,
    });
  }
}
