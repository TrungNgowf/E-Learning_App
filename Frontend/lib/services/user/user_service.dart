import 'package:e_learning_app/utils/api_config/http_util.dart';

class UserService {
  static Future getAccountBalance() async {
    return await HttpUtil().get('/User/GetAccountBalance');
  }
}
