// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'phone_number_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PhoneNumberState {

 AuthFlow get flow; PhoneValidationError? get validationError; bool get showValidationError; bool get isSubmitting; bool get isWrongFlow; String? get otpSentTo;
/// Create a copy of PhoneNumberState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhoneNumberStateCopyWith<PhoneNumberState> get copyWith => _$PhoneNumberStateCopyWithImpl<PhoneNumberState>(this as PhoneNumberState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PhoneNumberState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhoneNumberState&&(identical(other.flow, _this.flow) || other.flow == _this.flow)&&(identical(other.validationError, _this.validationError) || other.validationError == _this.validationError)&&(identical(other.showValidationError, _this.showValidationError) || other.showValidationError == _this.showValidationError)&&(identical(other.isSubmitting, _this.isSubmitting) || other.isSubmitting == _this.isSubmitting)&&(identical(other.isWrongFlow, _this.isWrongFlow) || other.isWrongFlow == _this.isWrongFlow)&&(identical(other.otpSentTo, _this.otpSentTo) || other.otpSentTo == _this.otpSentTo));
}


@override
int get hashCode {
  final _this = this as PhoneNumberState;
  return Object.hash(runtimeType,_this.flow,_this.validationError,_this.showValidationError,_this.isSubmitting,_this.isWrongFlow,_this.otpSentTo);
}

@override
String toString() {
  final _this = this as PhoneNumberState;
  return 'PhoneNumberState(flow: ${_this.flow}, validationError: ${_this.validationError}, showValidationError: ${_this.showValidationError}, isSubmitting: ${_this.isSubmitting}, isWrongFlow: ${_this.isWrongFlow}, otpSentTo: ${_this.otpSentTo})';
}


}

