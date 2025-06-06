import 'package:found_you_app/domain/models/message_model/message_model.dart';
import 'package:found_you_app/domain/models/suggested_friend/suggested_friend_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_model.freezed.dart';
part 'chat_model.g.dart';

@freezed
abstract class ChatModel  with _$ChatModel {
  const factory ChatModel({
    required int id,
    required SuggestedFriendModel member,
    @JsonKey(name: 'newest_message')  required MessageModel? newestMessage,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, Object?> json) =>
      _$ChatModelFromJson(json);
}


