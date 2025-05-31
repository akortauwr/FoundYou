
import 'package:found_you_app/data/repositories/auth/auth_repository.dart';
import 'package:found_you_app/data/services/api/foundyou_api_client.dart';
import 'package:found_you_app/domain/models/form_field/form_field_model.dart';
import 'package:found_you_app/utils/result.dart';

class AuthRepositoryDev extends AuthRepository{
  @override
  Future<bool> get isLogged => Future.value(_isLogged);

  bool _isLogged = false;

  @override
  Future<Result<void>> login({required String email, required String password, bool rememberMe = false}) async {
    _isLogged = true;
    if (rememberMe) {
      // TODO Save user data to local storage
    }
    else {
      // TODO Save user data to session storage
    }

    //FoundYouApi(authHeaderProvider: () {  }).setToken('token');
    return Result.ok(null);
  }

  @override
  Future<Result<void>> logout() async {
    _isLogged = false;
    return Result.ok(null);
  }

  @override
  Future<Result<void>> resetPassword({required String email}) async {
    return Result.ok(null);
  }

  @override
  Future<Result<List<FormFieldModel>>> getRegisterFormFields() async {
    return Result.ok([
      FormFieldModel(
        name: 'radio',
        label: 'Radio',
        type: FormFieldType.radio,
        options: List.generate(2, (index) => FormFieldOption(name: 'Option ${index + 1}', value: index)),
      ),
      FormFieldModel(
        name: 'Photo',
        label: 'Photo',
        type: FormFieldType.photo,
      ),
      FormFieldModel(
        name: 'date',
        label: 'date',
        type: FormFieldType.date,
      ),
      FormFieldModel(
        name: 'Select',
        label: 'Select',
        type: FormFieldType.select,
        options: List.generate(2, (index) => FormFieldOption(name: 'Option ${index + 1}', value: index)),
      ),
      FormFieldModel(
        name: 'test',
        label: 'Test',
        type: FormFieldType.textarea,
      ),
    ]);
  }

  @override
  Future<Result<void>> register({required Map<String, dynamic> data}) async {
    return Result.ok(null);
  }

}