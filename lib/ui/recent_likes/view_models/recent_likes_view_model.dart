import 'package:flutter/material.dart';
import 'package:found_you_app/data/repositories/suggested_friends/suggested_friends_repository.dart';
import 'package:found_you_app/domain/models/suggested_friend/suggested_friend_model.dart';
import 'package:found_you_app/utils/result.dart';

class RecentLikesViewModel extends ChangeNotifier {
  final SuggestedFriendsRepository _repository;
  List<SuggestedFriendModel> _suggestedFriends = [];
  bool _isLoading = false;

  List<SuggestedFriendModel> get suggestedFriends => _suggestedFriends;

  bool get isLoading => _isLoading;

  RecentLikesViewModel({required SuggestedFriendsRepository repository}) : _repository = repository {
    fetchSuggestedFriends();
  }

  Future<void> fetchSuggestedFriends() async {
    final result = await _repository.loadRecentLikes();
    switch (result) {
      case Ok<List<SuggestedFriendModel>> ok:
        _suggestedFriends = ok.value;
        break;
      case Error error:
        debugPrint('Error fetching recent likes: ${error.error}');
        break;
    }
  }

  Future<void> likeUser(int userId) async {
    final result = await _repository.likeUser(userId);
    if (result is Error) {
      debugPrint('Error liking user: ${result.error}');
    } else {
      _suggestedFriends.removeWhere((f) => f.id == userId);
      notifyListeners();
    }
  }

  Future<void> dislikeUser(int userId) async {
    final result = await _repository.dislikeUser(userId);
    if (result is Error) {
      debugPrint('Error disliking user: ${result.error}');
    } else {
      _suggestedFriends.removeWhere((f) => f.id == userId);
      notifyListeners();
    }
  }
}
