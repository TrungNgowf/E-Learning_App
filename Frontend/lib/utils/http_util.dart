import 'package:dio/dio.dart';

class HttpUtil {
  static const String BASE_URL = 'https://jsonplaceholder.typicode.com';

  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() => _instance;
  late Dio _dio;

  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {},
      contentType: 'application/json charset=utf-8',
      responseType: ResponseType.json,
    );
    _dio = Dio(options);
  }

  Future get(String path) async {
    try {
      final response = await _dio.get(path);
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future post(String path, {dynamic data, Map<String, dynamic>? query}) async {
    try {
      final response =
          await _dio.post(path, data: data, queryParameters: query);
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
