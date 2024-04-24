import 'dart:async';

import 'package:e_learning_app/models/auth/auth_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorageService {
  static const String HAVE_OPENED_BEFORE = 'device_opened_before';
  static const String FIREBASE_UID = 'user_firebase_uid';
  static const String USER_ID = 'user_id';
  static const String USERNAME = 'username';
  static const String USER_EMAIL = 'user_email';
  static const String USER_ROLES = 'user_roles';
  static const String ACCESS_TOKEN = 'user_access_token';
  static const String REFRESH_TOKEN = 'user_refresh_token';
}

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

  Future setInt(String key, int value) async {
    await prefs.setInt(key, value);
  }

  Future setStringList(String key, List<String> value) async {
    await prefs.setStringList(key, value);
  }

  bool get haveOpenedBefore {
    return prefs.getBool(AppStorageService.HAVE_OPENED_BEFORE) ?? false;
  }

  bool get isLoggedIn {
    return prefs.getString(AppStorageService.FIREBASE_UID) == null
        ? false
        : true;
  }

  Future remove(String key) async {
    await prefs.remove(key);
  }

  Future setProfile(AuthResponse authResponse) async {
    await Future.wait(
      [
        setString(AppStorageService.FIREBASE_UID, authResponse.firebaseUid),
        setInt(AppStorageService.USER_ID, authResponse.userId),
        setString(AppStorageService.USERNAME, authResponse.username),
        setString(AppStorageService.USER_EMAIL, authResponse.email),
        setString(AppStorageService.ACCESS_TOKEN, authResponse.accessToken),
        setString(AppStorageService.REFRESH_TOKEN, authResponse.refreshToken),
        setStringList(AppStorageService.USER_ROLES, authResponse.roles),
      ],
    );
  }

  AuthResponse? get currentUser {
    return isLoggedIn
        ? AuthResponse(
            firebaseUid: prefs.getString(AppStorageService.FIREBASE_UID)!,
            userId: prefs.getInt(AppStorageService.USER_ID)!,
            username: prefs.getString(AppStorageService.USERNAME)!,
            email: prefs.getString(AppStorageService.USER_EMAIL)!,
            accessToken: prefs.getString(AppStorageService.ACCESS_TOKEN)!,
            refreshToken: prefs.getString(AppStorageService.REFRESH_TOKEN)!,
            roles: prefs.getStringList(AppStorageService.USER_ROLES)!,
          )
        : null;
  }

  Future logout() async {
    await Future.wait(
      [
        remove(AppStorageService.FIREBASE_UID),
        remove(AppStorageService.USER_ID),
        remove(AppStorageService.ACCESS_TOKEN),
        remove(AppStorageService.REFRESH_TOKEN),
        remove(AppStorageService.USER_EMAIL),
        remove(AppStorageService.USERNAME),
        remove(AppStorageService.USER_ROLES),
      ],
    );
  }
}
