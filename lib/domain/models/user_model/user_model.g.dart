// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_UserModel',
  json,
  ($checkedConvert) {
    final val = _UserModel(
      id: $checkedConvert('id', (v) => (v as num).toInt()),
      email: $checkedConvert('email', (v) => v as String),
      username: $checkedConvert('username', (v) => v as String),
      birthday: $checkedConvert('birthday', (v) => v as String),
      bio: $checkedConvert('bio', (v) => v as String),
      imageUrl: $checkedConvert('image_url', (v) => v as String?),
      passions: $checkedConvert(
        'passions',
        (v) => (v as List<dynamic>).map((e) => e as String).toList(),
      ),
      createdAt: $checkedConvert(
        'created_at',
        (v) => DateTime.parse(v as String),
      ),
      friendCount: $checkedConvert('match_count', (v) => (v as num).toInt()),
      sex: $checkedConvert('sex', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'imageUrl': 'image_url',
    'createdAt': 'created_at',
    'friendCount': 'match_count',
  },
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'username': instance.username,
      'birthday': instance.birthday,
      'bio': instance.bio,
      'image_url': instance.imageUrl,
      'passions': instance.passions,
      'created_at': instance.createdAt.toIso8601String(),
      'match_count': instance.friendCount,
      'sex': instance.sex,
    };
