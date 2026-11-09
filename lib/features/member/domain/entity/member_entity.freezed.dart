// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MemberEntity {

 String get name; ImageRef? get photo; MemberTier get tier; int get points;/// Null at the top tier.
 MemberTier? get nextTier; int? get pointsToNextTier; int get notificationCount; int get availableRewards;
/// Create a copy of MemberEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberEntityCopyWith<MemberEntity> get copyWith => _$MemberEntityCopyWithImpl<MemberEntity>(this as MemberEntity, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MemberEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberEntity&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.photo, _this.photo) || other.photo == _this.photo)&&(identical(other.tier, _this.tier) || other.tier == _this.tier)&&(identical(other.points, _this.points) || other.points == _this.points)&&(identical(other.nextTier, _this.nextTier) || other.nextTier == _this.nextTier)&&(identical(other.pointsToNextTier, _this.pointsToNextTier) || other.pointsToNextTier == _this.pointsToNextTier)&&(identical(other.notificationCount, _this.notificationCount) || other.notificationCount == _this.notificationCount)&&(identical(other.availableRewards, _this.availableRewards) || other.availableRewards == _this.availableRewards));
}


@override
int get hashCode {
  final _this = this as MemberEntity;
  return Object.hash(runtimeType,_this.name,_this.photo,_this.tier,_this.points,_this.nextTier,_this.pointsToNextTier,_this.notificationCount,_this.availableRewards);
}

@override
String toString() {
  final _this = this as MemberEntity;
  return 'MemberEntity(name: ${_this.name}, photo: ${_this.photo}, tier: ${_this.tier}, points: ${_this.points}, nextTier: ${_this.nextTier}, pointsToNextTier: ${_this.pointsToNextTier}, notificationCount: ${_this.notificationCount}, availableRewards: ${_this.availableRewards})';
}


}

/// @nodoc
abstract mixin class $MemberEntityCopyWith<$Res>  {
  factory $MemberEntityCopyWith(MemberEntity value, $Res Function(MemberEntity) _then) = _$MemberEntityCopyWithImpl;
@useResult
$Res call({
 String name, ImageRef? photo, MemberTier tier, int points, MemberTier? nextTier, int? pointsToNextTier, int notificationCount, int availableRewards
});




}
/// @nodoc
class _$MemberEntityCopyWithImpl<$Res>
    implements $MemberEntityCopyWith<$Res> {
  _$MemberEntityCopyWithImpl(this._self, this._then);

  final MemberEntity _self;
  final $Res Function(MemberEntity) _then;

/// Create a copy of MemberEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? photo = freezed,Object? tier = null,Object? points = null,Object? nextTier = freezed,Object? pointsToNextTier = freezed,Object? notificationCount = null,Object? availableRewards = null,}) {
  return _then(MemberEntity(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,photo: freezed == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as ImageRef?,tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as MemberTier,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,nextTier: freezed == nextTier ? _self.nextTier : nextTier // ignore: cast_nullable_to_non_nullable
as MemberTier?,pointsToNextTier: freezed == pointsToNextTier ? _self.pointsToNextTier : pointsToNextTier // ignore: cast_nullable_to_non_nullable
as int?,notificationCount: null == notificationCount ? _self.notificationCount : notificationCount // ignore: cast_nullable_to_non_nullable
as int,availableRewards: null == availableRewards ? _self.availableRewards : availableRewards // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MemberEntity].
extension MemberEntityPatterns on MemberEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberEntity value)  $default,){
final _that = this;
switch (_that) {
case _MemberEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberEntity value)?  $default,){
final _that = this;
switch (_that) {
case _MemberEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  ImageRef? photo,  MemberTier tier,  int points,  MemberTier? nextTier,  int? pointsToNextTier,  int notificationCount,  int availableRewards)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberEntity() when $default != null:
return $default(_that.name,_that.photo,_that.tier,_that.points,_that.nextTier,_that.pointsToNextTier,_that.notificationCount,_that.availableRewards);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  ImageRef? photo,  MemberTier tier,  int points,  MemberTier? nextTier,  int? pointsToNextTier,  int notificationCount,  int availableRewards)  $default,) {final _that = this;
switch (_that) {
case _MemberEntity():
return $default(_that.name,_that.photo,_that.tier,_that.points,_that.nextTier,_that.pointsToNextTier,_that.notificationCount,_that.availableRewards);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  ImageRef? photo,  MemberTier tier,  int points,  MemberTier? nextTier,  int? pointsToNextTier,  int notificationCount,  int availableRewards)?  $default,) {final _that = this;
switch (_that) {
case _MemberEntity() when $default != null:
return $default(_that.name,_that.photo,_that.tier,_that.points,_that.nextTier,_that.pointsToNextTier,_that.notificationCount,_that.availableRewards);case _:
  return null;

}
}

}

/// @nodoc


class _MemberEntity implements MemberEntity {
  const _MemberEntity({required this.name, this.photo, required this.tier, required this.points, this.nextTier, this.pointsToNextTier, required this.notificationCount, required this.availableRewards});
  

@override final  String name;
@override final  ImageRef? photo;
@override final  MemberTier tier;
@override final  int points;
/// Null at the top tier.
@override final  MemberTier? nextTier;
@override final  int? pointsToNextTier;
@override final  int notificationCount;
@override final  int availableRewards;

/// Create a copy of MemberEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberEntityCopyWith<_MemberEntity> get copyWith => __$MemberEntityCopyWithImpl<_MemberEntity>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.photo, photo) || other.photo == photo)&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.points, points) || other.points == points)&&(identical(other.nextTier, nextTier) || other.nextTier == nextTier)&&(identical(other.pointsToNextTier, pointsToNextTier) || other.pointsToNextTier == pointsToNextTier)&&(identical(other.notificationCount, notificationCount) || other.notificationCount == notificationCount)&&(identical(other.availableRewards, availableRewards) || other.availableRewards == availableRewards));
}


@override
int get hashCode {
    return Object.hash(runtimeType,name,photo,tier,points,nextTier,pointsToNextTier,notificationCount,availableRewards);
}

@override
String toString() {
    return 'MemberEntity(name: $name, photo: $photo, tier: $tier, points: $points, nextTier: $nextTier, pointsToNextTier: $pointsToNextTier, notificationCount: $notificationCount, availableRewards: $availableRewards)';
}


}

/// @nodoc
abstract mixin class _$MemberEntityCopyWith<$Res> implements $MemberEntityCopyWith<$Res> {
  factory _$MemberEntityCopyWith(_MemberEntity value, $Res Function(_MemberEntity) _then) = __$MemberEntityCopyWithImpl;
@override @useResult
$Res call({
 String name, ImageRef? photo, MemberTier tier, int points, MemberTier? nextTier, int? pointsToNextTier, int notificationCount, int availableRewards
});




}
/// @nodoc
class __$MemberEntityCopyWithImpl<$Res>
    implements _$MemberEntityCopyWith<$Res> {
  __$MemberEntityCopyWithImpl(this._self, this._then);

  final _MemberEntity _self;
  final $Res Function(_MemberEntity) _then;

/// Create a copy of MemberEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? photo = freezed,Object? tier = null,Object? points = null,Object? nextTier = freezed,Object? pointsToNextTier = freezed,Object? notificationCount = null,Object? availableRewards = null,}) {
  return _then(_MemberEntity(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,photo: freezed == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as ImageRef?,tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
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
