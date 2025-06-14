import 'package:found_you_app/domain/models/user_model/user_model.dart';
import 'package:found_you_app/utils/result.dart';

abstract class ProfileRepository {
  Future<Result<UserModel>> loadProfile();

  Future<Result<void>> deleteProfile();

  Future<Result<void>> resetPassword({required String newPassword, required String oldPassword});
}
