import 'package:found_you_app/domain/models/suggested_friend/suggested_friend_model.dart';

class SuggestedFriendViewData {
  final SuggestedFriendModel model;
  bool isLiked = false;
  bool isRemoving = false;

  SuggestedFriendViewData({
    required this.model,
  });
}