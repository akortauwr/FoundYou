// presentation/viewmodels/new_matches_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:found_you_app/domain/models/suggested_friend/suggested_friend_model.dart'; // Adjust path as needed

class NewMatchesViewModel extends ChangeNotifier {
  List<SuggestedFriendModel> _suggestedFriends = [];
  bool _isLoading = false;

  List<SuggestedFriendModel> get suggestedFriends => _suggestedFriends;
  bool get isLoading => _isLoading;

  NewMatchesViewModel() {
    fetchSuggestedFriends();
  }

  Future<void> fetchSuggestedFriends() async {
    _isLoading = true;
    notifyListeners();

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Dummy Data
    _suggestedFriends = List.generate(
      10,
          (index) => SuggestedFriendModel(
        id: index,
        username: 'User $index',
        sex: index % 2 == 0 ? 'Male' : 'Female',
        bio: 'This is a cool bio for User $index. Loves Flutter and Neobrutalism!',
        age: 20 + index,
        passions: ['Coding', 'Music', index % 3 == 0 ? 'Art' : 'Sports'],
        imageUrl: 'https://picsum.photos/seed/${index + 1}/200', // Placeholder image URL
      ),
    );

    _isLoading = false;
    notifyListeners();
  }
}