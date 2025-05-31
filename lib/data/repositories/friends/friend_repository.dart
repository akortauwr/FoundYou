
import 'package:found_you_app/domain/models/friend_model/friend_model.dart';
import 'package:found_you_app/utils/result.dart';

abstract class FriendRepository {
  Future<Result<FriendModel>> getFriendDetails(int friendId);
}