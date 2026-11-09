// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'challenge_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChallengeEntity {

 String get id; ChallengeTab get tab; String get title; int get goal; int get progress; int get rewardPoints; ChallengeArtwork get artwork; ImageRef get image;
/// Create a copy of ChallengeEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChallengeEntityCopyWith<ChallengeEntity> get copyWith => _$ChallengeEntityCopyWithImpl<ChallengeEntity>(this as ChallengeEntity, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ChallengeEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChallengeEntity&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.tab, _this.tab) || other.tab == _this.tab)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.goal, _this.goal) || other.goal == _this.goal)&&(identical(other.progress, _this.progress) || other.progress == _this.progress)&&(identical(other.rewardPoints, _this.rewardPoints) || other.rewardPoints == _this.rewardPoints)&&(identical(other.artwork, _this.artwork) || other.artwork == _this.artwork)&&(identical(other.image, _this.image) || other.image == _this.image));
}


@override
int get hashCode {
  final _this = this as ChallengeEntity;
  return Object.hash(runtimeType,_this.id,_this.tab,_this.title,_this.goal,_this.progress,_this.rewardPoints,_this.artwork,_this.image);
}

@override
String toString() {
  final _this = this as ChallengeEntity;
  return 'ChallengeEntity(id: ${_this.id}, tab: ${_this.tab}, title: ${_this.title}, goal: ${_this.goal}, progress: ${_this.progress}, rewardPoints: ${_this.rewardPoints}, artwork: ${_this.artwork}, image: ${_this.image})';
}


}

/// @nodoc
abstract mixin class $ChallengeEntityCopyWith<$Res>  {
  factory $ChallengeEntityCopyWith(ChallengeEntity value, $Res Function(ChallengeEntity) _then) = _$ChallengeEntityCopyWithImpl;
@useResult
$Res call({
 String id, ChallengeTab tab, String title, int goal, int progress, int rewardPoints, ChallengeArtwork artwork, ImageRef image
});




}
/// @nodoc
class _$ChallengeEntityCopyWithImpl<$Res>
    implements $ChallengeEntityCopyWith<$Res> {
  _$ChallengeEntityCopyWithImpl(this._self, this._then);

  final ChallengeEntity _self;
  final $Res Function(ChallengeEntity) _then;

/// Create a copy of ChallengeEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tab = null,Object? title = null,Object? goal = null,Object? progress = null,Object? rewardPoints = null,Object? artwork = null,Object? image = null,}) {
  return _then(ChallengeEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tab: null == tab ? _self.tab : tab // ignore: cast_nullable_to_non_nullable
as ChallengeTab,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,goal: null == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as int,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as int,rewardPoints: null == rewardPoints ? _self.rewardPoints : rewardPoints // ignore: cast_nullable_to_non_nullable
as int,artwork: null == artwork ? _self.artwork : artwork // ignore: cast_nullable_to_non_nullable
as ChallengeArtwork,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as ImageRef,
  ));
}

}


/// Adds pattern-matching-related methods to [ChallengeEntity].
extension ChallengeEntityPatterns on ChallengeEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChallengeEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChallengeEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChallengeEntity value)  $default,){
final _that = this;
switch (_that) {
case _ChallengeEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChallengeEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ChallengeEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  ChallengeTab tab,  String title,  int goal,  int progress,  int rewardPoints,  ChallengeArtwork artwork,  ImageRef image)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChallengeEntity() when $default != null:
return $default(_that.id,_that.tab,_that.title,_that.goal,_that.progress,_that.rewardPoints,_that.artwork,_that.image);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  ChallengeTab tab,  String title,  int goal,  int progress,  int rewardPoints,  ChallengeArtwork artwork,  ImageRef image)  $default,) {final _that = this;
switch (_that) {
case _ChallengeEntity():
return $default(_that.id,_that.tab,_that.title,_that.goal,_that.progress,_that.rewardPoints,_that.artwork,_that.image);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  ChallengeTab tab,  String title,  int goal,  int progress,  int rewardPoints,  ChallengeArtwork artwork,  ImageRef image)?  $default,) {final _that = this;
switch (_that) {
case _ChallengeEntity() when $default != null:
return $default(_that.id,_that.tab,_that.title,_that.goal,_that.progress,_that.rewardPoints,_that.artwork,_that.image);case _:
  return null;

}
}

}

/// @nodoc


class _ChallengeEntity extends ChallengeEntity {
  const _ChallengeEntity({required this.id, required this.tab, required this.title, required this.goal, required this.progress, required this.rewardPoints, required this.artwork, required this.image}): super._();
  

@override final  String id;
@override final  ChallengeTab tab;
@override final  String title;
@override final  int goal;
@override final  int progress;
@override final  int rewardPoints;
@override final  ChallengeArtwork artwork;
@override final  ImageRef image;

/// Create a copy of ChallengeEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChallengeEntityCopyWith<_ChallengeEntity> get copyWith => __$ChallengeEntityCopyWithImpl<_ChallengeEntity>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChallengeEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tab, tab) || other.tab == tab)&&(identical(other.title, title) || other.title == title)&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.rewardPoints, rewardPoints) || other.rewardPoints == rewardPoints)&&(identical(other.artwork, artwork) || other.artwork == artwork)&&(identical(other.image, image) || other.image == image));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,tab,title,goal,progress,rewardPoints,artwork,image);
}

@override
String toString() {
    return 'ChallengeEntity(id: $id, tab: $tab, title: $title, goal: $goal, progress: $progress, rewardPoints: $rewardPoints, artwork: $artwork, image: $image)';
}


}

/// @nodoc
abstract mixin class _$ChallengeEntityCopyWith<$Res> implements $ChallengeEntityCopyWith<$Res> {
  factory _$ChallengeEntityCopyWith(_ChallengeEntity value, $Res Function(_ChallengeEntity) _then) = __$ChallengeEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, ChallengeTab tab, String title, int goal, int progress, int rewardPoints, ChallengeArtwork artwork, ImageRef image
});




}
/// @nodoc
class __$ChallengeEntityCopyWithImpl<$Res>
    implements _$ChallengeEntityCopyWith<$Res> {
  __$ChallengeEntityCopyWithImpl(this._self, this._then);

  final _ChallengeEntity _self;
  final $Res Function(_ChallengeEntity) _then;

/// Create a copy of ChallengeEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tab = null,Object? title = null,Object? goal = null,Object? progress = null,Object? rewardPoints = null,Object? artwork = null,Object? image = null,}) {
  return _then(_ChallengeEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tab: null == tab ? _self.tab : tab // ignore: cast_nullable_to_non_nullable
as ChallengeTab,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,goal: null == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as int,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as int,rewardPoints: null == rewardPoints ? _self.rewardPoints : rewardPoints // ignore: cast_nullable_to_non_nullable
as int,artwork: null == artwork ? _self.artwork : artwork // ignore: cast_nullable_to_non_nullable
as ChallengeArtwork,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as ImageRef,
  ));
}


}

// dart format on
