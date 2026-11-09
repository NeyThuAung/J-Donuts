// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'section_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SectionData<T> {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SectionData<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SectionData<$T>()';
}


}

/// @nodoc
class $SectionDataCopyWith<T,$Res>  {
$SectionDataCopyWith(SectionData<T> _, $Res Function(SectionData<T>) __);
}


/// Adds pattern-matching-related methods to [SectionData].
extension SectionDataPatterns<T> on SectionData<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SectionLoading<T> value)?  loading,TResult Function( SectionReady<T> value)?  ready,TResult Function( SectionFailed<T> value)?  failed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SectionLoading() when loading != null:
return loading(_that);case SectionReady() when ready != null:
return ready(_that);case SectionFailed() when failed != null:
return failed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SectionLoading<T> value)  loading,required TResult Function( SectionReady<T> value)  ready,required TResult Function( SectionFailed<T> value)  failed,}){
final _that = this;
switch (_that) {
case SectionLoading():
return loading(_that);case SectionReady():
return ready(_that);case SectionFailed():
return failed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SectionLoading<T> value)?  loading,TResult? Function( SectionReady<T> value)?  ready,TResult? Function( SectionFailed<T> value)?  failed,}){
final _that = this;
switch (_that) {
case SectionLoading() when loading != null:
return loading(_that);case SectionReady() when ready != null:
return ready(_that);case SectionFailed() when failed != null:
return failed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( T data)?  ready,TResult Function( Failure failure)?  failed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SectionLoading() when loading != null:
return loading();case SectionReady() when ready != null:
return ready(_that.data);case SectionFailed() when failed != null:
return failed(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( T data)  ready,required TResult Function( Failure failure)  failed,}) {final _that = this;
switch (_that) {
case SectionLoading():
return loading();case SectionReady():
return ready(_that.data);case SectionFailed():
return failed(_that.failure);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( T data)?  ready,TResult? Function( Failure failure)?  failed,}) {final _that = this;
switch (_that) {
case SectionLoading() when loading != null:
return loading();case SectionReady() when ready != null:
return ready(_that.data);case SectionFailed() when failed != null:
return failed(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class SectionLoading<T> implements SectionData<T> {
  const SectionLoading();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SectionLoading<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SectionData<$T>.loading()';
}


}




/// @nodoc


class SectionReady<T> implements SectionData<T> {
  const SectionReady(this.data);
  

 final  T data;

/// Create a copy of SectionData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SectionReadyCopyWith<T, SectionReady<T>> get copyWith => _$SectionReadyCopyWithImpl<T, SectionReady<T>>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SectionReady<T>&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(data));
}

@override
String toString() {
    return 'SectionData<$T>.ready(data: $data)';
}


}

/// @nodoc
abstract mixin class $SectionReadyCopyWith<T,$Res> implements $SectionDataCopyWith<T, $Res> {
  factory $SectionReadyCopyWith(SectionReady<T> value, $Res Function(SectionReady<T>) _then) = _$SectionReadyCopyWithImpl;
@useResult
$Res call({
 T data
});




}
/// @nodoc
class _$SectionReadyCopyWithImpl<T,$Res>
    implements $SectionReadyCopyWith<T, $Res> {
  _$SectionReadyCopyWithImpl(this._self, this._then);

  final SectionReady<T> _self;
  final $Res Function(SectionReady<T>) _then;

/// Create a copy of SectionData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,}) {
  return _then(SectionReady<T>(
freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc


class SectionFailed<T> implements SectionData<T> {
  const SectionFailed(this.failure);
  

 final  Failure failure;

/// Create a copy of SectionData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SectionFailedCopyWith<T, SectionFailed<T>> get copyWith => _$SectionFailedCopyWithImpl<T, SectionFailed<T>>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SectionFailed<T>&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,failure);
}

@override
String toString() {
    return 'SectionData<$T>.failed(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $SectionFailedCopyWith<T,$Res> implements $SectionDataCopyWith<T, $Res> {
  factory $SectionFailedCopyWith(SectionFailed<T> value, $Res Function(SectionFailed<T>) _then) = _$SectionFailedCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$SectionFailedCopyWithImpl<T,$Res>
    implements $SectionFailedCopyWith<T, $Res> {
  _$SectionFailedCopyWithImpl(this._self, this._then);

  final SectionFailed<T> _self;
  final $Res Function(SectionFailed<T>) _then;

/// Create a copy of SectionData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(SectionFailed<T>(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
