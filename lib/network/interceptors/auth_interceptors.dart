import 'dart:async';

import 'package:dio/dio.dart';
import 'package:found_you_app/data/repositories/auth/auth_repository_network.dart';
import 'package:found_you_app/utils/result.dart';

class _PendingRequest {
  final RequestOptions requestOptions;
  final ErrorInterceptorHandler handler;

  _PendingRequest(this.requestOptions, this.handler);
}

class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final AuthRepositoryNetwork _authRepositoryNetwork;
  bool _isRefreshing = false;
  final List<_PendingRequest> _pendingRequests = [];

  AuthInterceptor(this._authRepositoryNetwork, this._dio);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final String requestPath = options.uri.path;

    if (requestPath == '/api/token/' || requestPath == '/api/token/refresh/') {
      return handler.next(options);
    }

    final accessTokenResult = await _authRepositoryNetwork.getAccessToken();
    if (accessTokenResult is Ok<String?> && accessTokenResult.value != null) {
      options.headers['Authorization'] = 'Bearer ${accessTokenResult.value}';
    } else {}
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final String requestPath = err.requestOptions.uri.path;

      if (requestPath == '/api/token/refresh/') {
        await _authRepositoryNetwork.logout();
        _rejectPendingRequests(err);
        return handler.next(err);
      }

      if (_isRefreshing) {
        _pendingRequests.add(_PendingRequest(err.requestOptions, handler));

        return;
      }

      _isRefreshing = true;

      try {
        final refreshResult = await _authRepositoryNetwork.refreshToken();
        if (refreshResult is Ok<void>) {
          await _retryRequest(err.requestOptions, handler);

          await _processPendingRequests();
        } else {
          final reLogResult = await _authRepositoryNetwork.silentLogin();
          if (reLogResult is Ok<void>) {
            await _retryRequest(err.requestOptions, handler);
            await _processPendingRequests();
          } else {
            await _authRepositoryNetwork.logout();
            _rejectPendingRequests(err);
            handler.next(err);
          }
        }
      } catch (e) {
        await _authRepositoryNetwork.logout();
        _rejectPendingRequests(DioException(requestOptions: err.requestOptions, error: e, response: err.response));
        handler.next(err);
      } finally {
        _isRefreshing = false;
      }
    } else {
      return handler.next(err);
    }
  }

  Future<void> _retryRequest(RequestOptions requestOptions, ErrorInterceptorHandler handler) async {
    final accessTokenResult = await _authRepositoryNetwork.getAccessToken();

    if (accessTokenResult is Ok<String?> && accessTokenResult.value != null) {
      final newOptions = requestOptions.copyWith(
        headers: {...requestOptions.headers, 'Authorization': 'Bearer ${accessTokenResult.value}'},
      );
      try {
        final response = await _dio.fetch(newOptions);
        handler.resolve(response);
      } catch (e) {
        if (e is DioException) {
          handler.reject(e);
        } else {
          handler.reject(DioException(requestOptions: newOptions, error: e));
        }
      }
    } else {
      await _authRepositoryNetwork.logout();
      handler.reject(
        DioException(
          requestOptions: requestOptions,
          response: Response(
            requestOptions: requestOptions,
            statusCode: 401,
            statusMessage: "Token unavailable post-refresh",
          ),
          error: "Failed to retrieve new access token after successful refresh/login.",
        ),
      );
    }
  }

  Future<void> _processPendingRequests() async {
    final List<_PendingRequest> localPendingRequests = List.from(_pendingRequests);
    _pendingRequests.clear();

    for (var pendingRequest in localPendingRequests) {
      await _retryRequest(pendingRequest.requestOptions, pendingRequest.handler);
    }
  }

  void _rejectPendingRequests(DioException originalError) {
    final List<_PendingRequest> localPendingRequests = List.from(_pendingRequests);
    _pendingRequests.clear();

    for (var pendingRequest in localPendingRequests) {
      pendingRequest.handler.reject(
        DioException(
          requestOptions: pendingRequest.requestOptions,
          response: originalError.response,
          error: "Authentication failed, request not retried: ${originalError.message}",
          type: originalError.type,
        ),
      );
    }
  }
}
