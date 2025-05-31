
import 'package:found_you_app/data/repositories/auth/auth_repository.dart';
import 'package:found_you_app/utils/command.dart';
import 'package:found_you_app/utils/result.dart';

class LogoutViewModel{
  final AuthRepository _authRepository;
  late Command0 logout;

  LogoutViewModel({required AuthRepository authRepository})
    : _authRepository = authRepository {
    logout = Command0<void>(_logout);
  }

  Future<Result<void>> _logout() async {
    final result = await _authRepository.logout();
    if (result is Error<void>) {
      // TODO Handle error
      print('EOEOEO');
    }
    return result;
  }
}