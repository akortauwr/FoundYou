
import 'package:found_you_app/data/repositories/suggested_friends/suggested_friends_repository.dart';
import 'package:found_you_app/data/services/api/foundyou_api_client.dart';
import 'package:found_you_app/domain/models/suggested_friend/suggested_friend_model.dart';
import 'package:found_you_app/utils/result.dart';

class SuggestedFriendsRepositoryNetwork extends SuggestedFriendsRepository {
  final FoundYouApiClient apiClient;
  SuggestedFriendsRepositoryNetwork({required this.apiClient});

  @override
  Future<Result<List<SuggestedFriendModel>>> loadSuggestedFriends() async {
    return await apiClient.getSuggestedFriends();
  }
}