import 'package:freezed_annotation/freezed_annotation.dart';

part 'suggested_friend_model.freezed.dart';
part 'suggested_friend_model.g.dart';

@freezed
abstract class SuggestedFriendModel with _$SuggestedFriendModel {
  const factory SuggestedFriendModel({
    required int id,
    required String username,
    required String sex,
    required String bio,
    required int age,
    required List<String> passions,
    @JsonKey(name: 'image_url') required String? imageUrl,
  }) = _SuggestedFriendModel;

  factory SuggestedFriendModel.fromJson(Map<String, Object?> json) => _$SuggestedFriendModelFromJson(json);
}
