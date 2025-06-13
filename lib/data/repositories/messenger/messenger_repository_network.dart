import 'package:found_you_app/data/repositories/messenger/messenger_repository.dart';
import 'package:found_you_app/data/services/api/foundyou_api_client.dart';
import 'package:found_you_app/domain/models/chat_model/chat_model.dart';
import 'package:found_you_app/domain/models/message_model/message_model.dart';
import 'package:found_you_app/utils/result.dart';

class MessengerRepositoryNetwork extends MessengerRepository {
  final FoundYouApiClient apiClient;

  MessengerRepositoryNetwork({required this.apiClient});

  @override
  Future<Result<ChatModel>> createChat(int userId) {
    return apiClient.createChat(userId);
  }

  @override
  Future<Result<List<ChatModel>>> loadChats() {
    return apiClient.getChats();
  }

  @override
  Future<Result<List<MessageModel>>> loadMessages(int chatId) {
    return apiClient.getMessages(chatId, null);
  }

  @override
  Future<Result<List<MessageModel>>> loadOldMessages(int chatId, DateTime lastMessageTime) {
    return apiClient.getMessages(chatId, lastMessageTime);
  }

  @override
  Future<Result<List<MessageModel>>> pullMessages(int chatId, DateTime lastMessageTime) {
    return apiClient.pullMessages(chatId, lastMessageTime);
  }

  @override
  Future<Result<MessageModel>> sendMessage(int chatId, String content) {
    return apiClient.sendMessage(chatId, content);
  }
}
