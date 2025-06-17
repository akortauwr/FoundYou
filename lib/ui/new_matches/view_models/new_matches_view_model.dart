import 'dart:async';

import 'package:flutter/material.dart';
import 'package:found_you_app/data/repositories/messenger/messenger_repository.dart';
import 'package:found_you_app/data/repositories/suggested_friends/suggested_friends_repository.dart';
import 'package:found_you_app/domain/models/chat_model/chat_model.dart';
import 'package:found_you_app/domain/models/suggested_friend/suggested_friend_model.dart';
import 'package:found_you_app/utils/result.dart';

sealed class NewMatchesNavigationEvent {}

class NavigateToChat extends NewMatchesNavigationEvent {
  final ChatModel chat;
  final SuggestedFriendModel user;

  NavigateToChat({required this.chat, required this.user});
}

class NewMatchesViewModel extends ChangeNotifier {
  final SuggestedFriendsRepository _repository;
  final MessengerRepository _messengerRepository;

  List<SuggestedFriendModel> _suggestedFriends = [];
  bool _isLoading = false;

  bool _isCreatingChat = false;

  final _navigationController = StreamController<NewMatchesNavigationEvent>.broadcast();

  Stream<NewMatchesNavigationEvent> get navigationEvents => _navigationController.stream;

  List<SuggestedFriendModel> get suggestedFriends => _suggestedFriends;

  bool get isLoading => _isLoading;

  bool get isCreatingChat => _isCreatingChat;

  NewMatchesViewModel({
    required SuggestedFriendsRepository repository,
    required MessengerRepository messengerRepository,
  }) : _repository = repository,
       _messengerRepository = messengerRepository {
    fetchSuggestedFriends();
  }

  @override
  void dispose() {
    _navigationController.close();
    super.dispose();
  }

  Future<void> fetchSuggestedFriends() async {

    final result = await _repository.loadNewMatches();

    switch (result) {
      case Ok<List<SuggestedFriendModel>> ok:
        _suggestedFriends = ok.value;
        break;
      case Error error:
        debugPrint('Error fetching new matches: ${error.error}');
        break;
    }
  }

  Future<void> selectFriend(SuggestedFriendModel friend) async {
    _isCreatingChat = true;
    notifyListeners();

    final result = await _messengerRepository.createChat(friend.id);

    _isCreatingChat = false;
    notifyListeners();

    if (result is Ok<ChatModel>) {
      await Future.delayed(const Duration(milliseconds: 50));
      _navigationController.add(NavigateToChat(chat: result.value, user: friend));
    } else if (result is Error) {
      debugPrint('Error creating chat: $result');
    }
  }
}
