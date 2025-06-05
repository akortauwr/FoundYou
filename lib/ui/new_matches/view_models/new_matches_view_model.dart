// presentation/viewmodels/new_matches_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:found_you_app/data/repositories/suggested_friends/suggested_friends_repository.dart';
import 'package:found_you_app/domain/models/suggested_friend/suggested_friend_model.dart';
import 'package:found_you_app/utils/result.dart'; // Adjust path as needed

class NewMatchesViewModel extends ChangeNotifier {
  final SuggestedFriendsRepository _repository;
  List<SuggestedFriendModel> _suggestedFriends = [];
  bool _isLoading = false;

  List<SuggestedFriendModel> get suggestedFriends => _suggestedFriends;
  bool get isLoading => _isLoading;

  NewMatchesViewModel({required SuggestedFriendsRepository repository})
      : _repository = repository{
    fetchSuggestedFriends();
  }

  Future<void> fetchSuggestedFriends() async {
    _isLoading = true;
    notifyListeners();

    // Simulate network delay
    final result = await _repository.loadNewMatches();

    switch
    (result) {
      case Ok<List<SuggestedFriendModel>> ok:
        _suggestedFriends = ok.value;
        break;
      case Error error:
        // Handle error, e.g., show a snackbar or dialog
        debugPrint('Error fetching new matches: ${error.error}');
        // You can also notify listeners if you want to update the UI
        break;
    }

    _isLoading = false;
    notifyListeners();
  }
}