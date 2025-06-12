
import 'package:flutter/material.dart';
import 'package:found_you_app/data/repositories/messenger/messenger_repository.dart';
import 'package:found_you_app/domain/models/chat_model/chat_model.dart';
import 'package:found_you_app/utils/result.dart';

class ChatsViewModel extends ChangeNotifier{
  final MessengerRepository _messengerRepository;
  final List<ChatModel> _chats = [];
  List<ChatModel> get chats => List.unmodifiable(_chats);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ChatsViewModel({required MessengerRepository messengerRepository})
      : _messengerRepository = messengerRepository {
    _loadChats();
  }

  Future<void> _loadChats() async {
    _isLoading = true;
    notifyListeners();
    final result = await _messengerRepository.loadChats();
    switch (result) {
      case Ok<List<ChatModel>> ok:
        _chats.clear();
        _chats.addAll(ok.value);
        notifyListeners();
        break;
      case Error error:
        // Handle error, e.g., show a snackbar or dialog
        debugPrint('Error loading chats: ${error.error}');
        // You can also notify listeners if you want to update the UI
        break;
    }
    _isLoading = false;
    notifyListeners();
  }
}