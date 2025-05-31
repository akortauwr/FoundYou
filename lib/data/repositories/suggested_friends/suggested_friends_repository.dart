import 'package:found_you_app/domain/models/suggested_friend/suggested_friend_model.dart';
import 'package:found_you_app/utils/result.dart';

abstract class SuggestedFriendsRepository {
  Future<Result<List<SuggestedFriendModel>>> loadSuggestedFriends();
}
