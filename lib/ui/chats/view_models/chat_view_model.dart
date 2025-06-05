import 'package:flutter/material.dart';
import 'package:found_you_app/domain/models/message_model/message_model.dart';

class ChatViewModel extends ChangeNotifier {
  static const int currentUserId = 1;
  final int friendId;
  final List<MessageModel> _messages = [];

  List<MessageModel> get messages => List.unmodifiable(_messages);

  ChatViewModel({required this.friendId}) {
    _loadMockMessages();
  }

  void _loadMockMessages() {
    _messages.addAll([
      MessageModel(
        id: 1,
        senderId: 1,
        content: 'Cześć!',
        createdAt: DateTime.now().subtract(Duration(minutes: 5)),
      ),
      MessageModel(
        id: 2,
        senderId: currentUserId,
        content: 'Hej, co słychać?',
        createdAt: DateTime.now().subtract(Duration(minutes: 2)),
      ),
    ]);
  }

  void sendMessage(String content) {
    final newMessage = MessageModel(
      id: 1,
      senderId: currentUserId,
      content: content,
      createdAt: DateTime.now(),
    );
    _messages.add(newMessage);
    notifyListeners();
  }
}
