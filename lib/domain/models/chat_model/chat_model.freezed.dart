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

 List<SuggestedFriendModel> get friend; MessageModel get lastMessage; DateTime get lastMessageTime;
/// Create a copy of ChatModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatModelCopyWith<ChatModel> get copyWith => _$ChatModelCopyWithImpl<ChatModel>(this as ChatModel, _$identity);

  /// Serializes this ChatModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatModel&&const DeepCollectionEquality().equals(other.friend, friend)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage)&&(identical(other.lastMessageTime, lastMessageTime) || other.lastMessageTime == lastMessageTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(friend),lastMessage,lastMessageTime);

@override
String toString() {
  return 'ChatModel(friend: $friend, lastMessage: $lastMessage, lastMessageTime: $lastMessageTime)';
}


}

/// @nodoc
abstract mixin class $ChatModelCopyWith<$Res>  {
  factory $ChatModelCopyWith(ChatModel value, $Res Function(ChatModel) _then) = _$ChatModelCopyWithImpl;
@useResult
$Res call({
 List<SuggestedFriendModel> friend, MessageModel lastMessage, DateTime lastMessageTime
});


$MessageModelCopyWith<$Res> get lastMessage;

}
/// @nodoc
class _$ChatModelCopyWithImpl<$Res>
    implements $ChatModelCopyWith<$Res> {
  _$ChatModelCopyWithImpl(this._self, this._then);

  final ChatModel _self;
  final $Res Function(ChatModel) _then;

/// Create a copy of ChatModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? friend = null,Object? lastMessage = null,Object? lastMessageTime = null,}) {
  return _then(_self.copyWith(
friend: null == friend ? _self.friend : friend // ignore: cast_nullable_to_non_nullable
as List<SuggestedFriendModel>,lastMessage: null == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as MessageModel,lastMessageTime: null == lastMessageTime ? _self.lastMessageTime : lastMessageTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of ChatModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageModelCopyWith<$Res> get lastMessage {
  
  return $MessageModelCopyWith<$Res>(_self.lastMessage, (value) {
    return _then(_self.copyWith(lastMessage: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _ChatModel implements ChatModel {
  const _ChatModel({required final  List<SuggestedFriendModel> friend, required this.lastMessage, required this.lastMessageTime}): _friend = friend;
  factory _ChatModel.fromJson(Map<String, dynamic> json) => _$ChatModelFromJson(json);

 final  List<SuggestedFriendModel> _friend;
@override List<SuggestedFriendModel> get friend {
  if (_friend is EqualUnmodifiableListView) return _friend;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_friend);
}

@override final  MessageModel lastMessage;
@override final  DateTime lastMessageTime;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatModel&&const DeepCollectionEquality().equals(other._friend, _friend)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage)&&(identical(other.lastMessageTime, lastMessageTime) || other.lastMessageTime == lastMessageTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_friend),lastMessage,lastMessageTime);

@override
String toString() {
  return 'ChatModel(friend: $friend, lastMessage: $lastMessage, lastMessageTime: $lastMessageTime)';
}


}

/// @nodoc
abstract mixin class _$ChatModelCopyWith<$Res> implements $ChatModelCopyWith<$Res> {
  factory _$ChatModelCopyWith(_ChatModel value, $Res Function(_ChatModel) _then) = __$ChatModelCopyWithImpl;
@override @useResult
$Res call({
 List<SuggestedFriendModel> friend, MessageModel lastMessage, DateTime lastMessageTime
});


@override $MessageModelCopyWith<$Res> get lastMessage;

}
/// @nodoc
class __$ChatModelCopyWithImpl<$Res>
    implements _$ChatModelCopyWith<$Res> {
  __$ChatModelCopyWithImpl(this._self, this._then);

  final _ChatModel _self;
  final $Res Function(_ChatModel) _then;

/// Create a copy of ChatModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? friend = null,Object? lastMessage = null,Object? lastMessageTime = null,}) {
  return _then(_ChatModel(
friend: null == friend ? _self._friend : friend // ignore: cast_nullable_to_non_nullable
as List<SuggestedFriendModel>,lastMessage: null == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as MessageModel,lastMessageTime: null == lastMessageTime ? _self.lastMessageTime : lastMessageTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of ChatModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageModelCopyWith<$Res> get lastMessage {
  
  return $MessageModelCopyWith<$Res>(_self.lastMessage, (value) {
    return _then(_self.copyWith(lastMessage: value));
  });
}
}

// dart format on
