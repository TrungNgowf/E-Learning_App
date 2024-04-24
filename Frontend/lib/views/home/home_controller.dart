import 'dart:developer';

import 'package:e_learning_app/repositories/auth/auth_repository.dart';

class HomeController {
  AuthRepository _authRepository = AuthRepository();

  Future getMe() async {
    var test = await _authRepository.getMe();
    log(test.toString());
  }
}
