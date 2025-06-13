import 'package:dio/dio.dart';
import 'package:found_you_app/data/repositories/auth/auth_repository_network.dart';
import 'package:found_you_app/data/services/api/auth_api_client.dart';
import 'package:found_you_app/data/services/secure_storage_service.dart';
import 'package:found_you_app/network/dio_auth.dart';
import 'package:found_you_app/network/interceptors/auth_interceptors.dart';

final Dio clientDio =
    (() {
      final dio = Dio(
        BaseOptions(
          baseUrl: 'http://10.0.2.2:8000/',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 15),
          headers: {'Content-Type': 'application/json'},
        ),
      );

      final authRepo = AuthRepositoryNetwork(
    authApiClient: AuthApiClient(dio: authDio),
    secureStorageService: SecureStorageService(),
  );

      dio.interceptors.addAll([AuthInterceptor(authRepo, dio), LogInterceptor(requestBody: true, responseBody: true)]);

      return dio;
})();
