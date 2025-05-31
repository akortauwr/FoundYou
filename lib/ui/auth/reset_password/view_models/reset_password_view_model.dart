import 'package:found_you_app/data/repositories/auth/auth_repository.dart';
import 'package:found_you_app/utils/command.dart';
import 'package:found_you_app/utils/result.dart';

class ResetPasswordViewModel {
  final AuthRepository _authRepository;
  late Command1 resetPassword;

  ResetPasswordViewModel({required AuthRepository authRepository})
    : _authRepository = authRepository {
    resetPassword = Command1<void, String>(_resetPassword);
  }

  Future<Result<void>> _resetPassword(String email) async {
    final result = await _authRepository.resetPassword(email: email);
    if (result is Error<void>) {
      // TODO Handle error
      print('EOEOEO');
    }
    return result;
  }



}