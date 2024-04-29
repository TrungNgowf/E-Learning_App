import 'package:e_learning_app/models/auth/auth_response.dart';
import 'package:e_learning_app/services/auth/auth_service.dart';

class AuthRepository {
  Future signUpWithEmail(Map<String, dynamic> request) async {
    try {
      var response = await AuthService.signUpWithEmail(request);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<AuthResponse> loginWithEmail(Map<String, dynamic> request) async {
    try {
      var response = await AuthService.loginWithEmail(request);
      if (response.statusCode == 200) {
        var authResponse = AuthResponse.fromJson(response.data);
        return authResponse;
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future refreshAccessToken(int userId, String refreshToken) async {
    try {
      var response = await AuthService.refreshAccessToken(userId, refreshToken);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
