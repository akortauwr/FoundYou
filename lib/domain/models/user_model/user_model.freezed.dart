// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserModel {

 int get id; String get email; String get username; DateTime get birthday; String get bio;@JsonKey(name: 'image_url') String? get imageUrl; List<String> get passions;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'match_count') int get friendCount; String get sex;
/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserModelCopyWith<UserModel> get copyWith => _$UserModelCopyWithImpl<UserModel>(this as UserModel, _$identity);

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.username, username) || other.username == username)&&(identical(other.birthday, birthday) || other.birthday == birthday)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other.passions, passions)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.friendCount, friendCount) || other.friendCount == friendCount)&&(identical(other.sex, sex) || other.sex == sex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,username,birthday,bio,imageUrl,const DeepCollectionEquality().hash(passions),createdAt,friendCount,sex);

@override
String toString() {
  return 'UserModel(id: $id, email: $email, username: $username, birthday: $birthday, bio: $bio, imageUrl: $imageUrl, passions: $passions, createdAt: $createdAt, friendCount: $friendCount, sex: $sex)';
}


}

/// @nodoc
abstract mixin class $UserModelCopyWith<$Res>  {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) _then) = _$UserModelCopyWithImpl;
@useResult
$Res call({
 int id, String email, String username, DateTime birthday, String bio,@JsonKey(name: 'image_url') String? imageUrl, List<String> passions,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'match_count') int friendCount, String sex
});




}
/// @nodoc
class _$UserModelCopyWithImpl<$Res>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._self, this._then);

  final UserModel _self;
  final $Res Function(UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? username = null,Object? birthday = null,Object? bio = null,Object? imageUrl = freezed,Object? passions = null,Object? createdAt = null,Object? friendCount = null,Object? sex = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,birthday: null == birthday ? _self.birthday : birthday // ignore: cast_nullable_to_non_nullable
as DateTime,bio: null == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,passions: null == passions ? _self.passions : passions // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,friendCount: null == friendCount ? _self.friendCount : friendCount // ignore: cast_nullable_to_non_nullable
as int,sex: null == sex ? _self.sex : sex // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc

@JsonSerializable(checked: true)
class _UserModel implements UserModel {
  const _UserModel({required this.id, required this.email, required this.username, required this.birthday, required this.bio, @JsonKey(name: 'image_url') this.imageUrl, required final  List<String> passions, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'match_count') required this.friendCount, required this.sex}): _passions = passions;
  factory _UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

@override final  int id;
@override final  String email;
@override final  String username;
@override final  DateTime birthday;
@override final  String bio;
@override@JsonKey(name: 'image_url') final  String? imageUrl;
 final  List<String> _passions;
@override List<String> get passions {
  if (_passions is EqualUnmodifiableListView) return _passions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_passions);
}

@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'match_count') final  int friendCount;
@override final  String sex;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserModelCopyWith<_UserModel> get copyWith => __$UserModelCopyWithImpl<_UserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.username, username) || other.username == username)&&(identical(other.birthday, birthday) || other.birthday == birthday)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other._passions, _passions)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.friendCount, friendCount) || other.friendCount == friendCount)&&(identical(other.sex, sex) || other.sex == sex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,username,birthday,bio,imageUrl,const DeepCollectionEquality().hash(_passions),createdAt,friendCount,sex);

@override
String toString() {
  return 'UserModel(id: $id, email: $email, username: $username, birthday: $birthday, bio: $bio, imageUrl: $imageUrl, passions: $passions, createdAt: $createdAt, friendCount: $friendCount, sex: $sex)';
}


}

/// @nodoc
abstract mixin class _$UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$UserModelCopyWith(_UserModel value, $Res Function(_UserModel) _then) = __$UserModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String email, String username, DateTime birthday, String bio,@JsonKey(name: 'image_url') String? imageUrl, List<String> passions,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'match_count') int friendCount, String sex
});




}
/// @nodoc
class __$UserModelCopyWithImpl<$Res>
    implements _$UserModelCopyWith<$Res> {
  __$UserModelCopyWithImpl(this._self, this._then);

  final _UserModel _self;
  final $Res Function(_UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? username = null,Object? birthday = null,Object? bio = null,Object? imageUrl = freezed,Object? passions = null,Object? createdAt = null,Object? friendCount = null,Object? sex = null,}) {
  return _then(_UserModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,birthday: null == birthday ? _self.birthday : birthday // ignore: cast_nullable_to_non_nullable
as DateTime,bio: null == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,passions: null == passions ? _self._passions : passions // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,friendCount: null == friendCount ? _self.friendCount : friendCount // ignore: cast_nullable_to_non_nullable
as int,sex: null == sex ? _self.sex : sex // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
