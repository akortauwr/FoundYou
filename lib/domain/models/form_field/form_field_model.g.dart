// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_field_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FormFieldModel _$FormFieldModelFromJson(Map<String, dynamic> json) =>
    _FormFieldModel(
      name: json['name'] as String,
      label: json['label'] as String,
      type: $enumDecode(_$FormFieldTypeEnumMap, json['type']),
      options:
          (json['options'] as List<dynamic>?)
              ?.map((e) => FormFieldOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$FormFieldModelToJson(_FormFieldModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'label': instance.label,
      'type': _$FormFieldTypeEnumMap[instance.type]!,
      'options': instance.options,
    };

const _$FormFieldTypeEnumMap = {
  FormFieldType.textfield: 'textfield',
  FormFieldType.radio: 'radio',
  FormFieldType.date: 'date',
  FormFieldType.textarea: 'textarea',
  FormFieldType.photo: 'photo',
  FormFieldType.select: 'select',
};

_FormFieldOption _$FormFieldOptionFromJson(Map<String, dynamic> json) =>
    _FormFieldOption(name: json['name'] as String, value: json['value']);

Map<String, dynamic> _$FormFieldOptionToJson(_FormFieldOption instance) =>
    <String, dynamic>{'name': instance.name, 'value': instance.value};
