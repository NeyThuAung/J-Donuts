// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tier_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TierEntity {

 MemberTier get tier;/// Points the tier starts at.
 int get minPoints;
/// Create a copy of TierEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TierEntityCopyWith<TierEntity> get copyWith => _$TierEntityCopyWithImpl<TierEntity>(this as TierEntity, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TierEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TierEntity&&(identical(other.tier, _this.tier) || other.tier == _this.tier)&&(identical(other.minPoints, _this.minPoints) || other.minPoints == _this.minPoints));
}


@override
int get hashCode {
  final _this = this as TierEntity;
  return Object.hash(runtimeType,_this.tier,_this.minPoints);
}

@override
String toString() {
  final _this = this as TierEntity;
  return 'TierEntity(tier: ${_this.tier}, minPoints: ${_this.minPoints})';
}


}

/// @nodoc
abstract mixin class $TierEntityCopyWith<$Res>  {
  factory $TierEntityCopyWith(TierEntity value, $Res Function(TierEntity) _then) = _$TierEntityCopyWithImpl;
@useResult
$Res call({
 MemberTier tier, int minPoints
});




}
/// @nodoc
class _$TierEntityCopyWithImpl<$Res>
    implements $TierEntityCopyWith<$Res> {
  _$TierEntityCopyWithImpl(this._self, this._then);

  final TierEntity _self;
  final $Res Function(TierEntity) _then;

/// Create a copy of TierEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tier = null,Object? minPoints = null,}) {
  return _then(TierEntity(
tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as MemberTier,minPoints: null == minPoints ? _self.minPoints : minPoints // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TierEntity].
extension TierEntityPatterns on TierEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TierEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TierEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TierEntity value)  $default,){
final _that = this;
switch (_that) {
case _TierEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TierEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TierEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MemberTier tier,  int minPoints)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TierEntity() when $default != null:
return $default(_that.tier,_that.minPoints);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MemberTier tier,  int minPoints)  $default,) {final _that = this;
switch (_that) {
case _TierEntity():
return $default(_that.tier,_that.minPoints);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MemberTier tier,  int minPoints)?  $default,) {final _that = this;
switch (_that) {
case _TierEntity() when $default != null:
return $default(_that.tier,_that.minPoints);case _:
  return null;

}
}

}

/// @nodoc


class _TierEntity implements TierEntity {
  const _TierEntity({required this.tier, required this.minPoints});
  

@override final  MemberTier tier;
/// Points the tier starts at.
@override final  int minPoints;

/// Create a copy of TierEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TierEntityCopyWith<_TierEntity> get copyWith => __$TierEntityCopyWithImpl<_TierEntity>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TierEntity&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.minPoints, minPoints) || other.minPoints == minPoints));
}


@override
int get hashCode {
    return Object.hash(runtimeType,tier,minPoints);
}

@override
String toString() {
    return 'TierEntity(tier: $tier, minPoints: $minPoints)';
}


}

/// @nodoc
abstract mixin class _$TierEntityCopyWith<$Res> implements $TierEntityCopyWith<$Res> {
  factory _$TierEntityCopyWith(_TierEntity value, $Res Function(_TierEntity) _then) = __$TierEntityCopyWithImpl;
@override @useResult
$Res call({
 MemberTier tier, int minPoints
});




}
/// @nodoc
class __$TierEntityCopyWithImpl<$Res>
    implements _$TierEntityCopyWith<$Res> {
  __$TierEntityCopyWithImpl(this._self, this._then);

  final _TierEntity _self;
  final $Res Function(_TierEntity) _then;

/// Create a copy of TierEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tier = null,Object? minPoints = null,}) {
  return _then(_TierEntity(
tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as MemberTier,minPoints: null == minPoints ? _self.minPoints : minPoints // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
