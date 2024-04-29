import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:e_learning_app/main.dart';
import 'package:e_learning_app/repositories/auth/auth_repository.dart';
import 'package:e_learning_app/utils/export.dart' as global;
import 'package:e_learning_app/utils/storage_service.dart';

class HttpUtil {
  static const String BASE_URL = 'https://192.168.39.92:2502';
  AuthRepository _authRepository = AuthRepository();

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      contentType: 'application/json',
      responseType: ResponseType.json,
    ),
  );

  HttpUtil() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        log('Request: ${options.uri}');
        options.headers['Accept'] = 'application/json';
        String? accessToken = Global.storageService.prefs
            .getString(AppStorageService.ACCESS_TOKEN);
        options.headers['Authorization'] = 'Bearer $accessToken';
        return handler.next(options);
      },
      onResponse: (response, handler) {
        log('Response: ${response.data}');
        return handler.next(response);
      },
      onError: (DioException error, handler) async {
        log('Error: ${error.message}');
        if (error.response?.statusCode == 401) {
          if (error.response?.data == 'Refresh token expired') {
            Global.storageService.logout();
            global.Get.offAllNamed(global.Routes.LOGIN);
          }
          String? refreshToken = Global.storageService.prefs
              .getString(AppStorageService.REFRESH_TOKEN);
          int userId =
              Global.storageService.prefs.getInt(AppStorageService.USER_ID)!;
          if (refreshToken != null) {
            try {
              final response = await _authRepository.refreshAccessToken(
                  userId, refreshToken);
              Global.storageService
                  .setString(AppStorageService.ACCESS_TOKEN, response);
              return handler.resolve(await _dio.fetch(error.requestOptions));
            } on DioException catch (e) {
              return handler.reject(e);
            }
          }
        }
        return handler.next(error);
      },
    ));
  }

  Future<Response> get(String path,
      {dynamic data, Map<String, dynamic>? query}) async {
    try {
      final response = await _dio.get(path, data: data, queryParameters: query);
      return response;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> post(String path,
      {dynamic data, Map<String, dynamic>? query}) async {
    try {
      final response =
          await _dio.post(path, data: data, queryParameters: query);
      return response;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
