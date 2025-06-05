import 'package:flutter/foundation.dart';
import 'package:found_you_app/routing/paths.dart';

class HomeShellViewModel extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void setIndex(int i) {
    if (i == _currentIndex) return;
    _currentIndex = i;
    notifyListeners();
  }

  void setIndexByLocation(String loc) {
    final map = {
      Paths.home: 0,
      Paths.swipe: 1,
      Paths.conversations: 2,
      Paths.profile: 3,
    };
    final idx = map[loc] ?? 0;
    if (idx != _currentIndex) {
      _currentIndex = idx;
      notifyListeners();
    }
  }
}
