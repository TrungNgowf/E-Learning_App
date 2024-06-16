import 'package:e_learning_app/services/user/user_service.dart';

class UserRepository {
  Future<double> getAccountBalance() async {
    try {
      var response = await UserService.getAccountBalance();
      if (response.statusCode == 200) {
        return double.parse(response.data.toString());
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
