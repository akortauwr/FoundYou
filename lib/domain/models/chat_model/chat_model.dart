import 'package:found_you_app/domain/models/suggested_friend/suggested_friend_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_model.freezed.dart';
part 'chat_model.g.dart';

@freezed
abstract class ChatModel  with _$ChatModel {
  // final SuggestedFriendModel friend;
  // final String lastMessage;
  // final DateTime lastMessageTime;
  //
  // ChatConversation({
  //   required this.friend,
  //   required this.lastMessage,
  //   required this.lastMessageTime,
  // });
  const factory ChatModel({
    required SuggestedFriendModel friend,
    required String lastMessage,
    required DateTime lastMessageTime,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, Object?> json) =>
      _$ChatModelFromJson(json);
}


