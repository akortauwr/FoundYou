import 'package:dio/dio.dart';
import 'package:found_you_app/network/dio_client.dart';

class ApiClient{
  final Dio _dio;
  ApiClient({Dio? dio}): _dio = dio ?? clientDio;

  Future<T> get<T>(String path, { Map<String, dynamic>? queryParameters }) async {
    final response = await _dio.get(path, queryParameters: queryParameters);
    return response.data as T;
  }

  Future<T> post<T>(String path, dynamic data) async {
    final response = await _dio.post(path, data: data);
    return response.data as T;
  }

  Future<T> put<T>(String path, dynamic data) async {
    final response = await _dio.put(path, data: data);
    return response.data as T;
  }

  Future<T> delete<T>(String path) async {
    final response = await _dio.delete(path);
    return response.data as T;
  }
}