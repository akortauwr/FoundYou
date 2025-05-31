import 'package:dio/dio.dart';
import 'package:found_you_app/data/repositories/auth/auth_repository_network.dart';
import 'package:found_you_app/utils/result.dart';

class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final AuthRepositoryNetwork _authRepositoryNetwork;
  bool isRefreshing = false;


  AuthInterceptor(this._authRepositoryNetwork, this._dio);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.path.endsWith('/token') || options.path.endsWith('/refresh')) {
      return handler.next(options);
    }
    final accessTokenResult = await _authRepositoryNetwork.getAccessToken();
    if(accessTokenResult is Ok<String?> && accessTokenResult.value != null) {
      options.headers['Authorization'] = 'Bearer ${accessTokenResult.value}';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      if (!isRefreshing) {
        isRefreshing = true;
        try {
          final refreshResult = await _authRepositoryNetwork.refreshToken();
          if (refreshResult is Ok<void>) {
            final accessTokenResult = await _authRepositoryNetwork.getAccessToken();
            if (accessTokenResult is Ok<String?> && accessTokenResult.value != null) {
              final opts = err.requestOptions;
              opts.headers['Authorization'] = 'Bearer ${accessTokenResult.value}';
              final cloned = await _dio.fetch(opts);
              return handler.resolve(cloned);
            }
          }
          final reLog = await _authRepositoryNetwork.silentLogin();
          if (reLog is Ok<void>) {
            final accessTokenResult = await _authRepositoryNetwork.getAccessToken();
            if (accessTokenResult is Ok<String?> && accessTokenResult.value != null) {
              final opts = err.requestOptions;
              opts.headers['Authorization'] = 'Bearer ${accessTokenResult.value}';
              final cloned = await _dio.fetch(opts);
              return handler.resolve(cloned);
            }
          }
          await _authRepositoryNetwork.logout();
        } finally {
          isRefreshing = false;
        }
      }
    }

  }


}