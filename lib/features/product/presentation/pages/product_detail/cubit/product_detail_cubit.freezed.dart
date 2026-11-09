// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_detail_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductDetailState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDetailState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ProductDetailState()';
}


}

/// @nodoc
class $ProductDetailStateCopyWith<$Res>  {
$ProductDetailStateCopyWith(ProductDetailState _, $Res Function(ProductDetailState) __);
}


/// Adds pattern-matching-related methods to [ProductDetailState].
extension ProductDetailStatePatterns on ProductDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ProductDetailLoading value)?  loading,TResult Function( ProductDetailReady value)?  ready,TResult Function( ProductDetailNotFound value)?  notFound,TResult Function( ProductDetailError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ProductDetailLoading() when loading != null:
return loading(_that);case ProductDetailReady() when ready != null:
return ready(_that);case ProductDetailNotFound() when notFound != null:
return notFound(_that);case ProductDetailError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ProductDetailLoading value)  loading,required TResult Function( ProductDetailReady value)  ready,required TResult Function( ProductDetailNotFound value)  notFound,required TResult Function( ProductDetailError value)  error,}){
final _that = this;
switch (_that) {
case ProductDetailLoading():
return loading(_that);case ProductDetailReady():
return ready(_that);case ProductDetailNotFound():
return notFound(_that);case ProductDetailError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ProductDetailLoading value)?  loading,TResult? Function( ProductDetailReady value)?  ready,TResult? Function( ProductDetailNotFound value)?  notFound,TResult? Function( ProductDetailError value)?  error,}){
final _that = this;
switch (_that) {
case ProductDetailLoading() when loading != null:
return loading(_that);case ProductDetailReady() when ready != null:
return ready(_that);case ProductDetailNotFound() when notFound != null:
return notFound(_that);case ProductDetailError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( ProductEntity product,  int quantity,  bool justAdded)?  ready,TResult Function()?  notFound,TResult Function( Failure failure)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ProductDetailLoading() when loading != null:
return loading();case ProductDetailReady() when ready != null:
return ready(_that.product,_that.quantity,_that.justAdded);case ProductDetailNotFound() when notFound != null:
return notFound();case ProductDetailError() when error != null:
return error(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( ProductEntity product,  int quantity,  bool justAdded)  ready,required TResult Function()  notFound,required TResult Function( Failure failure)  error,}) {final _that = this;
switch (_that) {
case ProductDetailLoading():
return loading();case ProductDetailReady():
return ready(_that.product,_that.quantity,_that.justAdded);case ProductDetailNotFound():
return notFound();case ProductDetailError():
return error(_that.failure);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( ProductEntity product,  int quantity,  bool justAdded)?  ready,TResult? Function()?  notFound,TResult? Function( Failure failure)?  error,}) {final _that = this;
switch (_that) {
case ProductDetailLoading() when loading != null:
return loading();case ProductDetailReady() when ready != null:
return ready(_that.product,_that.quantity,_that.justAdded);case ProductDetailNotFound() when notFound != null:
return notFound();case ProductDetailError() when error != null:
return error(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class ProductDetailLoading implements ProductDetailState {
  const ProductDetailLoading();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDetailLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ProductDetailState.loading()';
}


}




/// @nodoc


class ProductDetailReady implements ProductDetailState {
  const ProductDetailReady({required this.product, this.quantity = CartRules.minQuantity, this.justAdded = false});
  

 final  ProductEntity product;
@JsonKey() final  int quantity;
/// True for a moment after Add to cart, for the button's added state.
@JsonKey() final  bool justAdded;

/// Create a copy of ProductDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductDetailReadyCopyWith<ProductDetailReady> get copyWith => _$ProductDetailReadyCopyWithImpl<ProductDetailReady>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDetailReady&&(identical(other.product, product) || other.product == product)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.justAdded, justAdded) || other.justAdded == justAdded));
}


@override
int get hashCode {
    return Object.hash(runtimeType,product,quantity,justAdded);
}

@override
String toString() {
    return 'ProductDetailState.ready(product: $product, quantity: $quantity, justAdded: $justAdded)';
}


}

/// @nodoc
abstract mixin class $ProductDetailReadyCopyWith<$Res> implements $ProductDetailStateCopyWith<$Res> {
  factory $ProductDetailReadyCopyWith(ProductDetailReady value, $Res Function(ProductDetailReady) _then) = _$ProductDetailReadyCopyWithImpl;
@useResult
$Res call({
 ProductEntity product, int quantity, bool justAdded
});


$ProductEntityCopyWith<$Res> get product;

}
/// @nodoc
class _$ProductDetailReadyCopyWithImpl<$Res>
    implements $ProductDetailReadyCopyWith<$Res> {
  _$ProductDetailReadyCopyWithImpl(this._self, this._then);

  final ProductDetailReady _self;
  final $Res Function(ProductDetailReady) _then;

/// Create a copy of ProductDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? product = null,Object? quantity = null,Object? justAdded = null,}) {
  return _then(ProductDetailReady(
product: null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as ProductEntity,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,justAdded: null == justAdded ? _self.justAdded : justAdded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ProductDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductEntityCopyWith<$Res> get product {
  
  return $ProductEntityCopyWith<$Res>(_self.product, (value) {
    return _then(_self.copyWith(product: value));
  });
}
}

/// @nodoc


class ProductDetailNotFound implements ProductDetailState {
  const ProductDetailNotFound();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDetailNotFound);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ProductDetailState.notFound()';
}


}




/// @nodoc


class ProductDetailError implements ProductDetailState {
  const ProductDetailError(this.failure);
  

 final  Failure failure;

/// Create a copy of ProductDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductDetailErrorCopyWith<ProductDetailError> get copyWith => _$ProductDetailErrorCopyWithImpl<ProductDetailError>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDetailError&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,failure);
}

@override
String toString() {
    return 'ProductDetailState.error(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $ProductDetailErrorCopyWith<$Res> implements $ProductDetailStateCopyWith<$Res> {
  factory $ProductDetailErrorCopyWith(ProductDetailError value, $Res Function(ProductDetailError) _then) = _$ProductDetailErrorCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$ProductDetailErrorCopyWithImpl<$Res>
    implements $ProductDetailErrorCopyWith<$Res> {
  _$ProductDetailErrorCopyWithImpl(this._self, this._then);

  final ProductDetailError _self;
  final $Res Function(ProductDetailError) _then;

/// Create a copy of ProductDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(ProductDetailError(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
