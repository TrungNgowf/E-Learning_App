import 'dart:async';

import 'package:e_learning_app/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  late final SharedPreferences prefs;

  Future<StorageService> init() async {
    prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future setBool(String key, bool value) async {
    await prefs.setBool(key, value);
  }

  Future setString(String key, String value) async {
    await prefs.setString(key, value);
  }

  bool get haveOpenedBefore {
    return prefs.getBool(AppStorageService.HAVE_OPENED_BEFORE) ?? false;
  }

  bool get isLoggedIn {
    return prefs.getString(AppStorageService.USER_TOKEN_KEY) == null
        ? false
        : true;
  }
}
