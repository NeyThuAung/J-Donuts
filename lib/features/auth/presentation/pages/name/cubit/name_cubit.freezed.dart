// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'name_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NameState {

 NameValidationError? get firstNameError; NameValidationError? get lastNameError; bool get showFirstNameError; bool get showLastNameError;
/// Create a copy of NameState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NameStateCopyWith<NameState> get copyWith => _$NameStateCopyWithImpl<NameState>(this as NameState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as NameState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NameState&&(identical(other.firstNameError, _this.firstNameError) || other.firstNameError == _this.firstNameError)&&(identical(other.lastNameError, _this.lastNameError) || other.lastNameError == _this.lastNameError)&&(identical(other.showFirstNameError, _this.showFirstNameError) || other.showFirstNameError == _this.showFirstNameError)&&(identical(other.showLastNameError, _this.showLastNameError) || other.showLastNameError == _this.showLastNameError));
}


@override
int get hashCode {
  final _this = this as NameState;
  return Object.hash(runtimeType,_this.firstNameError,_this.lastNameError,_this.showFirstNameError,_this.showLastNameError);
}

@override
String toString() {
  final _this = this as NameState;
  return 'NameState(firstNameError: ${_this.firstNameError}, lastNameError: ${_this.lastNameError}, showFirstNameError: ${_this.showFirstNameError}, showLastNameError: ${_this.showLastNameError})';
}


}

/// @nodoc
abstract mixin class $NameStateCopyWith<$Res>  {
  factory $NameStateCopyWith(NameState value, $Res Function(NameState) _then) = _$NameStateCopyWithImpl;
@useResult
$Res call({
 NameValidationError? firstNameError, NameValidationError? lastNameError, bool showFirstNameError, bool showLastNameError
});




}
/// @nodoc
class _$NameStateCopyWithImpl<$Res>
    implements $NameStateCopyWith<$Res> {
  _$NameStateCopyWithImpl(this._self, this._then);

  final NameState _self;
  final $Res Function(NameState) _then;

/// Create a copy of NameState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstNameError = freezed,Object? lastNameError = freezed,Object? showFirstNameError = null,Object? showLastNameError = null,}) {
  return _then(NameState(
firstNameError: freezed == firstNameError ? _self.firstNameError : firstNameError // ignore: cast_nullable_to_non_nullable
as NameValidationError?,lastNameError: freezed == lastNameError ? _self.lastNameError : lastNameError // ignore: cast_nullable_to_non_nullable
as NameValidationError?,showFirstNameError: null == showFirstNameError ? _self.showFirstNameError : showFirstNameError // ignore: cast_nullable_to_non_nullable
as bool,showLastNameError: null == showLastNameError ? _self.showLastNameError : showLastNameError // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NameState].
extension NameStatePatterns on NameState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NameState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NameState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NameState value)  $default,){
final _that = this;
switch (_that) {
case _NameState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NameState value)?  $default,){
final _that = this;
switch (_that) {
case _NameState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( NameValidationError? firstNameError,  NameValidationError? lastNameError,  bool showFirstNameError,  bool showLastNameError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NameState() when $default != null:
return $default(_that.firstNameError,_that.lastNameError,_that.showFirstNameError,_that.showLastNameError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( NameValidationError? firstNameError,  NameValidationError? lastNameError,  bool showFirstNameError,  bool showLastNameError)  $default,) {final _that = this;
switch (_that) {
case _NameState():
return $default(_that.firstNameError,_that.lastNameError,_that.showFirstNameError,_that.showLastNameError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( NameValidationError? firstNameError,  NameValidationError? lastNameError,  bool showFirstNameError,  bool showLastNameError)?  $default,) {final _that = this;
switch (_that) {
case _NameState() when $default != null:
return $default(_that.firstNameError,_that.lastNameError,_that.showFirstNameError,_that.showLastNameError);case _:
  return null;

}
}

}

/// @nodoc


class _NameState extends NameState {
  const _NameState({this.firstNameError = NameValidationError.empty, this.lastNameError, this.showFirstNameError = false, this.showLastNameError = false}): super._();
  

@override@JsonKey() final  NameValidationError? firstNameError;
@override final  NameValidationError? lastNameError;
@override@JsonKey() final  bool showFirstNameError;
@override@JsonKey() final  bool showLastNameError;

/// Create a copy of NameState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NameStateCopyWith<_NameState> get copyWith => __$NameStateCopyWithImpl<_NameState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NameState&&(identical(other.firstNameError, firstNameError) || other.firstNameError == firstNameError)&&(identical(other.lastNameError, lastNameError) || other.lastNameError == lastNameError)&&(identical(other.showFirstNameError, showFirstNameError) || other.showFirstNameError == showFirstNameError)&&(identical(other.showLastNameError, showLastNameError) || other.showLastNameError == showLastNameError));
}


@override
int get hashCode {
    return Object.hash(runtimeType,firstNameError,lastNameError,showFirstNameError,showLastNameError);
}

@override
String toString() {
    return 'NameState(firstNameError: $firstNameError, lastNameError: $lastNameError, showFirstNameError: $showFirstNameError, showLastNameError: $showLastNameError)';
}


}

/// @nodoc
abstract mixin class _$NameStateCopyWith<$Res> implements $NameStateCopyWith<$Res> {
  factory _$NameStateCopyWith(_NameState value, $Res Function(_NameState) _then) = __$NameStateCopyWithImpl;
@override @useResult
$Res call({
 NameValidationError? firstNameError, NameValidationError? lastNameError, bool showFirstNameError, bool showLastNameError
});




}
/// @nodoc
class __$NameStateCopyWithImpl<$Res>
    implements _$NameStateCopyWith<$Res> {
  __$NameStateCopyWithImpl(this._self, this._then);

  final _NameState _self;
  final $Res Function(_NameState) _then;

/// Create a copy of NameState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstNameError = freezed,Object? lastNameError = freezed,Object? showFirstNameError = null,Object? showLastNameError = null,}) {
  return _then(_NameState(
firstNameError: freezed == firstNameError ? _self.firstNameError : firstNameError // ignore: cast_nullable_to_non_nullable
as NameValidationError?,lastNameError: freezed == lastNameError ? _self.lastNameError : lastNameError // ignore: cast_nullable_to_non_nullable
as NameValidationError?,showFirstNameError: null == showFirstNameError ? _self.showFirstNameError : showFirstNameError // ignore: cast_nullable_to_non_nullable
as bool,showLastNameError: null == showLastNameError ? _self.showLastNameError : showLastNameError // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
