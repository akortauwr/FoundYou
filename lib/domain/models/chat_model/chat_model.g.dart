// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => _ChatModel(
  id: (json['id'] as num).toInt(),
  member: SuggestedFriendModel.fromJson(json['member'] as Map<String, dynamic>),
  newestMessage:
      json['newest_message'] == null
          ? null
          : MessageModel.fromJson(
            json['newest_message'] as Map<String, dynamic>,
          ),
);

Map<String, dynamic> _$ChatModelToJson(_ChatModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'member': instance.member,
      'newest_message': instance.newestMessage,
    };
