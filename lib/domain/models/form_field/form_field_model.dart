import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'form_field_model.freezed.dart';
part 'form_field_model.g.dart';

enum FormFieldType { textfield, radio, date, textarea, photo, select }

@freezed
abstract class FormFieldModel with _$FormFieldModel {
  const factory FormFieldModel({
    required String name,
    required String label,
    required FormFieldType type,
    @Default([]) List<FormFieldOption> options,
  }) = _FormFieldModel;

  factory FormFieldModel.fromJson(Map<String, Object?> json) =>
      _$FormFieldModelFromJson(json);
}

@freezed
abstract class FormFieldOption with _$FormFieldOption {
  const factory FormFieldOption({
    required String name,
    required dynamic value,
  }) = _FormFieldOption;

  factory FormFieldOption.fromJson(Map<String, Object?> json) =>
      _$FormFieldOptionFromJson(json);
}
