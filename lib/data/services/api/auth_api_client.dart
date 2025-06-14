import 'package:dio/dio.dart';
import 'package:found_you_app/data/services/model/login_response/login_response.dart';
import 'package:found_you_app/domain/models/auth/login_request/login_request.dart';
import 'package:found_you_app/domain/models/form_field/form_field_model.dart';
import 'package:found_you_app/error/error_mapper.dart';
import 'package:found_you_app/network/dio_auth.dart';
import 'package:found_you_app/utils/result.dart';

class AuthApiClient {
  Dio _dio = authDio;

  AuthApiClient({Dio? dio}) : _dio = dio ?? authDio;

  Future<Result<LoginResponse>> login(LoginRequest loginRequest) async {
    try {
      final response = await _dio.post('/api/token/', data: loginRequest.toJson());
      return Result.ok(LoginResponse.fromJson(response.data));
    } on DioException catch (e) {
      return Result.error(mapDioError(e));
    } catch (e) {
      return Result.error(Exception('Unknown login error: $e'));
    }
  }

  Future<Result<String>> refreshToken(String refreshToken) async {
    try {
      final response = await _dio.post('/api/token/refresh/', data: {'refresh': refreshToken});
      return Result.ok(response.data['access']);
    } on DioException catch (e) {
      return Result.error(mapDioError(e));
    } catch (e) {
      return Result.error(Exception('Unknown refresh token error: $e'));
    }
  }

  Future<Result<List<FormFieldModel>>> getRegisterFormFields() async {
    try {
      final response = await _dio.get('/api/form/');
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data as Map<String, dynamic>;

        final List<FormFieldModel> fields =
            data.entries.map((entry) {
              final fieldData = entry.value as Map<String, dynamic>;

              return FormFieldModel(
            name: entry.key,
            label: fieldData['label'] as String,
            type: FormFieldType.values.firstWhere(
                  (e) => e.name == fieldData['type'],
                  orElse: () => FormFieldType.textfield,
                ),
                options:
                    fieldData['options'] != null
                        ? (fieldData['options'] as List).map((opt) => FormFieldOption.fromJson(opt)).toList()
                        : [],
              );
            }).toList();

        return Result.ok(fields);
      } else {
        return Result.error(Exception('Failed to load register form fields'));
      }
    } on DioException catch (e) {
      return Result.error(mapDioError(e));
    } catch (e) {
      return Result.error(Exception('Unknown error: $e'));
    }
  }

  Future<Result<void>> register({required Map<String, dynamic> data}) async {
    try {
      final response = await _dio.post('/api/users/', data: data);
      if (response.statusCode == 201) {
        return Result.ok(null);
      } else {
        return Result.error(Exception('Failed to register'));
      }
    } on DioException catch (e) {
      return Result.error(mapDioError(e));
    } catch (e) {
      return Result.error(Exception('Unknown error: $e'));
    }
  }
}
