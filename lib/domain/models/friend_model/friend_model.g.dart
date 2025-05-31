// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FriendModel _$FriendModelFromJson(Map<String, dynamic> json) => _FriendModel(
  username: json['username'] as String,
  sex: json['sex'] as String,
  bio: json['bio'] as String,
  age: (json['age'] as num).toInt(),
  imageUrl: json['imageUrl'] as String,
);

Map<String, dynamic> _$FriendModelToJson(_FriendModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'sex': instance.sex,
      'bio': instance.bio,
      'age': instance.age,
      'imageUrl': instance.imageUrl,
    };
