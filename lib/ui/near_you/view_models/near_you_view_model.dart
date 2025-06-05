import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:found_you_app/data/repositories/suggested_friends/suggested_friends_repository.dart';
import 'package:found_you_app/domain/models/suggested_friend/suggested_friend_model.dart';
import 'package:found_you_app/domain/models/suggested_friend/suggested_friend_view_data.dart';
import 'package:found_you_app/utils/result.dart';


class NearYouViewModel extends ChangeNotifier {
  final SuggestedFriendsRepository _repository;

  final List<SuggestedFriendViewData> _items = [];
  List<SuggestedFriendViewData> get items => List.unmodifiable(_items);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  NearYouViewModel({required SuggestedFriendsRepository repository})
      : _repository = repository {
    fetchSuggestedFriends();
  }

  Future<void> fetchSuggestedFriends() async {
    _isLoading = true;
    notifyListeners();

    final Result<List<SuggestedFriendModel>> result =
    await _repository.loadRecentLikes();

    // Przykład użycia switch-case na Waszym sealed class Result<T>:
    switch (result) {
    // Gdy mamy Ok<List<SuggestedFriendModel>> z polem `value`
      case Ok<List<SuggestedFriendModel>>(:final value):
      // `value` to List<SuggestedFriendModel>
        final List<SuggestedFriendModel> fetched = value;
        _items.clear();
        _items.addAll(
          fetched.map((model) => SuggestedFriendViewData(model: model)),
        );
    // Gdy mamy Error<List<SuggestedFriendModel>> z polem `error`
      case Error<List<SuggestedFriendModel>>(:final error):
        debugPrint('Error fetching recent likes: $error');
    }

    _isLoading = false;
    notifyListeners();
  }

  void likeUser(SuggestedFriendViewData userData) {
    if (userData.isRemoving) return;

    userData.isLiked = true;
    userData.isRemoving = true;
    notifyListeners();

    Timer(const Duration(milliseconds: 300), () {
      _items.removeWhere((el) => el.model.id == userData.model.id);
      notifyListeners();
    });
  }
}
