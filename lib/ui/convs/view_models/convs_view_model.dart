import 'package:flutter/material.dart';
import 'package:found_you_app/domain/models/chat_model/chat_model.dart';
import 'package:found_you_app/domain/models/message_model/message_model.dart';
import 'package:found_you_app/domain/models/suggested_friend/suggested_friend_model.dart';

class ConversationsViewModel extends ChangeNotifier {
  final List<ChatModel> _conversations = [];

  List<ChatModel> get conversations => List.unmodifiable(_conversations);

  ConversationsViewModel() {
    _loadMockConversations();
  }

  void _loadMockConversations() {
    _conversations.addAll([
      ChatModel(


        lastMessage: MessageModel(id: 1, senderId: 1, content: "dupa", createdAt: DateTime.now()),
        lastMessageTime: DateTime.now().subtract(Duration(minutes: 3)), friend: [],
      ),
      ChatModel(
        lastMessage: MessageModel(id: 1, senderId: 1, content: "dupadupa", createdAt: DateTime.now()),
        lastMessageTime: DateTime.now().subtract(Duration(minutes: 3)), friend: [],
      ),
    ]);
  }
}
