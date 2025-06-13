import 'package:flutter/foundation.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:found_you_app/data/repositories/suggested_friends/suggested_friends_repository.dart';
import 'package:found_you_app/domain/models/suggested_friend/suggested_friend_model.dart';
import 'package:found_you_app/utils/result.dart';

class UserSwipeViewModel extends ChangeNotifier {
  final SuggestedFriendsRepository _repository;

  UserSwipeViewModel({required SuggestedFriendsRepository repository}) : _repository = repository;

  final Set<SuggestedFriendModel> users = {};
  bool isLoading = false;

  Future<void> loadUsers() async {
    isLoading = true;
    notifyListeners();

    final response = await _repository.loadSuggestedFriends();

    switch (response) {
      case Ok<List<SuggestedFriendModel>>():
        users.addAll(response.value);
        break;
      default:
        debugPrint('Error loading users: ${(response as Error).error}');
        break;
    }

    isLoading = false;
    notifyListeners();
  }

  void onSwipe(SuggestedFriendModel user, CardSwiperDirection direction) {
    if (direction == CardSwiperDirection.right) {
      _repository.likeUser(user.id).then((result) {
        if (result is Error) {
          debugPrint('Error liking user: ${result.error}');
        }
      });
    } else if (direction == CardSwiperDirection.left) {
      _repository.dislikeUser(user.id).then((result) {
        if (result is Error) {
          debugPrint('Error disliking user: ${result.error}');
        }
      });
      debugPrint('Disliked: ${user.username}');
    }

    users.remove(user);
    notifyListeners();

    if (users.length < 10 && !isLoading) {
      loadUsers();
    }
  }
}
