// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rewards_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TierModel {

@JsonKey(name: 'id') MemberTier get tier; int get minPoints;
/// Create a copy of TierModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TierModelCopyWith<TierModel> get copyWith => _$TierModelCopyWithImpl<TierModel>(this as TierModel, _$identity);

  /// Serializes this TierModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TierModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TierModel&&(identical(other.tier, _this.tier) || other.tier == _this.tier)&&(identical(other.minPoints, _this.minPoints) || other.minPoints == _this.minPoints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TierModel;
  return Object.hash(runtimeType,_this.tier,_this.minPoints);
}

@override
String toString() {
  final _this = this as TierModel;
  return 'TierModel(tier: ${_this.tier}, minPoints: ${_this.minPoints})';
}


}

/// @nodoc
abstract mixin class $TierModelCopyWith<$Res>  {
  factory $TierModelCopyWith(TierModel value, $Res Function(TierModel) _then) = _$TierModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') MemberTier tier, int minPoints
});




}
/// @nodoc
class _$TierModelCopyWithImpl<$Res>
    implements $TierModelCopyWith<$Res> {
  _$TierModelCopyWithImpl(this._self, this._then);

  final TierModel _self;
  final $Res Function(TierModel) _then;

/// Create a copy of TierModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tier = null,Object? minPoints = null,}) {
  return _then(TierModel(
tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as MemberTier,minPoints: null == minPoints ? _self.minPoints : minPoints // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TierModel].
extension TierModelPatterns on TierModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TierModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TierModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TierModel value)  $default,){
final _that = this;
switch (_that) {
case _TierModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TierModel value)?  $default,){
final _that = this;
switch (_that) {
case _TierModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  MemberTier tier,  int minPoints)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TierModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  MemberTier tier,  int minPoints)  $default,) {final _that = this;
switch (_that) {
case _TierModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  MemberTier tier,  int minPoints)?  $default,) {final _that = this;
switch (_that) {
case _TierModel() when $default != null:
return $default(_that.tier,_that.minPoints);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TierModel implements TierModel {
  const _TierModel({@JsonKey(name: 'id') required this.tier, required this.minPoints});
  factory _TierModel.fromJson(Map<String, dynamic> json) => _$TierModelFromJson(json);

@override@JsonKey(name: 'id') final  MemberTier tier;
@override final  int minPoints;

/// Create a copy of TierModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TierModelCopyWith<_TierModel> get copyWith => __$TierModelCopyWithImpl<_TierModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TierModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TierModel&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.minPoints, minPoints) || other.minPoints == minPoints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,tier,minPoints);
}

@override
String toString() {
    return 'TierModel(tier: $tier, minPoints: $minPoints)';
}


}

/// @nodoc
abstract mixin class _$TierModelCopyWith<$Res> implements $TierModelCopyWith<$Res> {
  factory _$TierModelCopyWith(_TierModel value, $Res Function(_TierModel) _then) = __$TierModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') MemberTier tier, int minPoints
});




}
/// @nodoc
class __$TierModelCopyWithImpl<$Res>
    implements _$TierModelCopyWith<$Res> {
  __$TierModelCopyWithImpl(this._self, this._then);

  final _TierModel _self;
  final $Res Function(_TierModel) _then;

/// Create a copy of TierModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tier = null,Object? minPoints = null,}) {
  return _then(_TierModel(
tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as MemberTier,minPoints: null == minPoints ? _self.minPoints : minPoints // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ChallengeModel {

 String get id; ChallengeTab get tab; String get title; int get goal; int get progress; int get rewardPoints; ChallengeArtwork get artwork; String get imageUrl; int get sortOrder;
/// Create a copy of ChallengeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChallengeModelCopyWith<ChallengeModel> get copyWith => _$ChallengeModelCopyWithImpl<ChallengeModel>(this as ChallengeModel, _$identity);

  /// Serializes this ChallengeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChallengeModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChallengeModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.tab, _this.tab) || other.tab == _this.tab)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.goal, _this.goal) || other.goal == _this.goal)&&(identical(other.progress, _this.progress) || other.progress == _this.progress)&&(identical(other.rewardPoints, _this.rewardPoints) || other.rewardPoints == _this.rewardPoints)&&(identical(other.artwork, _this.artwork) || other.artwork == _this.artwork)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.sortOrder, _this.sortOrder) || other.sortOrder == _this.sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChallengeModel;
  return Object.hash(runtimeType,_this.id,_this.tab,_this.title,_this.goal,_this.progress,_this.rewardPoints,_this.artwork,_this.imageUrl,_this.sortOrder);
}

@override
String toString() {
  final _this = this as ChallengeModel;
  return 'ChallengeModel(id: ${_this.id}, tab: ${_this.tab}, title: ${_this.title}, goal: ${_this.goal}, progress: ${_this.progress}, rewardPoints: ${_this.rewardPoints}, artwork: ${_this.artwork}, imageUrl: ${_this.imageUrl}, sortOrder: ${_this.sortOrder})';
}


}

/// @nodoc
abstract mixin class $ChallengeModelCopyWith<$Res>  {
  factory $ChallengeModelCopyWith(ChallengeModel value, $Res Function(ChallengeModel) _then) = _$ChallengeModelCopyWithImpl;
@useResult
$Res call({
 String id, ChallengeTab tab, String title, int goal, int progress, int rewardPoints, ChallengeArtwork artwork, String imageUrl, int sortOrder
});




}
/// @nodoc
class _$ChallengeModelCopyWithImpl<$Res>
    implements $ChallengeModelCopyWith<$Res> {
  _$ChallengeModelCopyWithImpl(this._self, this._then);

  final ChallengeModel _self;
  final $Res Function(ChallengeModel) _then;

/// Create a copy of ChallengeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tab = null,Object? title = null,Object? goal = null,Object? progress = null,Object? rewardPoints = null,Object? artwork = null,Object? imageUrl = null,Object? sortOrder = null,}) {
  return _then(ChallengeModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tab: null == tab ? _self.tab : tab // ignore: cast_nullable_to_non_nullable
as ChallengeTab,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,goal: null == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as int,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as int,rewardPoints: null == rewardPoints ? _self.rewardPoints : rewardPoints // ignore: cast_nullable_to_non_nullable
as int,artwork: null == artwork ? _self.artwork : artwork // ignore: cast_nullable_to_non_nullable
as ChallengeArtwork,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ChallengeModel].
extension ChallengeModelPatterns on ChallengeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChallengeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChallengeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChallengeModel value)  $default,){
final _that = this;
switch (_that) {
case _ChallengeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChallengeModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChallengeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  ChallengeTab tab,  String title,  int goal,  int progress,  int rewardPoints,  ChallengeArtwork artwork,  String imageUrl,  int sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChallengeModel() when $default != null:
return $default(_that.id,_that.tab,_that.title,_that.goal,_that.progress,_that.rewardPoints,_that.artwork,_that.imageUrl,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  ChallengeTab tab,  String title,  int goal,  int progress,  int rewardPoints,  ChallengeArtwork artwork,  String imageUrl,  int sortOrder)  $default,) {final _that = this;
switch (_that) {
case _ChallengeModel():
return $default(_that.id,_that.tab,_that.title,_that.goal,_that.progress,_that.rewardPoints,_that.artwork,_that.imageUrl,_that.sortOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  ChallengeTab tab,  String title,  int goal,  int progress,  int rewardPoints,  ChallengeArtwork artwork,  String imageUrl,  int sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _ChallengeModel() when $default != null:
return $default(_that.id,_that.tab,_that.title,_that.goal,_that.progress,_that.rewardPoints,_that.artwork,_that.imageUrl,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChallengeModel implements ChallengeModel {
  const _ChallengeModel({required this.id, required this.tab, required this.title, required this.goal, required this.progress, required this.rewardPoints, required this.artwork, required this.imageUrl, required this.sortOrder});
  factory _ChallengeModel.fromJson(Map<String, dynamic> json) => _$ChallengeModelFromJson(json);

@override final  String id;
@override final  ChallengeTab tab;
@override final  String title;
@override final  int goal;
@override final  int progress;
@override final  int rewardPoints;
@override final  ChallengeArtwork artwork;
@override final  String imageUrl;
@override final  int sortOrder;

/// Create a copy of ChallengeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChallengeModelCopyWith<_ChallengeModel> get copyWith => __$ChallengeModelCopyWithImpl<_ChallengeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChallengeModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChallengeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.tab, tab) || other.tab == tab)&&(identical(other.title, title) || other.title == title)&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.rewardPoints, rewardPoints) || other.rewardPoints == rewardPoints)&&(identical(other.artwork, artwork) || other.artwork == artwork)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,tab,title,goal,progress,rewardPoints,artwork,imageUrl,sortOrder);
}

@override
String toString() {
    return 'ChallengeModel(id: $id, tab: $tab, title: $title, goal: $goal, progress: $progress, rewardPoints: $rewardPoints, artwork: $artwork, imageUrl: $imageUrl, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$ChallengeModelCopyWith<$Res> implements $ChallengeModelCopyWith<$Res> {
  factory _$ChallengeModelCopyWith(_ChallengeModel value, $Res Function(_ChallengeModel) _then) = __$ChallengeModelCopyWithImpl;
@override @useResult
$Res call({
 String id, ChallengeTab tab, String title, int goal, int progress, int rewardPoints, ChallengeArtwork artwork, String imageUrl, int sortOrder
});




}
/// @nodoc
class __$ChallengeModelCopyWithImpl<$Res>
    implements _$ChallengeModelCopyWith<$Res> {
  __$ChallengeModelCopyWithImpl(this._self, this._then);

  final _ChallengeModel _self;
  final $Res Function(_ChallengeModel) _then;

/// Create a copy of ChallengeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tab = null,Object? title = null,Object? goal = null,Object? progress = null,Object? rewardPoints = null,Object? artwork = null,Object? imageUrl = null,Object? sortOrder = null,}) {
  return _then(_ChallengeModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tab: null == tab ? _self.tab : tab // ignore: cast_nullable_to_non_nullable
as ChallengeTab,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,goal: null == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as int,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as int,rewardPoints: null == rewardPoints ? _self.rewardPoints : rewardPoints // ignore: cast_nullable_to_non_nullable
as int,artwork: null == artwork ? _self.artwork : artwork // ignore: cast_nullable_to_non_nullable
as ChallengeArtwork,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
