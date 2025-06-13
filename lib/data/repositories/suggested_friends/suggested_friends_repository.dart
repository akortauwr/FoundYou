import 'package:found_you_app/domain/models/suggested_friend/suggested_friend_model.dart';
import 'package:found_you_app/utils/result.dart';

abstract class SuggestedFriendsRepository {
  Future<Result<List<SuggestedFriendModel>>> loadSuggestedFriends();

  Future<Result<List<SuggestedFriendModel>>> loadNearYou();

  Future<Result<List<SuggestedFriendModel>>> loadNewMatches();

  Future<Result<List<SuggestedFriendModel>>> loadRecentLikes();

  Future<Result<void>> likeUser(int userId);

  Future<Result<void>> dislikeUser(int userId);
}
