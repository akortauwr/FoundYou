
import 'package:freezed_annotation/freezed_annotation.dart';


part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
abstract class MessageModel  with _$MessageModel {
  const factory MessageModel({
    required int id,
    required int senderId,
    required String content,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, Object?> json) =>
      _$MessageModelFromJson(json);
}