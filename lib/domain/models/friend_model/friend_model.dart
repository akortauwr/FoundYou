import 'package:freezed_annotation/freezed_annotation.dart';

part 'friend_model.freezed.dart';
part 'friend_model.g.dart';

@freezed
abstract class FriendModel with _$FriendModel {
  const factory FriendModel({
    required String username,
    required String sex,
    required String bio,
    required int age,
    required String imageUrl,
  }) = _FriendModel;

  factory FriendModel.fromJson(Map<String, Object?> json) =>
      _$FriendModelFromJson(json);
}