// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tier_progress_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TierProgressEntity {

 MemberEntity get member;/// Lowest tier first.
 List<TierEntity> get tiers;
/// Create a copy of TierProgressEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TierProgressEntityCopyWith<TierProgressEntity> get copyWith => _$TierProgressEntityCopyWithImpl<TierProgressEntity>(this as TierProgressEntity, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TierProgressEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TierProgressEntity&&(identical(other.member, _this.member) || other.member == _this.member)&&const DeepCollectionEquality().equals(other.tiers, _this.tiers));
}


@override
int get hashCode {
  final _this = this as TierProgressEntity;
  return Object.hash(runtimeType,_this.member,const DeepCollectionEquality().hash(_this.tiers));
}

@override
String toString() {
  final _this = this as TierProgressEntity;
  return 'TierProgressEntity(member: ${_this.member}, tiers: ${_this.tiers})';
}


}

/// @nodoc
abstract mixin class $TierProgressEntityCopyWith<$Res>  {
  factory $TierProgressEntityCopyWith(TierProgressEntity value, $Res Function(TierProgressEntity) _then) = _$TierProgressEntityCopyWithImpl;
@useResult
$Res call({
 MemberEntity member, List<TierEntity> tiers
});


$MemberEntityCopyWith<$Res> get member;

}
/// @nodoc
class _$TierProgressEntityCopyWithImpl<$Res>
    implements $TierProgressEntityCopyWith<$Res> {
  _$TierProgressEntityCopyWithImpl(this._self, this._then);

  final TierProgressEntity _self;
  final $Res Function(TierProgressEntity) _then;

/// Create a copy of TierProgressEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? member = null,Object? tiers = null,}) {
  return _then(TierProgressEntity(
member: null == member ? _self.member : member // ignore: cast_nullable_to_non_nullable
as MemberEntity,tiers: null == tiers ? _self.tiers : tiers // ignore: cast_nullable_to_non_nullable
as List<TierEntity>,
  ));
}
/// Create a copy of TierProgressEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberEntityCopyWith<$Res> get member {
  
  return $MemberEntityCopyWith<$Res>(_self.member, (value) {
    return _then(_self.copyWith(member: value));
  });
}
}


/// Adds pattern-matching-related methods to [TierProgressEntity].
extension TierProgressEntityPatterns on TierProgressEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TierProgressEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TierProgressEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TierProgressEntity value)  $default,){
final _that = this;
switch (_that) {
case _TierProgressEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TierProgressEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TierProgressEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MemberEntity member,  List<TierEntity> tiers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TierProgressEntity() when $default != null:
return $default(_that.member,_that.tiers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MemberEntity member,  List<TierEntity> tiers)  $default,) {final _that = this;
switch (_that) {
case _TierProgressEntity():
return $default(_that.member,_that.tiers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MemberEntity member,  List<TierEntity> tiers)?  $default,) {final _that = this;
switch (_that) {
case _TierProgressEntity() when $default != null:
return $default(_that.member,_that.tiers);case _:
  return null;

}
}

}

/// @nodoc


class _TierProgressEntity extends TierProgressEntity {
  const _TierProgressEntity({required this.member, required  List<TierEntity> tiers}): _tiers = tiers,super._();
  

@override final  MemberEntity member;
/// Lowest tier first.
 final  List<TierEntity> _tiers;
/// Lowest tier first.
@override List<TierEntity> get tiers {
  if (_tiers is EqualUnmodifiableListView) return _tiers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tiers);
}


/// Create a copy of TierProgressEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TierProgressEntityCopyWith<_TierProgressEntity> get copyWith => __$TierProgressEntityCopyWithImpl<_TierProgressEntity>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TierProgressEntity&&(identical(other.member, member) || other.member == member)&&const DeepCollectionEquality().equals(other.tiers, _tiers));
}


@override
int get hashCode {
    return Object.hash(runtimeType,member,const DeepCollectionEquality().hash(_tiers));
}

@override
String toString() {
    return 'TierProgressEntity(member: $member, tiers: $tiers)';
}


}

/// @nodoc
abstract mixin class _$TierProgressEntityCopyWith<$Res> implements $TierProgressEntityCopyWith<$Res> {
  factory _$TierProgressEntityCopyWith(_TierProgressEntity value, $Res Function(_TierProgressEntity) _then) = __$TierProgressEntityCopyWithImpl;
@override @useResult
$Res call({
 MemberEntity member, List<TierEntity> tiers
});


@override $MemberEntityCopyWith<$Res> get member;

}
/// @nodoc
class __$TierProgressEntityCopyWithImpl<$Res>
    implements _$TierProgressEntityCopyWith<$Res> {
  __$TierProgressEntityCopyWithImpl(this._self, this._then);

  final _TierProgressEntity _self;
  final $Res Function(_TierProgressEntity) _then;

/// Create a copy of TierProgressEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? member = null,Object? tiers = null,}) {
  return _then(_TierProgressEntity(
member: null == member ? _self.member : member // ignore: cast_nullable_to_non_nullable
as MemberEntity,tiers: null == tiers ? _self._tiers : tiers // ignore: cast_nullable_to_non_nullable
as List<TierEntity>,
  ));
}

/// Create a copy of TierProgressEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberEntityCopyWith<$Res> get member {
  
  return $MemberEntityCopyWith<$Res>(_self.member, (value) {
    return _then(_self.copyWith(member: value));
  });
}
}

// dart format on
