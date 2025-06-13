import 'package:found_you_app/domain/models/chat_model/chat_model.dart';
import 'package:found_you_app/domain/models/message_model/message_model.dart';
import 'package:found_you_app/utils/result.dart';

abstract class MessengerRepository {
  Future<Result<ChatModel>> createChat(int userId);

  Future<Result<List<ChatModel>>> loadChats();

  Future<Result<List<MessageModel>>> loadMessages(int chatId);

  Future<Result<MessageModel>> sendMessage(int chatId, String content);

  Future<Result<List<MessageModel>>> pullMessages(int chatId, DateTime lastMessageTime);

  Future<Result<List<MessageModel>>> loadOldMessages(int chatId, DateTime lastMessageTime);
}
