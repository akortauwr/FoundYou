

import 'package:found_you_app/domain/models/chat_model/chat_model.dart';
import 'package:found_you_app/domain/models/message_model/message_model.dart';
import 'package:found_you_app/utils/result.dart';

abstract class MessengerRepository {

  Future<Result<void>> createChat(
    int userId,
  );

  /// Loads the list of chats.
  Future<Result<List<ChatModel>>> loadChats();

  /// Loads the messages for a specific chat.
  Future<Result<List<MessageModel>>> loadMessages(int chatId);

  /// Sends a message in a specific chat.
  Future<Result<void>> sendMessage(
    int chatId,
    String content,
  );

  Future<Result<List<MessageModel>>> pullMessages(
    int chatId,
    DateTime lastMessageTime,
  );

  Future<Result<List<MessageModel>>> loadOldMessages(
    int chatId,
    DateTime lastMessageTime,
  );

}