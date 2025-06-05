// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => _ChatModel(
  friend:
      (json['friend'] as List<dynamic>)
          .map((e) => SuggestedFriendModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  lastMessage: MessageModel.fromJson(
    json['lastMessage'] as Map<String, dynamic>,
  ),
  lastMessageTime: DateTime.parse(json['lastMessageTime'] as String),
);

Map<String, dynamic> _$ChatModelToJson(_ChatModel instance) =>
    <String, dynamic>{
      'friend': instance.friend,
      'lastMessage': instance.lastMessage,
      'lastMessageTime': instance.lastMessageTime.toIso8601String(),
    };
