// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'form_field_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FormFieldModel implements DiagnosticableTreeMixin {

 String get name; String get label; FormFieldType get type; List<FormFieldOption> get options;
/// Create a copy of FormFieldModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormFieldModelCopyWith<FormFieldModel> get copyWith => _$FormFieldModelCopyWithImpl<FormFieldModel>(this as FormFieldModel, _$identity);

  /// Serializes this FormFieldModel to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'FormFieldModel'))
    ..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('label', label))..add(DiagnosticsProperty('type', type))..add(DiagnosticsProperty('options', options));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormFieldModel&&(identical(other.name, name) || other.name == name)&&(identical(other.label, label) || other.label == label)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.options, options));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,label,type,const DeepCollectionEquality().hash(options));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'FormFieldModel(name: $name, label: $label, type: $type, options: $options)';
}


}

/// @nodoc
abstract mixin class $FormFieldModelCopyWith<$Res>  {
  factory $FormFieldModelCopyWith(FormFieldModel value, $Res Function(FormFieldModel) _then) = _$FormFieldModelCopyWithImpl;
@useResult
$Res call({
 String name, String label, FormFieldType type, List<FormFieldOption> options
});




}
/// @nodoc
class _$FormFieldModelCopyWithImpl<$Res>
    implements $FormFieldModelCopyWith<$Res> {
  _$FormFieldModelCopyWithImpl(this._self, this._then);

  final FormFieldModel _self;
  final $Res Function(FormFieldModel) _then;

/// Create a copy of FormFieldModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? label = null,Object? type = null,Object? options = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FormFieldType,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<FormFieldOption>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _FormFieldModel with DiagnosticableTreeMixin implements FormFieldModel {
  const _FormFieldModel({required this.name, required this.label, required this.type, final  List<FormFieldOption> options = const []}): _options = options;
  factory _FormFieldModel.fromJson(Map<String, dynamic> json) => _$FormFieldModelFromJson(json);

@override final  String name;
@override final  String label;
@override final  FormFieldType type;
 final  List<FormFieldOption> _options;
@override@JsonKey() List<FormFieldOption> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}


/// Create a copy of FormFieldModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FormFieldModelCopyWith<_FormFieldModel> get copyWith => __$FormFieldModelCopyWithImpl<_FormFieldModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormFieldModelToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'FormFieldModel'))
    ..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('label', label))..add(DiagnosticsProperty('type', type))..add(DiagnosticsProperty('options', options));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FormFieldModel&&(identical(other.name, name) || other.name == name)&&(identical(other.label, label) || other.label == label)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._options, _options));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,label,type,const DeepCollectionEquality().hash(_options));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'FormFieldModel(name: $name, label: $label, type: $type, options: $options)';
}


}

/// @nodoc
abstract mixin class _$FormFieldModelCopyWith<$Res> implements $FormFieldModelCopyWith<$Res> {
  factory _$FormFieldModelCopyWith(_FormFieldModel value, $Res Function(_FormFieldModel) _then) = __$FormFieldModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String label, FormFieldType type, List<FormFieldOption> options
});




}
/// @nodoc
class __$FormFieldModelCopyWithImpl<$Res>
    implements _$FormFieldModelCopyWith<$Res> {
  __$FormFieldModelCopyWithImpl(this._self, this._then);

  final _FormFieldModel _self;
  final $Res Function(_FormFieldModel) _then;

/// Create a copy of FormFieldModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? label = null,Object? type = null,Object? options = null,}) {
  return _then(_FormFieldModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FormFieldType,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<FormFieldOption>,
  ));
}


}


/// @nodoc
mixin _$FormFieldOption implements DiagnosticableTreeMixin {

 String get name; dynamic get value;
/// Create a copy of FormFieldOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormFieldOptionCopyWith<FormFieldOption> get copyWith => _$FormFieldOptionCopyWithImpl<FormFieldOption>(this as FormFieldOption, _$identity);

  /// Serializes this FormFieldOption to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'FormFieldOption'))
    ..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('value', value));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormFieldOption&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.value, value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(value));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'FormFieldOption(name: $name, value: $value)';
}


}

/// @nodoc
abstract mixin class $FormFieldOptionCopyWith<$Res>  {
  factory $FormFieldOptionCopyWith(FormFieldOption value, $Res Function(FormFieldOption) _then) = _$FormFieldOptionCopyWithImpl;
@useResult
$Res call({
 String name, dynamic value
});




}
/// @nodoc
class _$FormFieldOptionCopyWithImpl<$Res>
    implements $FormFieldOptionCopyWith<$Res> {
  _$FormFieldOptionCopyWithImpl(this._self, this._then);

  final FormFieldOption _self;
  final $Res Function(FormFieldOption) _then;

/// Create a copy of FormFieldOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? value = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _FormFieldOption with DiagnosticableTreeMixin implements FormFieldOption {
  const _FormFieldOption({required this.name, required this.value});
  factory _FormFieldOption.fromJson(Map<String, dynamic> json) => _$FormFieldOptionFromJson(json);

@override final  String name;
@override final  dynamic value;

/// Create a copy of FormFieldOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FormFieldOptionCopyWith<_FormFieldOption> get copyWith => __$FormFieldOptionCopyWithImpl<_FormFieldOption>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormFieldOptionToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'FormFieldOption'))
    ..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('value', value));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FormFieldOption&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.value, value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(value));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'FormFieldOption(name: $name, value: $value)';
}


}

/// @nodoc
abstract mixin class _$FormFieldOptionCopyWith<$Res> implements $FormFieldOptionCopyWith<$Res> {
  factory _$FormFieldOptionCopyWith(_FormFieldOption value, $Res Function(_FormFieldOption) _then) = __$FormFieldOptionCopyWithImpl;
@override @useResult
$Res call({
 String name, dynamic value
});




}
/// @nodoc
class __$FormFieldOptionCopyWithImpl<$Res>
    implements _$FormFieldOptionCopyWith<$Res> {
  __$FormFieldOptionCopyWithImpl(this._self, this._then);

  final _FormFieldOption _self;
  final $Res Function(_FormFieldOption) _then;

/// Create a copy of FormFieldOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? value = freezed,}) {
  return _then(_FormFieldOption(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

// dart format on
