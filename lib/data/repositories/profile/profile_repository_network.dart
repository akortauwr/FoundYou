import 'package:found_you_app/data/repositories/profile/profile_repository.dart';
import 'package:found_you_app/data/services/api/foundyou_api_client.dart';
import 'package:found_you_app/domain/models/user_model/user_model.dart';
import 'package:found_you_app/utils/result.dart';

class ProfileRepositoryNetwork extends ProfileRepository {
  final FoundYouApiClient apiClient;

  ProfileRepositoryNetwork({required this.apiClient});

  @override
  Future<Result<UserModel>> loadProfile() async {
    return await apiClient.getProfile();
  }

  @override
  Future<Result<void>> deleteProfile() async {
    return await apiClient.deleteProfile();
  }

  @override
  Future<Result<void>> resetPassword({required String newPassword, required String oldPassword}) async {
    return await apiClient.resetPassword(
      newPassword: newPassword,
      oldPassword: oldPassword,
    );
  }


  @override
  Future<Result<void>> updateProfile({required Map<String, dynamic> data}) async {
    return await apiClient.updateProfile(data: data);
  }
}
