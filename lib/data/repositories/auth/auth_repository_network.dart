import 'package:flutter/material.dart';
import 'package:found_you_app/data/repositories/auth/auth_repository.dart';
import 'package:found_you_app/data/services/api/auth_api_client.dart';
import 'package:found_you_app/data/services/model/login_response/login_response.dart';
import 'package:found_you_app/data/services/secure_storage_service.dart';
import 'package:found_you_app/domain/models/auth/login_request/login_request.dart';
import 'package:found_you_app/domain/models/form_field/form_field_model.dart';
import 'package:found_you_app/utils/result.dart';

class AuthRepositoryNetwork extends AuthRepository {
  final AuthApiClient _authApiClient;
  final SecureStorageService _secureStorageService;

  AuthRepositoryNetwork({required AuthApiClient authApiClient, required SecureStorageService secureStorageService})
    : _authApiClient = authApiClient,
      _secureStorageService = secureStorageService;

  @override
  Future<bool> get isLogged => Future.value(_isLogged);

  bool _isLogged = false;

  @override
  Future<Result<void>> login({required String email, required String password, bool rememberMe = false}) async {
    final result = await _authApiClient.login(LoginRequest(email: email, password: password));
    switch (result) {
      case Error<LoginResponse>():
        return Result.error(result.error);
      case Ok<LoginResponse>():
        final LoginResponse loginResponse = result.value;
        await _secureStorageService.saveAccessToken(loginResponse.access);
        await _secureStorageService.saveRefreshToken(loginResponse.refresh);
        if(rememberMe) {
          await _secureStorageService.saveUserLogin(email);
          await _secureStorageService.saveUserPassword(password);
          await _secureStorageService.saveUserRememberMe(rememberMe);
        }
        _isLogged = true;
        return Result.ok(null);
    }
  }

  Future<Result<void>> refreshToken() async {
    final refreshToken = await _secureStorageService.fetchRefreshToken();
    switch (refreshToken) {
      case Error<String?>():
        return Result.error(refreshToken.error);
      case Ok<String?>():
        final String? token = refreshToken.value;
        if (token == null) {
          return Result.error(Exception('Refresh token is null'));
        }
        final result = await _authApiClient.refreshToken(token);
        switch (result) {
          case Error<String>():
            return Result.error(result.error);
          case Ok<String>():
            final String newAccessToken = result.value;
            await _secureStorageService.saveAccessToken(newAccessToken);
            return Result.ok(null);
        }
    }
  }
  @override
  Future<Result<void>> logout() async {
    final result = await _secureStorageService.deleteAccessToken();
    switch (result) {
      case Error<void>():
        return Result.error(result.error);
      case Ok<void>():
        _isLogged = false;
        notifyListeners();
        return Result.ok(null);
    }
  }

  Future<Result<String?>> getAccessToken() async {
    final result = await _secureStorageService.fetchAccessToken();
    switch (result) {
      case Error<String?>():
        return Result.error(result.error);
      case Ok<String?>():
        return Result.ok(result.value);
    }
  }

  Future<Result<void>> silentLogin() async {
    final rem = await _secureStorageService.fetchUserRememberMe();
    if (rem is Ok<bool?> && rem.value == true) {
      final u = await _secureStorageService.fetchUserLogin(), p = await _secureStorageService.fetchUserPassword();
      if (u is Ok<String?> && p is Ok<String?> && u.value != null && p.value != null) {
        return login(
          email: u.value!,
          password: p.value!,
          rememberMe: rem.value!,
        );
      }
    }
    return Result.error(Exception('No stored creds'));
  }

  @override
  Future<Result<void>> resetPassword({required String email}) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<Result<List<FormFieldModel>>> getRegisterFormFields() async{
    return await _authApiClient.getRegisterFormFields();
  }

  @override
  Future<Result<void>> register({required Map<String, dynamic> data}) async {
    return await _authApiClient.register(data: data);
  }
}
