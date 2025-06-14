import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  @JsonSerializable(checked: true)
  const factory UserModel({
    required int id,
    required String email,
    required String username,
    required String birthday,
    required String bio,

    @JsonKey(name: 'image_url') String? imageUrl,

    required List<String> passions,

    @JsonKey(name: 'created_at') required DateTime createdAt,

    @JsonKey(name: 'match_count') required int friendCount,

    required String sex,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}
