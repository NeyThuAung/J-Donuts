// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MemberModel {

 String get name; String? get photoUrl; MemberTier get tier; int get points; MemberTier? get nextTier; int? get pointsToNextTier; int get notificationCount; int get availableRewards;
/// Create a copy of MemberModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberModelCopyWith<MemberModel> get copyWith => _$MemberModelCopyWithImpl<MemberModel>(this as MemberModel, _$identity);

  /// Serializes this MemberModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MemberModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberModel&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.photoUrl, _this.photoUrl) || other.photoUrl == _this.photoUrl)&&(identical(other.tier, _this.tier) || other.tier == _this.tier)&&(identical(other.points, _this.points) || other.points == _this.points)&&(identical(other.nextTier, _this.nextTier) || other.nextTier == _this.nextTier)&&(identical(other.pointsToNextTier, _this.pointsToNextTier) || other.pointsToNextTier == _this.pointsToNextTier)&&(identical(other.notificationCount, _this.notificationCount) || other.notificationCount == _this.notificationCount)&&(identical(other.availableRewards, _this.availableRewards) || other.availableRewards == _this.availableRewards));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MemberModel;
  return Object.hash(runtimeType,_this.name,_this.photoUrl,_this.tier,_this.points,_this.nextTier,_this.pointsToNextTier,_this.notificationCount,_this.availableRewards);
}

@override
String toString() {
  final _this = this as MemberModel;
  return 'MemberModel(name: ${_this.name}, photoUrl: ${_this.photoUrl}, tier: ${_this.tier}, points: ${_this.points}, nextTier: ${_this.nextTier}, pointsToNextTier: ${_this.pointsToNextTier}, notificationCount: ${_this.notificationCount}, availableRewards: ${_this.availableRewards})';
}


}

/// @nodoc
abstract mixin class $MemberModelCopyWith<$Res>  {
  factory $MemberModelCopyWith(MemberModel value, $Res Function(MemberModel) _then) = _$MemberModelCopyWithImpl;
@useResult
$Res call({
 String name, String? photoUrl, MemberTier tier, int points, MemberTier? nextTier, int? pointsToNextTier, int notificationCount, int availableRewards
});




}
/// @nodoc
class _$MemberModelCopyWithImpl<$Res>
    implements $MemberModelCopyWith<$Res> {
  _$MemberModelCopyWithImpl(this._self, this._then);

  final MemberModel _self;
  final $Res Function(MemberModel) _then;

/// Create a copy of MemberModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? photoUrl = freezed,Object? tier = null,Object? points = null,Object? nextTier = freezed,Object? pointsToNextTier = freezed,Object? notificationCount = null,Object? availableRewards = null,}) {
  return _then(MemberModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as MemberTier,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,nextTier: freezed == nextTier ? _self.nextTier : nextTier // ignore: cast_nullable_to_non_nullable
as MemberTier?,pointsToNextTier: freezed == pointsToNextTier ? _self.pointsToNextTier : pointsToNextTier // ignore: cast_nullable_to_non_nullable
as int?,notificationCount: null == notificationCount ? _self.notificationCount : notificationCount // ignore: cast_nullable_to_non_nullable
as int,availableRewards: null == availableRewards ? _self.availableRewards : availableRewards // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MemberModel].
extension MemberModelPatterns on MemberModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberModel value)  $default,){
final _that = this;
switch (_that) {
case _MemberModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberModel value)?  $default,){
final _that = this;
switch (_that) {
case _MemberModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String? photoUrl,  MemberTier tier,  int points,  MemberTier? nextTier,  int? pointsToNextTier,  int notificationCount,  int availableRewards)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberModel() when $default != null:
return $default(_that.name,_that.photoUrl,_that.tier,_that.points,_that.nextTier,_that.pointsToNextTier,_that.notificationCount,_that.availableRewards);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String? photoUrl,  MemberTier tier,  int points,  MemberTier? nextTier,  int? pointsToNextTier,  int notificationCount,  int availableRewards)  $default,) {final _that = this;
switch (_that) {
case _MemberModel():
return $default(_that.name,_that.photoUrl,_that.tier,_that.points,_that.nextTier,_that.pointsToNextTier,_that.notificationCount,_that.availableRewards);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String? photoUrl,  MemberTier tier,  int points,  MemberTier? nextTier,  int? pointsToNextTier,  int notificationCount,  int availableRewards)?  $default,) {final _that = this;
switch (_that) {
case _MemberModel() when $default != null:
return $default(_that.name,_that.photoUrl,_that.tier,_that.points,_that.nextTier,_that.pointsToNextTier,_that.notificationCount,_that.availableRewards);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MemberModel implements MemberModel {
  const _MemberModel({required this.name, this.photoUrl, required this.tier, required this.points, this.nextTier, this.pointsToNextTier, required this.notificationCount, required this.availableRewards});
  factory _MemberModel.fromJson(Map<String, dynamic> json) => _$MemberModelFromJson(json);

@override final  String name;
@override final  String? photoUrl;
@override final  MemberTier tier;
@override final  int points;
@override final  MemberTier? nextTier;
@override final  int? pointsToNextTier;
@override final  int notificationCount;
@override final  int availableRewards;

/// Create a copy of MemberModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberModelCopyWith<_MemberModel> get copyWith => __$MemberModelCopyWithImpl<_MemberModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberModel&&(identical(other.name, name) || other.name == name)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.points, points) || other.points == points)&&(identical(other.nextTier, nextTier) || other.nextTier == nextTier)&&(identical(other.pointsToNextTier, pointsToNextTier) || other.pointsToNextTier == pointsToNextTier)&&(identical(other.notificationCount, notificationCount) || other.notificationCount == notificationCount)&&(identical(other.availableRewards, availableRewards) || other.availableRewards == availableRewards));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,photoUrl,tier,points,nextTier,pointsToNextTier,notificationCount,availableRewards);
}

@override
String toString() {
    return 'MemberModel(name: $name, photoUrl: $photoUrl, tier: $tier, points: $points, nextTier: $nextTier, pointsToNextTier: $pointsToNextTier, notificationCount: $notificationCount, availableRewards: $availableRewards)';
}


}

/// @nodoc
abstract mixin class _$MemberModelCopyWith<$Res> implements $MemberModelCopyWith<$Res> {
  factory _$MemberModelCopyWith(_MemberModel value, $Res Function(_MemberModel) _then) = __$MemberModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String? photoUrl, MemberTier tier, int points, MemberTier? nextTier, int? pointsToNextTier, int notificationCount, int availableRewards
});




}
/// @nodoc
class __$MemberModelCopyWithImpl<$Res>
    implements _$MemberModelCopyWith<$Res> {
  __$MemberModelCopyWithImpl(this._self, this._then);

  final _MemberModel _self;
  final $Res Function(_MemberModel) _then;

/// Create a copy of MemberModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? photoUrl = freezed,Object? tier = null,Object? points = null,Object? nextTier = freezed,Object? pointsToNextTier = freezed,Object? notificationCount = null,Object? availableRewards = null,}) {
  return _then(_MemberModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as MemberTier,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,nextTier: freezed == nextTier ? _self.nextTier : nextTier // ignore: cast_nullable_to_non_nullable
as MemberTier?,pointsToNextTier: freezed == pointsToNextTier ? _self.pointsToNextTier : pointsToNextTier // ignore: cast_nullable_to_non_nullable
as int?,notificationCount: null == notificationCount ? _self.notificationCount : notificationCount // ignore: cast_nullable_to_non_nullable
as int,availableRewards: null == availableRewards ? _self.availableRewards : availableRewards // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
