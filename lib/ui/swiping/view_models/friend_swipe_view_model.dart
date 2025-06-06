import 'package:flutter/foundation.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:found_you_app/data/repositories/friends/friend_repository_network.dart';
import 'package:found_you_app/data/repositories/suggested_friends/suggested_friends_repository.dart';
import 'package:found_you_app/domain/models/suggested_friend/suggested_friend_model.dart';
import 'package:found_you_app/domain/models/user_model/user_model.dart';
import 'package:found_you_app/utils/result.dart';
import 'package:found_you_app/domain/models/friend_model/dev_friend_model.dart';


// class FriendSwipeViewModel extends ChangeNotifier {
//   final SuggestedFriendsRepository _repository;
//   final List<SuggestedFriendModel> _friends = [];
//   bool _isLoading = false;
//   SuggestedFriendModel? _lastRemovedFriend;
//
//   FriendSwipeViewModel({required SuggestedFriendsRepository repository})
//       : _repository = repository;
//
//   bool get isLoading => _isLoading;
//   List<SuggestedFriendModel> get friends => List.unmodifiable(_friends);
//
//   Future<void> loadInitialData() async {
//     _isLoading = true;
//     notifyListeners();
//
//     final res = await _repository.loadSuggestedFriends(); // Result<List<DevFriendModel>>
//     if (res is Ok<List<SuggestedFriendModel>>) {
//       // tylko gdy Ok – nadpisujemy listę
//       _friends
//         ..clear()
//         ..addAll(res.value);
//     } else {
//       // tu możesz np. zapisać błąd w polu _error i powiadomić UI
//       debugPrint('Error loading initial friends: ${(res as Error).error}');
//     }
//
//     _isLoading = false;
//     notifyListeners();
//   }
//
//   // Future<void> _maybeFetchMore() async {
//   //   if (_friends.length <= 2 && !_isLoading) {
//   //     _isLoading = true;
//   //     notifyListeners();
//   //
//   //     final res = await _repository.loadSuggestedFriends();
//   //     if (res is Ok<List<SuggestedFriendModel>>) {
//   //       // dodajemy tylko nowe
//   //       final newFriends = res.value.where((f) => !_friends.any((e) => e.id == f.id));
//   //       _friends.addAll(newFriends);
//   //     } else {
//   //       debugPrint('Error loading more friends: ${(res as Error).error}');
//   //     }
//   //
//   //     _isLoading = false;
//   //     notifyListeners();
//   //   }
//   // }
//
//   void swipeCard(bool liked) {
//     if (_friends.isEmpty) return;
//     _lastRemovedFriend = _friends.removeAt(0);
//     notifyListeners();
//     // opcjonalnie: _repository.sendLike(_lastRemovedFriend!.id, liked);
//     //_maybeFetchMore();
//   }
//
//   void undoLastSwipe() {
//     if (_lastRemovedFriend != null) {
//       _friends.insert(0, _lastRemovedFriend!);
//       _lastRemovedFriend = null;
//       notifyListeners();
//     }
//   }
// }
class UserSwipeViewModel extends ChangeNotifier {
  final SuggestedFriendsRepository _repository;

  UserSwipeViewModel({required SuggestedFriendsRepository repository})
      : _repository = repository;

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
        // Handle error
        debugPrint('Error loading users: ${(response as Error).error}');
        break;
    }

    isLoading = false;
    notifyListeners();
  }

  void onSwipe(SuggestedFriendModel user, CardSwiperDirection direction) {
    print('\n\n\n DIRECT SWIPE: $direction\n\n\n');
    if (direction == CardSwiperDirection.right ) {
      // TODO: API - polubienie użytkownika
      debugPrint('Liked: ${user.username}');
      _repository.likeUser(user.id).then((result) {
        if (result is Error) {
          debugPrint('Error liking user: ${result.error}');
        }
      });
    } else if (direction == CardSwiperDirection.left) {
      // TODO: API - odrzucenie użytkownika
      _repository.dislikeUser(user.id).then((result) {
        if (result is Error) {
          debugPrint('Error disliking user: ${result.error}');
        }
      });
      debugPrint('Disliked: ${user.username}');
    }

    users.remove(user);
    notifyListeners();

    print('users.length: ${users.length}');
    print(isLoading);

    if (users.length < 10 && !isLoading) {
      print('laduje');
      loadUsers(); // Ładowanie kolejnych użytkowników
    }
  }
}