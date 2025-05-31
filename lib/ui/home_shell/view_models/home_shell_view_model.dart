import 'package:flutter/foundation.dart';

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
      '/home': 0,
      '/swipe': 1,
      '/messages': 2,
      '/profile': 3,
    };
    final idx = map[loc] ?? 0;
    if (idx != _currentIndex) {
      _currentIndex = idx;
      notifyListeners();
    }
  }
}
