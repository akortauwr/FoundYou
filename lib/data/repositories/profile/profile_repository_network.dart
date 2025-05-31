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
}
