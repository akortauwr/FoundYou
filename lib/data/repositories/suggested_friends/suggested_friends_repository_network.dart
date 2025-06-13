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

  @override
  Future<Result<List<SuggestedFriendModel>>> loadNearYou() async {
    return await apiClient.getNearYou();
  }

  @override
  Future<Result<List<SuggestedFriendModel>>> loadNewMatches() async {
    return await apiClient.getNewMatches();
  }

  @override
  Future<Result<List<SuggestedFriendModel>>> loadRecentLikes() async {
    return await apiClient.getRecentLikes();
  }

  @override
  Future<Result<void>> likeUser(int userId) async {
    return await apiClient.likeUser(userId);
  }

  @override
  Future<Result<void>> dislikeUser(int userId) async {
    return await apiClient.dislikeUser(userId);
  }
}
