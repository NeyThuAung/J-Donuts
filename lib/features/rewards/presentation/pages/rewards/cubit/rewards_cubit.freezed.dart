// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rewards_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RewardsState {

 SectionData<TierProgressEntity?> get progress; SectionData<List<ChallengeEntity>> get challenges; ChallengeTab get tab;
/// Create a copy of RewardsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RewardsStateCopyWith<RewardsState> get copyWith => _$RewardsStateCopyWithImpl<RewardsState>(this as RewardsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RewardsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RewardsState&&(identical(other.progress, _this.progress) || other.progress == _this.progress)&&(identical(other.challenges, _this.challenges) || other.challenges == _this.challenges)&&(identical(other.tab, _this.tab) || other.tab == _this.tab));
}


@override
int get hashCode {
  final _this = this as RewardsState;
  return Object.hash(runtimeType,_this.progress,_this.challenges,_this.tab);
}

@override
String toString() {
  final _this = this as RewardsState;
  return 'RewardsState(progress: ${_this.progress}, challenges: ${_this.challenges}, tab: ${_this.tab})';
}


}

/// @nodoc
abstract mixin class $RewardsStateCopyWith<$Res>  {
  factory $RewardsStateCopyWith(RewardsState value, $Res Function(RewardsState) _then) = _$RewardsStateCopyWithImpl;
@useResult
$Res call({
 SectionData<TierProgressEntity?> progress, SectionData<List<ChallengeEntity>> challenges, ChallengeTab tab
});


$SectionDataCopyWith<TierProgressEntity?, $Res> get progress;$SectionDataCopyWith<List<ChallengeEntity>, $Res> get challenges;

}
/// @nodoc
class _$RewardsStateCopyWithImpl<$Res>
    implements $RewardsStateCopyWith<$Res> {
  _$RewardsStateCopyWithImpl(this._self, this._then);

  final RewardsState _self;
  final $Res Function(RewardsState) _then;

/// Create a copy of RewardsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? progress = null,Object? challenges = null,Object? tab = null,}) {
  return _then(RewardsState(
progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as SectionData<TierProgressEntity?>,challenges: null == challenges ? _self.challenges : challenges // ignore: cast_nullable_to_non_nullable
as SectionData<List<ChallengeEntity>>,tab: null == tab ? _self.tab : tab // ignore: cast_nullable_to_non_nullable
as ChallengeTab,
  ));
}
/// Create a copy of RewardsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SectionDataCopyWith<TierProgressEntity?, $Res> get progress {
  
  return $SectionDataCopyWith<TierProgressEntity?, $Res>(_self.progress, (value) {
    return _then(_self.copyWith(progress: value));
  });
}/// Create a copy of RewardsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SectionDataCopyWith<List<ChallengeEntity>, $Res> get challenges {
  
  return $SectionDataCopyWith<List<ChallengeEntity>, $Res>(_self.challenges, (value) {
    return _then(_self.copyWith(challenges: value));
  });
}
}


/// Adds pattern-matching-related methods to [RewardsState].
extension RewardsStatePatterns on RewardsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RewardsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RewardsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RewardsState value)  $default,){
final _that = this;
switch (_that) {
case _RewardsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RewardsState value)?  $default,){
final _that = this;
switch (_that) {
case _RewardsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SectionData<TierProgressEntity?> progress,  SectionData<List<ChallengeEntity>> challenges,  ChallengeTab tab)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RewardsState() when $default != null:
return $default(_that.progress,_that.challenges,_that.tab);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SectionData<TierProgressEntity?> progress,  SectionData<List<ChallengeEntity>> challenges,  ChallengeTab tab)  $default,) {final _that = this;
switch (_that) {
case _RewardsState():
return $default(_that.progress,_that.challenges,_that.tab);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SectionData<TierProgressEntity?> progress,  SectionData<List<ChallengeEntity>> challenges,  ChallengeTab tab)?  $default,) {final _that = this;
switch (_that) {
case _RewardsState() when $default != null:
return $default(_that.progress,_that.challenges,_that.tab);case _:
  return null;

}
}

}

/// @nodoc


class _RewardsState extends RewardsState {
  const _RewardsState({this.progress = const SectionLoading<TierProgressEntity?>(), this.challenges = const SectionLoading<List<ChallengeEntity>>(), this.tab = ChallengeTab.earn}): super._();
  

@override@JsonKey() final  SectionData<TierProgressEntity?> progress;
@override@JsonKey() final  SectionData<List<ChallengeEntity>> challenges;
@override@JsonKey() final  ChallengeTab tab;

/// Create a copy of RewardsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RewardsStateCopyWith<_RewardsState> get copyWith => __$RewardsStateCopyWithImpl<_RewardsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RewardsState&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.challenges, challenges) || other.challenges == challenges)&&(identical(other.tab, tab) || other.tab == tab));
}


@override
int get hashCode {
    return Object.hash(runtimeType,progress,challenges,tab);
}

@override
String toString() {
    return 'RewardsState(progress: $progress, challenges: $challenges, tab: $tab)';
}


}

/// @nodoc
abstract mixin class _$RewardsStateCopyWith<$Res> implements $RewardsStateCopyWith<$Res> {
  factory _$RewardsStateCopyWith(_RewardsState value, $Res Function(_RewardsState) _then) = __$RewardsStateCopyWithImpl;
@override @useResult
$Res call({
 SectionData<TierProgressEntity?> progress, SectionData<List<ChallengeEntity>> challenges, ChallengeTab tab
});


@override $SectionDataCopyWith<TierProgressEntity?, $Res> get progress;@override $SectionDataCopyWith<List<ChallengeEntity>, $Res> get challenges;

}
/// @nodoc
class __$RewardsStateCopyWithImpl<$Res>
    implements _$RewardsStateCopyWith<$Res> {
  __$RewardsStateCopyWithImpl(this._self, this._then);

  final _RewardsState _self;
  final $Res Function(_RewardsState) _then;

/// Create a copy of RewardsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? progress = null,Object? challenges = null,Object? tab = null,}) {
  return _then(_RewardsState(
progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as SectionData<TierProgressEntity?>,challenges: null == challenges ? _self.challenges : challenges // ignore: cast_nullable_to_non_nullable
as SectionData<List<ChallengeEntity>>,tab: null == tab ? _self.tab : tab // ignore: cast_nullable_to_non_nullable
as ChallengeTab,
  ));
}

/// Create a copy of RewardsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SectionDataCopyWith<TierProgressEntity?, $Res> get progress {
  
  return $SectionDataCopyWith<TierProgressEntity?, $Res>(_self.progress, (value) {
    return _then(_self.copyWith(progress: value));
  });
}/// Create a copy of RewardsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SectionDataCopyWith<List<ChallengeEntity>, $Res> get challenges {
  
  return $SectionDataCopyWith<List<ChallengeEntity>, $Res>(_self.challenges, (value) {
    return _then(_self.copyWith(challenges: value));
  });
}
}

// dart format on
