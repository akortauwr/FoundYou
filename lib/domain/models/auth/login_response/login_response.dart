import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_response.freezed.dart'; // 👈 Required for Freezed
part 'login_response.g.dart'; // 👈 Required for JSON serialization


@freezed
abstract class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    required String access,
    required String refresh,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}