/// @nodoc
abstract mixin class $PhoneNumberStateCopyWith<$Res>  {
  factory $PhoneNumberStateCopyWith(PhoneNumberState value, $Res Function(PhoneNumberState) _then) = _$PhoneNumberStateCopyWithImpl;
@useResult
$Res call({
 AuthFlow flow, PhoneValidationError? validationError, bool showValidationError, bool isSubmitting, bool isWrongFlow, String? otpSentTo
});




}
/// @nodoc
class _$PhoneNumberStateCopyWithImpl<$Res>
    implements $PhoneNumberStateCopyWith<$Res> {
  _$PhoneNumberStateCopyWithImpl(this._self, this._then);

  final PhoneNumberState _self;
  final $Res Function(PhoneNumberState) _then;

/// Create a copy of PhoneNumberState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? flow = null,Object? validationError = freezed,Object? showValidationError = null,Object? isSubmitting = null,Object? isWrongFlow = null,Object? otpSentTo = freezed,}) {
  return _then(PhoneNumberState(
flow: null == flow ? _self.flow : flow // ignore: cast_nullable_to_non_nullable
as AuthFlow,validationError: freezed == validationError ? _self.validationError : validationError // ignore: cast_nullable_to_non_nullable
as PhoneValidationError?,showValidationError: null == showValidationError ? _self.showValidationError : showValidationError // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isWrongFlow: null == isWrongFlow ? _self.isWrongFlow : isWrongFlow // ignore: cast_nullable_to_non_nullable
as bool,otpSentTo: freezed == otpSentTo ? _self.otpSentTo : otpSentTo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PhoneNumberState].
extension PhoneNumberStatePatterns on PhoneNumberState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhoneNumberState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhoneNumberState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhoneNumberState value)  $default,){
final _that = this;
switch (_that) {
case _PhoneNumberState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhoneNumberState value)?  $default,){
final _that = this;
switch (_that) {
case _PhoneNumberState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AuthFlow flow,  PhoneValidationError? validationError,  bool showValidationError,  bool isSubmitting,  bool isWrongFlow,  String? otpSentTo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhoneNumberState() when $default != null:
return $default(_that.flow,_that.validationError,_that.showValidationError,_that.isSubmitting,_that.isWrongFlow,_that.otpSentTo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AuthFlow flow,  PhoneValidationError? validationError,  bool showValidationError,  bool isSubmitting,  bool isWrongFlow,  String? otpSentTo)  $default,) {final _that = this;
switch (_that) {
case _PhoneNumberState():
return $default(_that.flow,_that.validationError,_that.showValidationError,_that.isSubmitting,_that.isWrongFlow,_that.otpSentTo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AuthFlow flow,  PhoneValidationError? validationError,  bool showValidationError,  bool isSubmitting,  bool isWrongFlow,  String? otpSentTo)?  $default,) {final _that = this;
switch (_that) {
case _PhoneNumberState() when $default != null:
return $default(_that.flow,_that.validationError,_that.showValidationError,_that.isSubmitting,_that.isWrongFlow,_that.otpSentTo);case _:
  return null;

}
}

}

/// @nodoc


class _PhoneNumberState extends PhoneNumberState {
  const _PhoneNumberState({this.flow = AuthFlow.register, this.validationError = PhoneValidationError.empty, this.showValidationError = false, this.isSubmitting = false, this.isWrongFlow = false, this.otpSentTo}): super._();
  

@override@JsonKey() final  AuthFlow flow;
@override@JsonKey() final  PhoneValidationError? validationError;
@override@JsonKey() final  bool showValidationError;
@override@JsonKey() final  bool isSubmitting;
@override@JsonKey() final  bool isWrongFlow;
@override final  String? otpSentTo;

/// Create a copy of PhoneNumberState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhoneNumberStateCopyWith<_PhoneNumberState> get copyWith => __$PhoneNumberStateCopyWithImpl<_PhoneNumberState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneNumberState&&(identical(other.flow, flow) || other.flow == flow)&&(identical(other.validationError, validationError) || other.validationError == validationError)&&(identical(other.showValidationError, showValidationError) || other.showValidationError == showValidationError)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isWrongFlow, isWrongFlow) || other.isWrongFlow == isWrongFlow)&&(identical(other.otpSentTo, otpSentTo) || other.otpSentTo == otpSentTo));
}


@override
int get hashCode {
    return Object.hash(runtimeType,flow,validationError,showValidationError,isSubmitting,isWrongFlow,otpSentTo);
}

@override
String toString() {
    return 'PhoneNumberState(flow: $flow, validationError: $validationError, showValidationError: $showValidationError, isSubmitting: $isSubmitting, isWrongFlow: $isWrongFlow, otpSentTo: $otpSentTo)';
}


}

/// @nodoc
abstract mixin class _$PhoneNumberStateCopyWith<$Res> implements $PhoneNumberStateCopyWith<$Res> {
  factory _$PhoneNumberStateCopyWith(_PhoneNumberState value, $Res Function(_PhoneNumberState) _then) = __$PhoneNumberStateCopyWithImpl;
@override @useResult
$Res call({
 AuthFlow flow, PhoneValidationError? validationError, bool showValidationError, bool isSubmitting, bool isWrongFlow, String? otpSentTo
});




}
/// @nodoc
class __$PhoneNumberStateCopyWithImpl<$Res>
    implements _$PhoneNumberStateCopyWith<$Res> {
  __$PhoneNumberStateCopyWithImpl(this._self, this._then);

  final _PhoneNumberState _self;
  final $Res Function(_PhoneNumberState) _then;

/// Create a copy of PhoneNumberState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? flow = null,Object? validationError = freezed,Object? showValidationError = null,Object? isSubmitting = null,Object? isWrongFlow = null,Object? otpSentTo = freezed,}) {
  return _then(_PhoneNumberState(
flow: null == flow ? _self.flow : flow // ignore: cast_nullable_to_non_nullable
as AuthFlow,validationError: freezed == validationError ? _self.validationError : validationError // ignore: cast_nullable_to_non_nullable
as PhoneValidationError?,showValidationError: null == showValidationError ? _self.showValidationError : showValidationError // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isWrongFlow: null == isWrongFlow ? _self.isWrongFlow : isWrongFlow // ignore: cast_nullable_to_non_nullable
as bool,otpSentTo: freezed == otpSentTo ? _self.otpSentTo : otpSentTo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
