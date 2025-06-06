// near_you_view_model.dart

import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:found_you_app/data/repositories/suggested_friends/suggested_friends_repository.dart';
import 'package:found_you_app/domain/models/suggested_friend/suggested_friend_model.dart';
import 'package:found_you_app/utils/result.dart';

class NearYouViewModel extends ChangeNotifier {
  final SuggestedFriendsRepository _repository;
  List<SuggestedFriendModel> _suggestedFriends = [];
  bool _isLoading = false;
  final Set<int> _pendingLikes = {};

  List<SuggestedFriendModel> get suggestedFriends => UnmodifiableListView(_suggestedFriends);
  bool get isLoading => _isLoading;

  /// BARDZO WAŻNE: Konstruktor musi być PUSTY.
  /// Nie może wywoływać `fetchSuggestedFriends()`.
  /// Widok decyduje, KIEDY załadować dane.
  NearYouViewModel({required SuggestedFriendsRepository repository})
      : _repository = repository;

  Future<void> fetchSuggestedFriends() async {
    // Zabezpieczenie: nie pobieraj danych, jeśli już są lub trwa ładowanie.
    if (_suggestedFriends.isNotEmpty || _isLoading) {
      return;
    }

    _isLoading = true;
    notifyListeners();

    final result = await _repository.loadNearYou();
    if (result is Ok<List<SuggestedFriendModel>>) {
      _suggestedFriends = result.value;
    } else if (result is Error) {
      debugPrint('Error fetching suggested friends: ${result}');
    }

    _isLoading = false;
    notifyListeners();
  }

  bool isLikingUser(int userId) => _pendingLikes.contains(userId);

  // Zwracamy bool, aby widok wiedział, czy operacja się udała.
  Future<bool> likeUser(int userId) async {
    if (_pendingLikes.contains(userId)) return false;

    _pendingLikes.add(userId);
    notifyListeners();

    final result = await _repository.likeUser(userId);
    bool success = false;

    if (result is Ok<void>) {
      _suggestedFriends.removeWhere((f) => f.id == userId);
      success = true; // Operacja się udała
    } else {
      debugPrint('Error liking user: $result. User not removed.');
      success = false; // Operacja się nie udała
    }

    _pendingLikes.remove(userId);
    notifyListeners();
    return success;
  }
}