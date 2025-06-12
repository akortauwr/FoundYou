// presentation/viewmodels/new_matches_viewmodel.dart
import 'dart:async'; // Potrzebne do StreamController
import 'package:flutter/material.dart';
import 'package:found_you_app/data/repositories/messenger/messenger_repository.dart';
import 'package:found_you_app/data/repositories/suggested_friends/suggested_friends_repository.dart';
import 'package:found_you_app/domain/models/chat_model/chat_model.dart';
import 'package:found_you_app/domain/models/suggested_friend/suggested_friend_model.dart';
import 'package:found_you_app/utils/result.dart';

// --- KROK 1: Zdefiniuj klasę zdarzeń nawigacyjnych (Side Effect) ---
// Użycie sealed class jest dobrą praktyką, aby obsługiwać różne typy zdarzeń w przyszłości.
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
  // --- ZMIANA 1: Dodajemy osobny stan ładowania dla akcji tworzenia czatu ---
  bool _isCreatingChat = false;

  final _navigationController = StreamController<NewMatchesNavigationEvent>.broadcast();
  Stream<NewMatchesNavigationEvent> get navigationEvents => _navigationController.stream;

  List<SuggestedFriendModel> get suggestedFriends => _suggestedFriends;
  bool get isLoading => _isLoading;
  // --- ZMIANA 2: Udostępniamy nowy stan ---
  bool get isCreatingChat => _isCreatingChat;

  NewMatchesViewModel({
    required SuggestedFriendsRepository repository,
    required MessengerRepository messengerRepository,
  })  : _repository = repository,
        _messengerRepository = messengerRepository {
    fetchSuggestedFriends();
  }

  @override
  void dispose() {
    _navigationController.close();
    super.dispose();
  }

  Future<void> fetchSuggestedFriends() async {
    _isLoading = true;
    notifyListeners();

    final result = await _repository.loadNewMatches();

    switch (result) {
      case Ok<List<SuggestedFriendModel>> ok:
        _suggestedFriends = ok.value;
        break;
      case Error error:
        debugPrint('Error fetching new matches: ${error.error}');
        break;
    }
    _isLoading = false;
    notifyListeners();
  }


  // --- ZMIANA 3: Modyfikujemy metodę selectFriend ---
  Future<void> selectFriend(SuggestedFriendModel friend) async {
    // Używamy nowego, dedykowanego stanu ładowania
    _isCreatingChat = true;
    notifyListeners();

    final result = await _messengerRepository.createChat(friend.id);

    // Wyłączamy ładowanie ZANIM wyemitujemy zdarzenie nawigacji
    _isCreatingChat = false;
    notifyListeners(); // Ważne! UI musi się przebudować, by ukryć dialog.

    // Po ukryciu wskaźnika ładowania, emitujemy zdarzenie
    if (result is Ok<ChatModel>) {
      // Dajmy UI chwilę na "oddech" i przebudowanie się przed nawigacją
      await Future.delayed(const Duration(milliseconds: 50));
      _navigationController.add(NavigateToChat(chat: result.value, user: friend));
    } else if (result is Error) {
      debugPrint('Error creating chat: ${result}');
      // Tutaj można wyemitować zdarzenie błędu do pokazania w SnackBarze
    }
  }
}