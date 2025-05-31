import 'dart:async';
import 'package:found_you_app/data/repositories/friends/friend_repository.dart';
import 'package:found_you_app/domain/models/friend_model/dev_friend_model.dart';
import 'package:found_you_app/utils/result.dart';
import 'package:found_you_app/domain/models/friend_model/friend_model.dart';

/// Repozytorium „mockowe” – zwraca generowane sztucznie profile
/// z małym opóźnieniem tak, aby zasymulować prawdziwe wywołania sieci.
class DevFriendRepository {
  int _currentPage = 0;
  final int _pageSize;
  final List<DevFriendModel> _loadedFriends = [];

  DevFriendRepository({int pageSize = 5}) : _pageSize = pageSize;

  /// Pobiera pierwszą stronę mockowych danych.
  Future<Result<List<DevFriendModel>>> loadInitialFriends() async {
    _currentPage = 1;
    _loadedFriends.clear();

    // symulujemy opóźnienie sieci
    await Future.delayed(const Duration(milliseconds: 500));

    // generujemy _pageSize_ profili
    final newBatch = List<DevFriendModel>.generate(_pageSize, (i) {
      final id = _currentPage * 100 + i;
      return DevFriendModel(
        id: id,
        name: 'Mock User #$id',
        age: 20 + (id % 10),
        imageUrl: 'https://via.placeholder.com/300?text=User+$id',
      );
    });

    _loadedFriends.addAll(newBatch);
    return Result.ok(List<DevFriendModel>.from(_loadedFriends));
  }

  /// Pobiera kolejną stronę mockowych danych.
  Future<Result<List<DevFriendModel>>> loadMoreFriends() async {
    _currentPage += 1;
    await Future.delayed(const Duration(milliseconds: 500));

    final newBatch = List<DevFriendModel>.generate(_pageSize, (i) {
      final id = _currentPage * 100 + i;
      return DevFriendModel(
        id: id,
        name: 'Mock User #$id',
        age: 20 + (id % 10),
        imageUrl: 'https://via.placeholder.com/300?text=User+$id',
      );
    });

    // unikamy duplikatów na wszelki wypadek
    for (var friend in newBatch) {
      if (!_loadedFriends.any((f) => f.id == friend.id)) {
        _loadedFriends.add(friend);
      }
    }

    return Result.ok(List<DevFriendModel>.from(_loadedFriends));
  }

  /// Zwraca bieżący bufor.
  List<DevFriendModel> getLoadedFriends() =>
      List<DevFriendModel>.from(_loadedFriends);

  /// Usuwa profil z bufora (np. po „swipe”).
  void removeFriend(DevFriendModel friend) {
    _loadedFriends.removeWhere((f) => f.id == friend.id);
  }

  @override
  Future<Result<FriendModel>> getFriendDetails(int friendId) {
    // TODO: implement getFriendDetails
    throw UnimplementedError();
  }
}
