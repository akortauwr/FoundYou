import 'dart:async';

import 'package:dio/dio.dart';
import 'package:found_you_app/data/repositories/auth/auth_repository_network.dart';
import 'package:found_you_app/utils/result.dart';

// Helper class to store request options and their corresponding handlers
class _PendingRequest {
  final RequestOptions requestOptions;
  final ErrorInterceptorHandler handler;

  _PendingRequest(this.requestOptions, this.handler);
}

class AuthInterceptor extends Interceptor {
  final Dio _dio; // This Dio instance should be the one this interceptor is added to
  final AuthRepositoryNetwork _authRepositoryNetwork;
  bool _isRefreshing = false;
  final List<_PendingRequest> _pendingRequests = [];

  AuthInterceptor(this._authRepositoryNetwork, this._dio);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final String requestPath = options.uri.path;

    if (requestPath == '/api/token/' || requestPath == '/api/token/refresh/') {

      return handler.next(options);
    }

    final accessTokenResult = await _authRepositoryNetwork.getAccessToken();
    if (accessTokenResult is Ok<String?> && accessTokenResult.value != null) {
      options.headers['Authorization'] = 'Bearer ${accessTokenResult.value}';

    } else {

    }
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final String requestPath = err.requestOptions.uri.path;

      // Jeśli błąd 401 pochodzi z samego żądania odświeżenia tokenu,
      // to znaczy, że refresh token jest nieprawidłowy lub wygasł. Wyloguj.
      if (requestPath == '/api/token/refresh/') {

        await _authRepositoryNetwork.logout();
        _rejectPendingRequests(err); // Odrzuć wszystkie oczekujące żądania
        return handler.next(err); // Przekaż błąd dalej
      }

      if (_isRefreshing) {
        // Jeśli proces odświeżania jest już w toku, dodaj to żądanie do kolejki

        _pendingRequests.add(_PendingRequest(err.requestOptions, handler));
        // Nie wywołuj handler.next() ani handler.reject() jeszcze; poczekaj na zakończenie odświeżania
        return;
      }

      _isRefreshing = true;

      try {
        final refreshResult = await _authRepositoryNetwork.refreshToken();
        if (refreshResult is Ok<void>) {
          // Token odświeżony, ponów oryginalne żądanie
          await _retryRequest(err.requestOptions, handler);
          // Przetwórz wszystkie oczekujące żądania, które zostały zakolejkowane
          await _processPendingRequests();
        } else {

          final reLogResult = await _authRepositoryNetwork.silentLogin();
          if (reLogResult is Ok<void>) {
            await _retryRequest(err.requestOptions, handler);
            await _processPendingRequests();
          } else {

            await _authRepositoryNetwork.logout();
            _rejectPendingRequests(err); // Odrzuć oczekujące żądania
            handler.next(err); // Przekaż oryginalny błąd dla bieżącego żądania
          }
        }
      } catch (e) {
        // Złap nieoczekiwany błąd podczas procesu odświeżania/cichego logowania

        await _authRepositoryNetwork.logout();
        _rejectPendingRequests(DioException(requestOptions: err.requestOptions, error: e, response: err.response));
        handler.next(err); // Przekaż oryginalny błąd
      } finally {
        _isRefreshing = false;

      }
    } else {
      // Dla błędów innych niż 401, po prostu przekaż je dalej
      return handler.next(err);
    }
  }

  Future<void> _retryRequest(RequestOptions requestOptions, ErrorInterceptorHandler handler) async {
    final String requestPath = requestOptions.uri.path;

    final accessTokenResult = await _authRepositoryNetwork.getAccessToken();

    if (accessTokenResult is Ok<String?> && accessTokenResult.value != null) {
      // Sklonuj opcje żądania i zaktualizuj nagłówek autoryzacji.
      final newOptions = requestOptions.copyWith(
        headers: {
          ...requestOptions.headers,
          'Authorization': 'Bearer ${accessTokenResult.value}',
        },
      );
      try {
        // Użyj tej samej instancji Dio (_dio), aby wykonać nowe żądanie.
        // To zapewnia, że przejdzie ono ponownie przez łańcuch interceptorów (np. logowanie).
        final response = await _dio.fetch(newOptions);
        handler.resolve(response);

      } catch (e) {
        // Jeśli ponowienie próby nie powiodło się, przekaż nowy błąd
        if (e is DioException) {
          handler.reject(e);
        } else {
          handler.reject(DioException(requestOptions: newOptions, error: e));
        }
      }
    } else {
      // Ten przypadek oznacza, że pomyślnie odświeżyliśmy/zalogowaliśmy się,
      // ale nie mogliśmy później pobrać tokenu. To wskazuje na głębszy problem.
      // Wyloguj i odrzuć żądanie.
      await _authRepositoryNetwork.logout();
      handler.reject(DioException(
        requestOptions: requestOptions,
        response: Response(requestOptions: requestOptions, statusCode: 401, statusMessage: "Token unavailable post-refresh"),
        error: "Failed to retrieve new access token after successful refresh/login.",
      ));
    }
  }

  Future<void> _processPendingRequests() async {
    // Stwórz lokalną kopię i wyczyść oryginalną listę, aby uniknąć problemów z modyfikacją podczas iteracji
    final List<_PendingRequest> localPendingRequests = List.from(_pendingRequests);
    _pendingRequests.clear();


    for (var pendingRequest in localPendingRequests) {
      // Ponów każde oczekujące żądanie. To wywoła _retryRequest.
      await _retryRequest(pendingRequest.requestOptions, pendingRequest.handler);
    }
  }

  void _rejectPendingRequests(DioException originalError) {
    final List<_PendingRequest> localPendingRequests = List.from(_pendingRequests);
    _pendingRequests.clear();

    for (var pendingRequest in localPendingRequests) {
      pendingRequest.handler.reject(DioException(
          requestOptions: pendingRequest.requestOptions,
          response: originalError.response, // Można użyć odpowiedzi oryginalnego błędu
          error: "Authentication failed, request not retried: ${originalError.message}",
          type: originalError.type
      ));
    }
  }
}