import 'package:dio/dio.dart';
import 'package:found_you_app/data/services/api/api_client.dart';
import 'package:found_you_app/domain/models/chat_model/chat_model.dart';
import 'package:found_you_app/domain/models/friend_model/friend_model.dart';
import 'package:found_you_app/domain/models/message_model/message_model.dart';
import 'package:found_you_app/domain/models/suggested_friend/suggested_friend_model.dart';
import 'package:found_you_app/domain/models/user_model/user_model.dart';
import 'package:found_you_app/network/dio_client.dart';
import 'package:found_you_app/utils/result.dart';

class FoundYouApiClient {
  final ApiClient apiClient;

  FoundYouApiClient({ApiClient? apiClient}) : apiClient = apiClient ?? ApiClient();

  Future<Result<FriendModel>> getFriendDetails(int friendId) async {
    final result = await apiClient.get('/api/users/$friendId/');
    switch (result) {
      case Ok<Map<String, dynamic>>():
        return Result.ok(FriendModel.fromJson(result.value));
      default:
        return Result.error(result.error);
    }
  }

  Future<Result<List<int>>> getFriendsIds() async {
    return Result.ok([1, 2, 3, 4, 5]);
  }

  Future<Result<UserModel>> getProfile() async {
   try{
      final response = await apiClient.get('/api/me/');

      return Result.ok(UserModel.fromJson(response));
   }
    on DioException catch (e){
        return Result.error(e);
    } catch (e) {
        return Result.error(Exception('Unknown error: $e'));
    }
  }

  // Future<Result<List<SuggestedFriendModel>>> getSuggestedFriends() async {
  //   final result = await apiClient.get<Map<String, dynamic>>('/api/me/suggested-friends/',
  //       queryParameters: {
  //         'method': 'knn',
  //       });
  //   switch (result) {
  //     case Ok<Map<String,dynamic>>():
  //       return Result.ok(result.value["suggested_friends"].map((e) => SuggestedFriendModel.fromJson(e)).toList());
  //     default:
  //       return Result.error(result.error);
  //   }
  // }
  Future<Result<List<SuggestedFriendModel>>> getSuggestedFriends({
    String method = 'xgb',
  }) async {
    try {
      // 1) Pobierz surowe JSON-y
      final json = await apiClient.get<Map<String, dynamic>>(
        '/api/suggested-friends/',
        queryParameters: {'method': method},
      );
      // 2) Rozparsuj listę
      final friends = (json['suggested_friends'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map(SuggestedFriendModel.fromJson)
          .toList();
      // 3) Zwróć OK
      return Result.ok(friends);
    } catch (e, st) {
      // 4) Zwróć błąd jako Result.error
      return Result.error(
        Exception('Nie udało się pobrać sugerowanych znajomych: $e\n$st'),
      );
    }
  }

  Future<Result<List<SuggestedFriendModel>>> getNearYou() async {
    try {
      final response = await apiClient.get('/api/suggested-friends/near-you/');
      if (response is List) {
        final friends = response.map((e) => SuggestedFriendModel.fromJson(e)).toList();
        return Result.ok(friends);
      } else {
        return Result.error(Exception('Invalid response format'));
      }
    } catch (e) {
      return Result.error(Exception('Nie udało się pobrać znajomych w pobliżu: $e'));
    }
  }

  Future<Result<List<SuggestedFriendModel>>> getNewMatches() async {
    try {
      final response = await apiClient.get('/api/suggested-friends/matches/');
      if (response is List) {
        final friends = response.map((e) => SuggestedFriendModel.fromJson(e['matched_user'])).toList();
        return Result.ok(friends);
      } else {
        return Result.error(Exception('Invalid response format'));
      }
    } catch (e) {
      return Result.error(Exception('Nie udało się pobrać nowych znajomych: $e'));
    }
  }

  Future<Result<List<SuggestedFriendModel>>> getRecentLikes() async {
    try {
      final response = await apiClient.get('/api/suggested-friends/recent-likes/');
      if (response is List) {
        final friends = response.map((e) => SuggestedFriendModel.fromJson(e)).toList();
        return Result.ok(friends);
      } else {
        return Result.error(Exception('Invalid response format'));
      }
    } catch (e) {
      return Result.error(Exception('Nie udało się pobrać ostatnich polubień: $e'));
    }
  }



  Future<Result<void>> likeUser(int userId) async {
    try {
      await apiClient.post('/api/suggested-friends/like/$userId/', {});
      return Result.ok(null);
    } on DioException catch (e) {
      return Result.error(Exception('Nie udało się polubić użytkownika: ${e.message}'));
    } catch (e) {
      return Result.error(Exception('Nie udało się polubić użytkownika: $e'));
    }
  }


  Future<Result<void>> dislikeUser(int userId) async {
    try {
      await apiClient.post('/api/suggested-friends/reject/$userId/', {});
      return Result.ok(null);
    } on DioException catch (e) {
      return Result.error(
        Exception('Nie udało się odrzucić użytkownika: ${e.message}'),
      );
    } catch (e) {
      return Result.error(
        Exception('Nie udało się odrzucić użytkownika: $e'),
      );
    }
  }

  Future<Result<List<ChatModel>>> getChats() async {
  try {
      final response = await apiClient.get('/api/private-chat/');
      if (response is List) {
        final chats = response.map((e) => ChatModel.fromJson(e)).toList();
        return Result.ok(chats);
      } else {
        return Result.error(Exception('Invalid response format'));
      }
    } catch (e) {
      return Result.error(Exception('Nie udało się pobrać czatów: $e'));
    }
  }

  Future<Result<List<MessageModel>>> getMessages(int chatId, DateTime? lastMessageTime) async {
    try {
      final queryParameters = lastMessageTime != null
          ? {'before': lastMessageTime.toIso8601String()}
          : null;
      final response = await apiClient.get('/api/private-chat/$chatId/messages/', queryParameters: queryParameters);
      if (response is List) {
        final messages = response.map((e) => MessageModel.fromJson(e)).toList();
        return Result.ok(messages);
      } else {
        return Result.error(Exception('Invalid response format'));
      }
    } catch (e) {
      return Result.error(Exception('Nie udało się pobrać wiadomości: $e'));
    }
  }

  Future<Result<List<MessageModel>>> pullMessages(
    int chatId,
    DateTime lastMessageTime,
  ) async {
    try {
      final queryParameters = {'last_check': lastMessageTime.toIso8601String()};
      final response = await apiClient.get('/api/private-chat/$chatId/messages/', queryParameters: queryParameters);
      if (response is List) {
        final messages = response.map((e) => MessageModel.fromJson(e)).toList();
        return Result.ok(messages);
      } else {
        return Result.error(Exception('Invalid response format'));
      }
    } catch (e) {
      return Result.error(Exception('Nie udało się pobrać wiadomości: $e'));
    }
  }

  Future<Result<MessageModel>> sendMessage(
    int chatId,
    String content,
  ) async {
    try {
      final response = await apiClient.post(
        '/api/private-chat/$chatId/messages/',
        {'content': content},
      );
     return Result.ok(MessageModel.fromJson(response));
    } catch (e) {
      return Result.error(Exception('Nie udało się wysłać wiadomości: $e'));
    }
  }

  Future<Result<void>> createChat(int userId) async {
    try {
      await apiClient.post('/api/chats/', {'user_id': userId});
      return Result.ok(null);
    } catch (e) {
      return Result.error(Exception('Nie udało się utworzyć czatu: $e'));
    }
  }


}
