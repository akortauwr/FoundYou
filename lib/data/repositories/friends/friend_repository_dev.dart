
import 'package:found_you_app/data/repositories/friends/friend_repository.dart';
import 'package:found_you_app/domain/models/friend_model/friend_model.dart';
import 'package:found_you_app/utils/result.dart';

class FriendRepositoryDev implements FriendRepository{

  final List<FriendModel> _friends = List<FriendModel>.generate(
    10,
        (index) => FriendModel(
      username: '$index',
      sex: 'male',
      bio: 'lalalal',
      age: 20 + index,
      imageUrl: 'path',
    ),
  );

  @override
  Future<Result<FriendModel>> getFriendDetails(int friendId){
    final friend = _friends.first;
    if (friend != null) {
      return Future.value(Result.ok(friend));
    } else {
      return Future.value(Result.error(Exception('Friend not found')));
    }
  }
}
