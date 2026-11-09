// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeState {

 SectionData<MemberEntity?> get member; SectionData<List<BannerEntity>> get banners; SectionData<List<HomeSectionEntity>> get sections; SectionData<List<ShopEntity>> get shops;
/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeStateCopyWith<HomeState> get copyWith => _$HomeStateCopyWithImpl<HomeState>(this as HomeState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HomeState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeState&&(identical(other.member, _this.member) || other.member == _this.member)&&(identical(other.banners, _this.banners) || other.banners == _this.banners)&&(identical(other.sections, _this.sections) || other.sections == _this.sections)&&(identical(other.shops, _this.shops) || other.shops == _this.shops));
}


@override
int get hashCode {
  final _this = this as HomeState;
  return Object.hash(runtimeType,_this.member,_this.banners,_this.sections,_this.shops);
}

@override
String toString() {
  final _this = this as HomeState;
  return 'HomeState(member: ${_this.member}, banners: ${_this.banners}, sections: ${_this.sections}, shops: ${_this.shops})';
}


}

/// @nodoc
abstract mixin class $HomeStateCopyWith<$Res>  {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) _then) = _$HomeStateCopyWithImpl;
@useResult
$Res call({
 SectionData<MemberEntity?> member, SectionData<List<BannerEntity>> banners, SectionData<List<HomeSectionEntity>> sections, SectionData<List<ShopEntity>> shops
});


$SectionDataCopyWith<MemberEntity?, $Res> get member;$SectionDataCopyWith<List<BannerEntity>, $Res> get banners;$SectionDataCopyWith<List<HomeSectionEntity>, $Res> get sections;$SectionDataCopyWith<List<ShopEntity>, $Res> get shops;

}
/// @nodoc
class _$HomeStateCopyWithImpl<$Res>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._self, this._then);

  final HomeState _self;
  final $Res Function(HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? member = null,Object? banners = null,Object? sections = null,Object? shops = null,}) {
  return _then(HomeState(
member: null == member ? _self.member : member // ignore: cast_nullable_to_non_nullable
as SectionData<MemberEntity?>,banners: null == banners ? _self.banners : banners // ignore: cast_nullable_to_non_nullable
as SectionData<List<BannerEntity>>,sections: null == sections ? _self.sections : sections // ignore: cast_nullable_to_non_nullable
as SectionData<List<HomeSectionEntity>>,shops: null == shops ? _self.shops : shops // ignore: cast_nullable_to_non_nullable
as SectionData<List<ShopEntity>>,
  ));
}
/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SectionDataCopyWith<MemberEntity?, $Res> get member {
  
  return $SectionDataCopyWith<MemberEntity?, $Res>(_self.member, (value) {
    return _then(_self.copyWith(member: value));
  });
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SectionDataCopyWith<List<BannerEntity>, $Res> get banners {
  
  return $SectionDataCopyWith<List<BannerEntity>, $Res>(_self.banners, (value) {
    return _then(_self.copyWith(banners: value));
  });
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SectionDataCopyWith<List<HomeSectionEntity>, $Res> get sections {
  
  return $SectionDataCopyWith<List<HomeSectionEntity>, $Res>(_self.sections, (value) {
    return _then(_self.copyWith(sections: value));
  });
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SectionDataCopyWith<List<ShopEntity>, $Res> get shops {
  
  return $SectionDataCopyWith<List<ShopEntity>, $Res>(_self.shops, (value) {
    return _then(_self.copyWith(shops: value));
  });
}
}


/// Adds pattern-matching-related methods to [HomeState].
extension HomeStatePatterns on HomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeState value)  $default,){
final _that = this;
switch (_that) {
case _HomeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeState value)?  $default,){
final _that = this;
switch (_that) {
case _HomeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SectionData<MemberEntity?> member,  SectionData<List<BannerEntity>> banners,  SectionData<List<HomeSectionEntity>> sections,  SectionData<List<ShopEntity>> shops)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeState() when $default != null:
return $default(_that.member,_that.banners,_that.sections,_that.shops);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SectionData<MemberEntity?> member,  SectionData<List<BannerEntity>> banners,  SectionData<List<HomeSectionEntity>> sections,  SectionData<List<ShopEntity>> shops)  $default,) {final _that = this;
switch (_that) {
case _HomeState():
return $default(_that.member,_that.banners,_that.sections,_that.shops);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SectionData<MemberEntity?> member,  SectionData<List<BannerEntity>> banners,  SectionData<List<HomeSectionEntity>> sections,  SectionData<List<ShopEntity>> shops)?  $default,) {final _that = this;
switch (_that) {
case _HomeState() when $default != null:
return $default(_that.member,_that.banners,_that.sections,_that.shops);case _:
  return null;

}
}

}

