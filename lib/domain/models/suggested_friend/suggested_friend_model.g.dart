// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suggested_friend_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SuggestedFriendModel _$SuggestedFriendModelFromJson(
  Map<String, dynamic> json,
) => _SuggestedFriendModel(
  id: (json['id'] as num).toInt(),
  username: json['username'] as String,
  sex: json['sex'] as String,
  bio: json['bio'] as String,
  age: (json['age'] as num).toInt(),
  passions:
      (json['passions'] as List<dynamic>).map((e) => e as String).toList(),
  imageUrl: json['image_url'] as String?,
);

Map<String, dynamic> _$SuggestedFriendModelToJson(
  _SuggestedFriendModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'sex': instance.sex,
  'bio': instance.bio,
  'age': instance.age,
  'passions': instance.passions,
  'image_url': instance.imageUrl,
};
