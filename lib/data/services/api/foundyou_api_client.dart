import 'package:dio/dio.dart';
import 'package:found_you_app/data/services/api/api_client.dart';
import 'package:found_you_app/domain/models/friend_model/friend_model.dart';
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
      print('response tutaj : $response');
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

}
