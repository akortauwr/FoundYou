
import 'package:freezed_annotation/freezed_annotation.dart';


part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
abstract class MessageModel  with _$MessageModel {
  // final String id;
  // final String senderId;
  // final String receiverId;
  // final String content;
  // final DateTime timestamp;
  //
  // MessageModel({
  //   required this.id,
  //   required this.senderId,
  //   required this.receiverId,
  //   required this.content,
  //   required this.timestamp,
  // });
  const factory MessageModel({
    required String id,
    required String senderId,
    required String receiverId,
    required String content,
    required DateTime timestamp,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, Object?> json) =>
      _$MessageModelFromJson(json);
}