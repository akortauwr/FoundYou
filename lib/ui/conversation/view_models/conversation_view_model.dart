import 'dart:async'; // Krok 1: Importujemy bibliotekę async dla Timera

import 'package:flutter/material.dart';
import 'package:found_you_app/config/providers.dart';
import 'package:found_you_app/data/repositories/messenger/messenger_repository.dart';
import 'package:found_you_app/domain/models/message_model/message_model.dart';// Upewnij się, że masz poprawny import
import 'package:found_you_app/domain/models/suggested_friend/suggested_friend_model.dart';
import 'package:found_you_app/utils/result.dart';

class ConversationViewModel extends ChangeNotifier {
  final MessengerRepository _messengerRepository;
  late int? _currentUserId;
  final int chatId;
  final SuggestedFriendModel chatPartner;
  final List<MessageModel> _messages = [];
  bool _isLoading = false;

  // ZMIANA NR 1: Dodajemy pole do przechowywania naszego Timera
  Timer? _pollingTimer;

  List<MessageModel> get messages => List.unmodifiable(_messages);
  bool get isLoading => _isLoading;

  ConversationViewModel({required this.chatId, required MessengerRepository messengerRepository, required this.chatPartner})
      : _messengerRepository = messengerRepository {

    initMessages();
  }

  // ZMIANA NR 2: Nadpisujemy metodę dispose(), aby zatrzymać Timer
  @override
  void dispose() {
    _pollingTimer?.cancel(); // Zatrzymujemy timer, gdy ViewModel jest niszczony
    super.dispose();
  }

  bool isCurrentUser(int userId) {
    return userId == _currentUserId;
  }

  void initMessages() async {
    _isLoading = true;
    notifyListeners();

    final user = await secureStorageService.fetchUserId();

    if (user is Ok<int?>) {
      _currentUserId = user.value;
    } else {
      debugPrint('Error fetching current user ID: ${user}');
      _isLoading = false;
      notifyListeners();
      return;
    }

    final result = await _messengerRepository.loadMessages(chatId);
    if (result is Ok<List<MessageModel>>) {
      _messages.clear();
      _messages.addAll(result.value);
    } else if (result is Error) {
      debugPrint('Error loading messages: ${result}');
    }

    _isLoading = false;
    notifyListeners();

    // ZMIANA NR 3: Po załadowaniu wiadomości, uruchamiamy cykliczne odpytywanie
    _startPolling();
  }

  void _startPolling() {
    // Anuluj stary timer, jeśli istnieje, na wszelki wypadek
    _pollingTimer?.cancel();

    // Uruchom nowy timer, który co 2 sekundy wywoła metodę pullMessages
    _pollingTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      pullMessages();
    });
  }

  void sendMessage(String content) async {
    final result = await _messengerRepository.sendMessage(chatId, content);
    if (result is Ok<MessageModel>) {
      _messages.add(result.value);
      notifyListeners();
    } else if (result is Error) {
      debugPrint('Error sending message: ${result}');
    }
  }

  void loadOldMessages() async {
    if (_messages.isEmpty) return; // Nie ładuj, jeśli nie ma żadnych wiadomości

    final firstMessageTime = _messages.first.createdAt; // Czas najstarszej wiadomości
    final result = await _messengerRepository.loadOldMessages(chatId, firstMessageTime);

    if (result is Ok<List<MessageModel>>) {
      _messages.insertAll(0, result.value);
      notifyListeners();
    } else if (result is Error) {
      debugPrint('Error loading old messages: ${result}');
    }
  }

  // ZMIANA NR 4: Logika do znajdowania czasu ostatniej OTRZYMANEJ wiadomości
  DateTime? get _lastReceivedMessageTime {
    // Przeszukaj listę od końca, aby znaleźć ostatnią wiadomość NIE od bieżącego użytkownika
    try {
      final lastReceivedMessage = _messages.lastWhere((msg) => !isCurrentUser(msg.senderId));
      return lastReceivedMessage.createdAt;
    } catch (e) {
      // Jeśli nie ma żadnych otrzymanych wiadomości, zwróć czas ostatniej jakiejkolwiek wiadomości
      if (_messages.isNotEmpty) {
        return _messages.last.createdAt;
      }
      // Jeśli nie ma żadnych wiadomości, zwróć null
      return null;
    }
  }

  // ZMIANA NR 5: Poprawiona metoda pullMessages
  void pullMessages() async {
    final lastMessageTime = _lastReceivedMessageTime;

    // Nie odpytuj, jeśli nie ma żadnych wiadomości jako punktu odniesienia
    if (lastMessageTime == null) {
      return;
    }

    final result = await _messengerRepository.pullMessages(chatId, lastMessageTime);
    if (result is Ok<List<MessageModel>>) {
      if (result.value.isNotEmpty) {
        _messages.addAll(result.value);
        notifyListeners();
      }
    } else if (result is Error) {
      debugPrint('Error pulling messages: ${result}');
    }
  }
}