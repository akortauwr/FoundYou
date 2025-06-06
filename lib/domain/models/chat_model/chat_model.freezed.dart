// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatModel {

 int get id; SuggestedFriendModel get member;@JsonKey(name: 'newest_message') MessageModel? get newestMessage;
/// Create a copy of ChatModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatModelCopyWith<ChatModel> get copyWith => _$ChatModelCopyWithImpl<ChatModel>(this as ChatModel, _$identity);

  /// Serializes this ChatModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatModel&&(identical(other.id, id) || other.id == id)&&(identical(other.member, member) || other.member == member)&&(identical(other.newestMessage, newestMessage) || other.newestMessage == newestMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,member,newestMessage);

@override
String toString() {
  return 'ChatModel(id: $id, member: $member, newestMessage: $newestMessage)';
}


}

/// @nodoc
abstract mixin class $ChatModelCopyWith<$Res>  {
  factory $ChatModelCopyWith(ChatModel value, $Res Function(ChatModel) _then) = _$ChatModelCopyWithImpl;
@useResult
$Res call({
 int id, SuggestedFriendModel member,@JsonKey(name: 'newest_message') MessageModel? newestMessage
});


$SuggestedFriendModelCopyWith<$Res> get member;$MessageModelCopyWith<$Res>? get newestMessage;

}
/// @nodoc
class _$ChatModelCopyWithImpl<$Res>
    implements $ChatModelCopyWith<$Res> {
  _$ChatModelCopyWithImpl(this._self, this._then);

  final ChatModel _self;
  final $Res Function(ChatModel) _then;

/// Create a copy of ChatModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? member = null,Object? newestMessage = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,member: null == member ? _self.member : member // ignore: cast_nullable_to_non_nullable
as SuggestedFriendModel,newestMessage: freezed == newestMessage ? _self.newestMessage : newestMessage // ignore: cast_nullable_to_non_nullable
as MessageModel?,
  ));
}
/// Create a copy of ChatModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SuggestedFriendModelCopyWith<$Res> get member {
  
  return $SuggestedFriendModelCopyWith<$Res>(_self.member, (value) {
    return _then(_self.copyWith(member: value));
  });
}/// Create a copy of ChatModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageModelCopyWith<$Res>? get newestMessage {
    if (_self.newestMessage == null) {
    return null;
  }

  return $MessageModelCopyWith<$Res>(_self.newestMessage!, (value) {
    return _then(_self.copyWith(newestMessage: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _ChatModel implements ChatModel {
  const _ChatModel({required this.id, required this.member, @JsonKey(name: 'newest_message') required this.newestMessage});
  factory _ChatModel.fromJson(Map<String, dynamic> json) => _$ChatModelFromJson(json);

@override final  int id;
@override final  SuggestedFriendModel member;
@override@JsonKey(name: 'newest_message') final  MessageModel? newestMessage;

/// Create a copy of ChatModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatModelCopyWith<_ChatModel> get copyWith => __$ChatModelCopyWithImpl<_ChatModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatModel&&(identical(other.id, id) || other.id == id)&&(identical(other.member, member) || other.member == member)&&(identical(other.newestMessage, newestMessage) || other.newestMessage == newestMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,member,newestMessage);

@override
String toString() {
  return 'ChatModel(id: $id, member: $member, newestMessage: $newestMessage)';
}


}

/// @nodoc
abstract mixin class _$ChatModelCopyWith<$Res> implements $ChatModelCopyWith<$Res> {
  factory _$ChatModelCopyWith(_ChatModel value, $Res Function(_ChatModel) _then) = __$ChatModelCopyWithImpl;
@override @useResult
$Res call({
 int id, SuggestedFriendModel member,@JsonKey(name: 'newest_message') MessageModel? newestMessage
});


@override $SuggestedFriendModelCopyWith<$Res> get member;@override $MessageModelCopyWith<$Res>? get newestMessage;

}
/// @nodoc
class __$ChatModelCopyWithImpl<$Res>
    implements _$ChatModelCopyWith<$Res> {
  __$ChatModelCopyWithImpl(this._self, this._then);

  final _ChatModel _self;
  final $Res Function(_ChatModel) _then;

/// Create a copy of ChatModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? member = null,Object? newestMessage = freezed,}) {
  return _then(_ChatModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,member: null == member ? _self.member : member // ignore: cast_nullable_to_non_nullable
as SuggestedFriendModel,newestMessage: freezed == newestMessage ? _self.newestMessage : newestMessage // ignore: cast_nullable_to_non_nullable
as MessageModel?,
  ));
}

/// Create a copy of ChatModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SuggestedFriendModelCopyWith<$Res> get member {
  
  return $SuggestedFriendModelCopyWith<$Res>(_self.member, (value) {
    return _then(_self.copyWith(member: value));
  });
}/// Create a copy of ChatModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageModelCopyWith<$Res>? get newestMessage {
    if (_self.newestMessage == null) {
    return null;
  }

  return $MessageModelCopyWith<$Res>(_self.newestMessage!, (value) {
    return _then(_self.copyWith(newestMessage: value));
  });
}
}

// dart format on
