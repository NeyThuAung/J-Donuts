// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_section_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeSectionLayout {

 String get id; HomeSectionType get type; List<String> get productIds;
/// Create a copy of HomeSectionLayout
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeSectionLayoutCopyWith<HomeSectionLayout> get copyWith => _$HomeSectionLayoutCopyWithImpl<HomeSectionLayout>(this as HomeSectionLayout, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HomeSectionLayout;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeSectionLayout&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.type, _this.type) || other.type == _this.type)&&const DeepCollectionEquality().equals(other.productIds, _this.productIds));
}


@override
int get hashCode {
  final _this = this as HomeSectionLayout;
  return Object.hash(runtimeType,_this.id,_this.type,const DeepCollectionEquality().hash(_this.productIds));
}

@override
String toString() {
  final _this = this as HomeSectionLayout;
  return 'HomeSectionLayout(id: ${_this.id}, type: ${_this.type}, productIds: ${_this.productIds})';
}


}

/// @nodoc
abstract mixin class $HomeSectionLayoutCopyWith<$Res>  {
  factory $HomeSectionLayoutCopyWith(HomeSectionLayout value, $Res Function(HomeSectionLayout) _then) = _$HomeSectionLayoutCopyWithImpl;
@useResult
$Res call({
 String id, HomeSectionType type, List<String> productIds
});




}
/// @nodoc
class _$HomeSectionLayoutCopyWithImpl<$Res>
    implements $HomeSectionLayoutCopyWith<$Res> {
  _$HomeSectionLayoutCopyWithImpl(this._self, this._then);

  final HomeSectionLayout _self;
  final $Res Function(HomeSectionLayout) _then;

/// Create a copy of HomeSectionLayout
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? productIds = null,}) {
  return _then(HomeSectionLayout(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as HomeSectionType,productIds: null == productIds ? _self.productIds : productIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeSectionLayout].
extension HomeSectionLayoutPatterns on HomeSectionLayout {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeSectionLayout value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeSectionLayout() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeSectionLayout value)  $default,){
final _that = this;
switch (_that) {
case _HomeSectionLayout():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeSectionLayout value)?  $default,){
final _that = this;
switch (_that) {
case _HomeSectionLayout() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  HomeSectionType type,  List<String> productIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeSectionLayout() when $default != null:
return $default(_that.id,_that.type,_that.productIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  HomeSectionType type,  List<String> productIds)  $default,) {final _that = this;
switch (_that) {
case _HomeSectionLayout():
return $default(_that.id,_that.type,_that.productIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  HomeSectionType type,  List<String> productIds)?  $default,) {final _that = this;
switch (_that) {
case _HomeSectionLayout() when $default != null:
return $default(_that.id,_that.type,_that.productIds);case _:
  return null;

}
}

}

/// @nodoc


class _HomeSectionLayout implements HomeSectionLayout {
  const _HomeSectionLayout({required this.id, required this.type, required  List<String> productIds}): _productIds = productIds;
  

@override final  String id;
@override final  HomeSectionType type;
 final  List<String> _productIds;
@override List<String> get productIds {
  if (_productIds is EqualUnmodifiableListView) return _productIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_productIds);
}


/// Create a copy of HomeSectionLayout
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeSectionLayoutCopyWith<_HomeSectionLayout> get copyWith => __$HomeSectionLayoutCopyWithImpl<_HomeSectionLayout>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeSectionLayout&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.productIds, _productIds));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,type,const DeepCollectionEquality().hash(_productIds));
}

@override
String toString() {
    return 'HomeSectionLayout(id: $id, type: $type, productIds: $productIds)';
}


}

