// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'suggested_friend_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SuggestedFriendModel {

 int get id; String get username; String get sex; String get bio; int get age; List<String> get passions;@JsonKey(name: 'image_url') String? get imageUrl;
/// Create a copy of SuggestedFriendModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuggestedFriendModelCopyWith<SuggestedFriendModel> get copyWith => _$SuggestedFriendModelCopyWithImpl<SuggestedFriendModel>(this as SuggestedFriendModel, _$identity);

  /// Serializes this SuggestedFriendModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuggestedFriendModel&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.sex, sex) || other.sex == sex)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.age, age) || other.age == age)&&const DeepCollectionEquality().equals(other.passions, passions)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username,sex,bio,age,const DeepCollectionEquality().hash(passions),imageUrl);

@override
String toString() {
  return 'SuggestedFriendModel(id: $id, username: $username, sex: $sex, bio: $bio, age: $age, passions: $passions, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $SuggestedFriendModelCopyWith<$Res>  {
  factory $SuggestedFriendModelCopyWith(SuggestedFriendModel value, $Res Function(SuggestedFriendModel) _then) = _$SuggestedFriendModelCopyWithImpl;
@useResult
$Res call({
 int id, String username, String sex, String bio, int age, List<String> passions,@JsonKey(name: 'image_url') String? imageUrl
});




}
/// @nodoc
class _$SuggestedFriendModelCopyWithImpl<$Res>
    implements $SuggestedFriendModelCopyWith<$Res> {
  _$SuggestedFriendModelCopyWithImpl(this._self, this._then);

  final SuggestedFriendModel _self;
  final $Res Function(SuggestedFriendModel) _then;

/// Create a copy of SuggestedFriendModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = null,Object? sex = null,Object? bio = null,Object? age = null,Object? passions = null,Object? imageUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,sex: null == sex ? _self.sex : sex // ignore: cast_nullable_to_non_nullable
as String,bio: null == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,passions: null == passions ? _self.passions : passions // ignore: cast_nullable_to_non_nullable
as List<String>,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _SuggestedFriendModel implements SuggestedFriendModel {
  const _SuggestedFriendModel({required this.id, required this.username, required this.sex, required this.bio, required this.age, required final  List<String> passions, @JsonKey(name: 'image_url') required this.imageUrl}): _passions = passions;
  factory _SuggestedFriendModel.fromJson(Map<String, dynamic> json) => _$SuggestedFriendModelFromJson(json);

@override final  int id;
@override final  String username;
@override final  String sex;
@override final  String bio;
@override final  int age;
 final  List<String> _passions;
@override List<String> get passions {
  if (_passions is EqualUnmodifiableListView) return _passions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_passions);
}

@override@JsonKey(name: 'image_url') final  String? imageUrl;

/// Create a copy of SuggestedFriendModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuggestedFriendModelCopyWith<_SuggestedFriendModel> get copyWith => __$SuggestedFriendModelCopyWithImpl<_SuggestedFriendModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SuggestedFriendModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SuggestedFriendModel&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.sex, sex) || other.sex == sex)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.age, age) || other.age == age)&&const DeepCollectionEquality().equals(other._passions, _passions)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username,sex,bio,age,const DeepCollectionEquality().hash(_passions),imageUrl);

@override
String toString() {
  return 'SuggestedFriendModel(id: $id, username: $username, sex: $sex, bio: $bio, age: $age, passions: $passions, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$SuggestedFriendModelCopyWith<$Res> implements $SuggestedFriendModelCopyWith<$Res> {
  factory _$SuggestedFriendModelCopyWith(_SuggestedFriendModel value, $Res Function(_SuggestedFriendModel) _then) = __$SuggestedFriendModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String username, String sex, String bio, int age, List<String> passions,@JsonKey(name: 'image_url') String? imageUrl
});




}
/// @nodoc
class __$SuggestedFriendModelCopyWithImpl<$Res>
    implements _$SuggestedFriendModelCopyWith<$Res> {
  __$SuggestedFriendModelCopyWithImpl(this._self, this._then);

  final _SuggestedFriendModel _self;
  final $Res Function(_SuggestedFriendModel) _then;

/// Create a copy of SuggestedFriendModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? username = null,Object? sex = null,Object? bio = null,Object? age = null,Object? passions = null,Object? imageUrl = freezed,}) {
  return _then(_SuggestedFriendModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,sex: null == sex ? _self.sex : sex // ignore: cast_nullable_to_non_nullable
as String,bio: null == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,passions: null == passions ? _self._passions : passions // ignore: cast_nullable_to_non_nullable
as List<String>,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