/// @nodoc


class _HomeState implements HomeState {
  const _HomeState({this.member = const SectionLoading<MemberEntity?>(), this.banners = const SectionLoading<List<BannerEntity>>(), this.sections = const SectionLoading<List<HomeSectionEntity>>(), this.shops = const SectionLoading<List<ShopEntity>>()});
  

@override@JsonKey() final  SectionData<MemberEntity?> member;
@override@JsonKey() final  SectionData<List<BannerEntity>> banners;
@override@JsonKey() final  SectionData<List<HomeSectionEntity>> sections;
@override@JsonKey() final  SectionData<List<ShopEntity>> shops;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeStateCopyWith<_HomeState> get copyWith => __$HomeStateCopyWithImpl<_HomeState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeState&&(identical(other.member, member) || other.member == member)&&(identical(other.banners, banners) || other.banners == banners)&&(identical(other.sections, sections) || other.sections == sections)&&(identical(other.shops, shops) || other.shops == shops));
}


@override
int get hashCode {
    return Object.hash(runtimeType,member,banners,sections,shops);
}

@override
String toString() {
    return 'HomeState(member: $member, banners: $banners, sections: $sections, shops: $shops)';
}


}

/// @nodoc
abstract mixin class _$HomeStateCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory _$HomeStateCopyWith(_HomeState value, $Res Function(_HomeState) _then) = __$HomeStateCopyWithImpl;
@override @useResult
$Res call({
 SectionData<MemberEntity?> member, SectionData<List<BannerEntity>> banners, SectionData<List<HomeSectionEntity>> sections, SectionData<List<ShopEntity>> shops
});


@override $SectionDataCopyWith<MemberEntity?, $Res> get member;@override $SectionDataCopyWith<List<BannerEntity>, $Res> get banners;@override $SectionDataCopyWith<List<HomeSectionEntity>, $Res> get sections;@override $SectionDataCopyWith<List<ShopEntity>, $Res> get shops;

}
/// @nodoc
class __$HomeStateCopyWithImpl<$Res>
    implements _$HomeStateCopyWith<$Res> {
  __$HomeStateCopyWithImpl(this._self, this._then);

  final _HomeState _self;
  final $Res Function(_HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? member = null,Object? banners = null,Object? sections = null,Object? shops = null,}) {
  return _then(_HomeState(
member: null == member ? _self.member : member // ignore: cast_nullable_to_non_nullable
as SectionData<MemberEntity?>,banners: null == banners ? _self.banners : banners // ignore: cast_nullable_to_non_nullable
as SectionData<List<BannerEntity>>,sections: null == sections ? _self.sections : sections // ignore: cast_nullable_to_non_nullable
as SectionData<List<HomeSectionEntity>>,shops: null == shops ? _self.shops : shops // ignore: cast_nullable_to_non_nullable
as SectionData<List<ShopEntity>>,
  ));
}

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SectionDataCopyWith<MemberEntity?, $Res> get member {
  
  return $SectionDataCopyWith<MemberEntity?, $Res>(_self.member, (value) {
    return _then(_self.copyWith(member: value));
  });
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SectionDataCopyWith<List<BannerEntity>, $Res> get banners {
  
  return $SectionDataCopyWith<List<BannerEntity>, $Res>(_self.banners, (value) {
    return _then(_self.copyWith(banners: value));
  });
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SectionDataCopyWith<List<HomeSectionEntity>, $Res> get sections {
  
  return $SectionDataCopyWith<List<HomeSectionEntity>, $Res>(_self.sections, (value) {
    return _then(_self.copyWith(sections: value));
  });
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SectionDataCopyWith<List<ShopEntity>, $Res> get shops {
  
  return $SectionDataCopyWith<List<ShopEntity>, $Res>(_self.shops, (value) {
    return _then(_self.copyWith(shops: value));
  });
}
}

// dart format on
