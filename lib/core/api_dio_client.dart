import 'package:dio/dio.dart';

class ApiDioClient {
  ApiDioClient(this._dio) {
    _dio.options = BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3/',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    );
  }
  final Dio _dio;

  Future<Response<dynamic>> get(String endpoint, {Map<String, dynamic>? queryParams}) async {
    try {
      return await _dio.get(endpoint, queryParameters: queryParams);
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}