/// @nodoc
abstract mixin class _$HomeSectionLayoutCopyWith<$Res> implements $HomeSectionLayoutCopyWith<$Res> {
  factory _$HomeSectionLayoutCopyWith(_HomeSectionLayout value, $Res Function(_HomeSectionLayout) _then) = __$HomeSectionLayoutCopyWithImpl;
@override @useResult
$Res call({
 String id, HomeSectionType type, List<String> productIds
});




}
/// @nodoc
class __$HomeSectionLayoutCopyWithImpl<$Res>
    implements _$HomeSectionLayoutCopyWith<$Res> {
  __$HomeSectionLayoutCopyWithImpl(this._self, this._then);

  final _HomeSectionLayout _self;
  final $Res Function(_HomeSectionLayout) _then;

/// Create a copy of HomeSectionLayout
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? productIds = null,}) {
  return _then(_HomeSectionLayout(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as HomeSectionType,productIds: null == productIds ? _self._productIds : productIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
mixin _$HomeSectionEntity {

 String get id; HomeSectionType get type; List<ProductEntity> get products;
/// Create a copy of HomeSectionEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeSectionEntityCopyWith<HomeSectionEntity> get copyWith => _$HomeSectionEntityCopyWithImpl<HomeSectionEntity>(this as HomeSectionEntity, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HomeSectionEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeSectionEntity&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.type, _this.type) || other.type == _this.type)&&const DeepCollectionEquality().equals(other.products, _this.products));
}


@override
int get hashCode {
  final _this = this as HomeSectionEntity;
  return Object.hash(runtimeType,_this.id,_this.type,const DeepCollectionEquality().hash(_this.products));
}

@override
String toString() {
  final _this = this as HomeSectionEntity;
  return 'HomeSectionEntity(id: ${_this.id}, type: ${_this.type}, products: ${_this.products})';
}


}

/// @nodoc
abstract mixin class $HomeSectionEntityCopyWith<$Res>  {
  factory $HomeSectionEntityCopyWith(HomeSectionEntity value, $Res Function(HomeSectionEntity) _then) = _$HomeSectionEntityCopyWithImpl;
@useResult
$Res call({
 String id, HomeSectionType type, List<ProductEntity> products
});




}
/// @nodoc
class _$HomeSectionEntityCopyWithImpl<$Res>
    implements $HomeSectionEntityCopyWith<$Res> {
  _$HomeSectionEntityCopyWithImpl(this._self, this._then);

  final HomeSectionEntity _self;
  final $Res Function(HomeSectionEntity) _then;

/// Create a copy of HomeSectionEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? products = null,}) {
  return _then(HomeSectionEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as HomeSectionType,products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<ProductEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeSectionEntity].
extension HomeSectionEntityPatterns on HomeSectionEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeSectionEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeSectionEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeSectionEntity value)  $default,){
final _that = this;
switch (_that) {
case _HomeSectionEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeSectionEntity value)?  $default,){
final _that = this;
switch (_that) {
case _HomeSectionEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  HomeSectionType type,  List<ProductEntity> products)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeSectionEntity() when $default != null:
return $default(_that.id,_that.type,_that.products);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  HomeSectionType type,  List<ProductEntity> products)  $default,) {final _that = this;
switch (_that) {
case _HomeSectionEntity():
return $default(_that.id,_that.type,_that.products);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  HomeSectionType type,  List<ProductEntity> products)?  $default,) {final _that = this;
switch (_that) {
case _HomeSectionEntity() when $default != null:
return $default(_that.id,_that.type,_that.products);case _:
  return null;

}
}

}

/// @nodoc


class _HomeSectionEntity implements HomeSectionEntity {
  const _HomeSectionEntity({required this.id, required this.type, required  List<ProductEntity> products}): _products = products;
  

@override final  String id;
@override final  HomeSectionType type;
 final  List<ProductEntity> _products;
@override List<ProductEntity> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}


/// Create a copy of HomeSectionEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeSectionEntityCopyWith<_HomeSectionEntity> get copyWith => __$HomeSectionEntityCopyWithImpl<_HomeSectionEntity>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeSectionEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.products, _products));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,type,const DeepCollectionEquality().hash(_products));
}

@override
String toString() {
    return 'HomeSectionEntity(id: $id, type: $type, products: $products)';
}


}

/// @nodoc
abstract mixin class _$HomeSectionEntityCopyWith<$Res> implements $HomeSectionEntityCopyWith<$Res> {
  factory _$HomeSectionEntityCopyWith(_HomeSectionEntity value, $Res Function(_HomeSectionEntity) _then) = __$HomeSectionEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, HomeSectionType type, List<ProductEntity> products
});




}
/// @nodoc
class __$HomeSectionEntityCopyWithImpl<$Res>
    implements _$HomeSectionEntityCopyWith<$Res> {
  __$HomeSectionEntityCopyWithImpl(this._self, this._then);

  final _HomeSectionEntity _self;
  final $Res Function(_HomeSectionEntity) _then;

/// Create a copy of HomeSectionEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? products = null,}) {
  return _then(_HomeSectionEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as HomeSectionType,products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<ProductEntity>,
  ));
}


}

// dart format on
