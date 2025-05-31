// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friend_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FriendModel {

 String get username; String get sex; String get bio; int get age; String get imageUrl;
/// Create a copy of FriendModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendModelCopyWith<FriendModel> get copyWith => _$FriendModelCopyWithImpl<FriendModel>(this as FriendModel, _$identity);

  /// Serializes this FriendModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendModel&&(identical(other.username, username) || other.username == username)&&(identical(other.sex, sex) || other.sex == sex)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.age, age) || other.age == age)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username,sex,bio,age,imageUrl);

@override
String toString() {
  return 'FriendModel(username: $username, sex: $sex, bio: $bio, age: $age, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $FriendModelCopyWith<$Res>  {
  factory $FriendModelCopyWith(FriendModel value, $Res Function(FriendModel) _then) = _$FriendModelCopyWithImpl;
@useResult
$Res call({
 String username, String sex, String bio, int age, String imageUrl
});




}
/// @nodoc
class _$FriendModelCopyWithImpl<$Res>
    implements $FriendModelCopyWith<$Res> {
  _$FriendModelCopyWithImpl(this._self, this._then);

  final FriendModel _self;
  final $Res Function(FriendModel) _then;

/// Create a copy of FriendModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? username = null,Object? sex = null,Object? bio = null,Object? age = null,Object? imageUrl = null,}) {
  return _then(_self.copyWith(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,sex: null == sex ? _self.sex : sex // ignore: cast_nullable_to_non_nullable
as String,bio: null == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _FriendModel implements FriendModel {
  const _FriendModel({required this.username, required this.sex, required this.bio, required this.age, required this.imageUrl});
  factory _FriendModel.fromJson(Map<String, dynamic> json) => _$FriendModelFromJson(json);

@override final  String username;
@override final  String sex;
@override final  String bio;
@override final  int age;
@override final  String imageUrl;

/// Create a copy of FriendModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FriendModelCopyWith<_FriendModel> get copyWith => __$FriendModelCopyWithImpl<_FriendModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FriendModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FriendModel&&(identical(other.username, username) || other.username == username)&&(identical(other.sex, sex) || other.sex == sex)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.age, age) || other.age == age)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username,sex,bio,age,imageUrl);

@override
String toString() {
  return 'FriendModel(username: $username, sex: $sex, bio: $bio, age: $age, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$FriendModelCopyWith<$Res> implements $FriendModelCopyWith<$Res> {
  factory _$FriendModelCopyWith(_FriendModel value, $Res Function(_FriendModel) _then) = __$FriendModelCopyWithImpl;
@override @useResult
$Res call({
 String username, String sex, String bio, int age, String imageUrl
});




}
/// @nodoc
class __$FriendModelCopyWithImpl<$Res>
    implements _$FriendModelCopyWith<$Res> {
  __$FriendModelCopyWithImpl(this._self, this._then);

  final _FriendModel _self;
  final $Res Function(_FriendModel) _then;

/// Create a copy of FriendModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? username = null,Object? sex = null,Object? bio = null,Object? age = null,Object? imageUrl = null,}) {
  return _then(_FriendModel(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,sex: null == sex ? _self.sex : sex // ignore: cast_nullable_to_non_nullable
as String,bio: null == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
