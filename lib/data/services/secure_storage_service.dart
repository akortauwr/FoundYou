import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:found_you_app/utils/result.dart';

class SecureStorageService {
  static final SecureStorageService _instance = SecureStorageService._internal();

  factory SecureStorageService() => _instance;

  SecureStorageService._internal();

  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _userLogin = 'user_login';
  static const _userPassword = 'user_password';
  static const _userRememberMe = 'user_remember_me';

  Future<Result<T?>> fetch<T>(String key) async {
    try {
      final raw = await _secureStorage.read(key: key);
      if (raw == null) return Result.ok(null as T);

      if (T == bool) {
        final parsed = raw.toLowerCase() == 'true';
        return Result.ok(parsed as T);
      }
      if (T == int) {
        return Result.ok(int.parse(raw) as T);
      }
      if (T == double) {
        return Result.ok(double.parse(raw) as T);
      }
      // Try JSON decode for complex types
      try {
        final decoded = jsonDecode(raw);
        return Result.ok(decoded as T);
      } catch (_) {
        // fallback to string
      }
      return Result.ok(raw as T);
    } catch (e) {
      return Result.error(Exception('Storage read error for key "$key": $e'));
    }
  }

  Future<Result<void>> save<T>(String key, T value) async {
    try {
      await _secureStorage.write(key: key, value: value.toString());
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> delete(String key) async {
    try {
      await _secureStorage.delete(key: key);
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> clear() async {
    try {
      await _secureStorage.deleteAll();
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<String?>> fetchAccessToken() => fetch<String?>(_accessTokenKey);

  Future<Result<void>> saveAccessToken(String? token) => save<String?>(_accessTokenKey, token);

  Future<Result<void>> deleteAccessToken() => delete(_accessTokenKey);

  Future<Result<String?>> fetchRefreshToken() => fetch<String?>(_refreshTokenKey);

  Future<Result<void>> saveRefreshToken(String? refreshToken) => save<String?>(_refreshTokenKey, refreshToken);

  Future<Result<void>> deleteRefreshToken() => delete(_refreshTokenKey);

  Future<Result<String?>> fetchUserLogin() => fetch<String?>(_userLogin);

  Future<Result<void>> saveUserLogin(String? login) => save<String?>(_userLogin, login);

  Future<Result<void>> deleteUserLogin() => delete(_userLogin);

  Future<Result<String?>> fetchUserPassword() => fetch<String?>(_userPassword);

  Future<Result<void>> saveUserPassword(String? password) => save<String?>(_userPassword, password);

  Future<Result<void>> deleteUserPassword() => delete(_userPassword);

  Future<Result<bool?>> fetchUserRememberMe() => fetch<bool?>(_userRememberMe);

  Future<Result<void>> saveUserRememberMe(bool rememberMe) => save<bool>(_userRememberMe, rememberMe);

  Future<Result<void>> deleteUserRememberMe() => delete(_userRememberMe);
}
