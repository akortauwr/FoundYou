// presentation/viewmodels/home_view_model.dart
import 'package:flutter/material.dart';
import 'package:found_you_app/ui/near_you/view_models/near_you_view_model.dart';
import 'package:found_you_app/ui/new_matches/view_models/new_matches_view_model.dart';
import 'package:found_you_app/ui/recent_likes/view_models/recent_likes_view_model.dart';

class HomeViewModel extends ChangeNotifier {
  final NewMatchesViewModel newMatchesVM;
  final RecentLikesViewModel recentLikesVM;
  final NearYouViewModel nearYouVM;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  HomeViewModel({
    required this.newMatchesVM,
    required this.recentLikesVM,
    required this.nearYouVM,
  }) {
    // Zakładamy, że pod-WM-y od razu rozpoczynają fetchSuggestedFriends w konstruktorach.
    // Nasłuchujemy na zmiany ich stanów isLoading, by ustalić zbiorczy stan.
    newMatchesVM.addListener(_updateLoading);
    recentLikesVM.addListener(_updateLoading);
    nearYouVM.addListener(_updateLoading);
    _updateLoading(); // sprawdź od razu, czy któryś VM nie jest już załadowany
  }

  void _updateLoading() {
    // Home jest loading, dopóki choć jeden z pod-WM-ów ma isLoading == true
    _isLoading = newMatchesVM.isLoading ||
        recentLikesVM.isLoading ||
        nearYouVM.isLoading;
    notifyListeners();
  }

  @override
  void dispose() {
    newMatchesVM.removeListener(_updateLoading);
    recentLikesVM.removeListener(_updateLoading);
    nearYouVM.removeListener(_updateLoading);
    super.dispose();
  }
}
