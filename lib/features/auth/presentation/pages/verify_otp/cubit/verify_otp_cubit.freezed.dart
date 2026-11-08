// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_otp_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VerifyOtpState {

 String get phone; AuthFlow get flow; Duration get resendIn; int get wrongAttempts; bool get showWrongCode; int get shakeCount; bool get isVerifying; bool get isResending; OtpResult? get result;
/// Create a copy of VerifyOtpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyOtpStateCopyWith<VerifyOtpState> get copyWith => _$VerifyOtpStateCopyWithImpl<VerifyOtpState>(this as VerifyOtpState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as VerifyOtpState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyOtpState&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.flow, _this.flow) || other.flow == _this.flow)&&(identical(other.resendIn, _this.resendIn) || other.resendIn == _this.resendIn)&&(identical(other.wrongAttempts, _this.wrongAttempts) || other.wrongAttempts == _this.wrongAttempts)&&(identical(other.showWrongCode, _this.showWrongCode) || other.showWrongCode == _this.showWrongCode)&&(identical(other.shakeCount, _this.shakeCount) || other.shakeCount == _this.shakeCount)&&(identical(other.isVerifying, _this.isVerifying) || other.isVerifying == _this.isVerifying)&&(identical(other.isResending, _this.isResending) || other.isResending == _this.isResending)&&(identical(other.result, _this.result) || other.result == _this.result));
}


@override
int get hashCode {
  final _this = this as VerifyOtpState;
  return Object.hash(runtimeType,_this.phone,_this.flow,_this.resendIn,_this.wrongAttempts,_this.showWrongCode,_this.shakeCount,_this.isVerifying,_this.isResending,_this.result);
}

@override
String toString() {
  final _this = this as VerifyOtpState;
  return 'VerifyOtpState(phone: ${_this.phone}, flow: ${_this.flow}, resendIn: ${_this.resendIn}, wrongAttempts: ${_this.wrongAttempts}, showWrongCode: ${_this.showWrongCode}, shakeCount: ${_this.shakeCount}, isVerifying: ${_this.isVerifying}, isResending: ${_this.isResending}, result: ${_this.result})';
}


}

/// @nodoc
abstract mixin class $VerifyOtpStateCopyWith<$Res>  {
  factory $VerifyOtpStateCopyWith(VerifyOtpState value, $Res Function(VerifyOtpState) _then) = _$VerifyOtpStateCopyWithImpl;
@useResult
$Res call({
 String phone, AuthFlow flow, Duration resendIn, int wrongAttempts, bool showWrongCode, int shakeCount, bool isVerifying, bool isResending, OtpResult? result
});




}
/// @nodoc
class _$VerifyOtpStateCopyWithImpl<$Res>
    implements $VerifyOtpStateCopyWith<$Res> {
  _$VerifyOtpStateCopyWithImpl(this._self, this._then);

  final VerifyOtpState _self;
  final $Res Function(VerifyOtpState) _then;

/// Create a copy of VerifyOtpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phone = null,Object? flow = null,Object? resendIn = null,Object? wrongAttempts = null,Object? showWrongCode = null,Object? shakeCount = null,Object? isVerifying = null,Object? isResending = null,Object? result = freezed,}) {
  return _then(VerifyOtpState(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,flow: null == flow ? _self.flow : flow // ignore: cast_nullable_to_non_nullable
as AuthFlow,resendIn: null == resendIn ? _self.resendIn : resendIn // ignore: cast_nullable_to_non_nullable
as Duration,wrongAttempts: null == wrongAttempts ? _self.wrongAttempts : wrongAttempts // ignore: cast_nullable_to_non_nullable
as int,showWrongCode: null == showWrongCode ? _self.showWrongCode : showWrongCode // ignore: cast_nullable_to_non_nullable
as bool,shakeCount: null == shakeCount ? _self.shakeCount : shakeCount // ignore: cast_nullable_to_non_nullable
as int,isVerifying: null == isVerifying ? _self.isVerifying : isVerifying // ignore: cast_nullable_to_non_nullable
as bool,isResending: null == isResending ? _self.isResending : isResending // ignore: cast_nullable_to_non_nullable
as bool,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as OtpResult?,
  ));
}

}


/// Adds pattern-matching-related methods to [VerifyOtpState].
extension VerifyOtpStatePatterns on VerifyOtpState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerifyOtpState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerifyOtpState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerifyOtpState value)  $default,){
final _that = this;
switch (_that) {
case _VerifyOtpState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerifyOtpState value)?  $default,){
final _that = this;
switch (_that) {
case _VerifyOtpState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String phone,  AuthFlow flow,  Duration resendIn,  int wrongAttempts,  bool showWrongCode,  int shakeCount,  bool isVerifying,  bool isResending,  OtpResult? result)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerifyOtpState() when $default != null:
return $default(_that.phone,_that.flow,_that.resendIn,_that.wrongAttempts,_that.showWrongCode,_that.shakeCount,_that.isVerifying,_that.isResending,_that.result);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String phone,  AuthFlow flow,  Duration resendIn,  int wrongAttempts,  bool showWrongCode,  int shakeCount,  bool isVerifying,  bool isResending,  OtpResult? result)  $default,) {final _that = this;
switch (_that) {
case _VerifyOtpState():
return $default(_that.phone,_that.flow,_that.resendIn,_that.wrongAttempts,_that.showWrongCode,_that.shakeCount,_that.isVerifying,_that.isResending,_that.result);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String phone,  AuthFlow flow,  Duration resendIn,  int wrongAttempts,  bool showWrongCode,  int shakeCount,  bool isVerifying,  bool isResending,  OtpResult? result)?  $default,) {final _that = this;
switch (_that) {
case _VerifyOtpState() when $default != null:
return $default(_that.phone,_that.flow,_that.resendIn,_that.wrongAttempts,_that.showWrongCode,_that.shakeCount,_that.isVerifying,_that.isResending,_that.result);case _:
  return null;

}
}

}

/// @nodoc


class _VerifyOtpState extends VerifyOtpState {
  const _VerifyOtpState({this.phone = '', this.flow = AuthFlow.register, this.resendIn = AuthRules.resendCountdown, this.wrongAttempts = 0, this.showWrongCode = false, this.shakeCount = 0, this.isVerifying = false, this.isResending = false, this.result}): super._();
  

@override@JsonKey() final  String phone;
@override@JsonKey() final  AuthFlow flow;
@override@JsonKey() final  Duration resendIn;
@override@JsonKey() final  int wrongAttempts;
@override@JsonKey() final  bool showWrongCode;
@override@JsonKey() final  int shakeCount;
@override@JsonKey() final  bool isVerifying;
@override@JsonKey() final  bool isResending;
@override final  OtpResult? result;

/// Create a copy of VerifyOtpState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyOtpStateCopyWith<_VerifyOtpState> get copyWith => __$VerifyOtpStateCopyWithImpl<_VerifyOtpState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyOtpState&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.flow, flow) || other.flow == flow)&&(identical(other.resendIn, resendIn) || other.resendIn == resendIn)&&(identical(other.wrongAttempts, wrongAttempts) || other.wrongAttempts == wrongAttempts)&&(identical(other.showWrongCode, showWrongCode) || other.showWrongCode == showWrongCode)&&(identical(other.shakeCount, shakeCount) || other.shakeCount == shakeCount)&&(identical(other.isVerifying, isVerifying) || other.isVerifying == isVerifying)&&(identical(other.isResending, isResending) || other.isResending == isResending)&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode {
    return Object.hash(runtimeType,phone,flow,resendIn,wrongAttempts,showWrongCode,shakeCount,isVerifying,isResending,result);
}

@override
String toString() {
    return 'VerifyOtpState(phone: $phone, flow: $flow, resendIn: $resendIn, wrongAttempts: $wrongAttempts, showWrongCode: $showWrongCode, shakeCount: $shakeCount, isVerifying: $isVerifying, isResending: $isResending, result: $result)';
}


}

/// @nodoc
abstract mixin class _$VerifyOtpStateCopyWith<$Res> implements $VerifyOtpStateCopyWith<$Res> {
  factory _$VerifyOtpStateCopyWith(_VerifyOtpState value, $Res Function(_VerifyOtpState) _then) = __$VerifyOtpStateCopyWithImpl;
@override @useResult
$Res call({
 String phone, AuthFlow flow, Duration resendIn, int wrongAttempts, bool showWrongCode, int shakeCount, bool isVerifying, bool isResending, OtpResult? result
});




}
/// @nodoc
class __$VerifyOtpStateCopyWithImpl<$Res>
    implements _$VerifyOtpStateCopyWith<$Res> {
  __$VerifyOtpStateCopyWithImpl(this._self, this._then);

  final _VerifyOtpState _self;
  final $Res Function(_VerifyOtpState) _then;

/// Create a copy of VerifyOtpState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phone = null,Object? flow = null,Object? resendIn = null,Object? wrongAttempts = null,Object? showWrongCode = null,Object? shakeCount = null,Object? isVerifying = null,Object? isResending = null,Object? result = freezed,}) {
  return _then(_VerifyOtpState(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,flow: null == flow ? _self.flow : flow // ignore: cast_nullable_to_non_nullable
as AuthFlow,resendIn: null == resendIn ? _self.resendIn : resendIn // ignore: cast_nullable_to_non_nullable
as Duration,wrongAttempts: null == wrongAttempts ? _self.wrongAttempts : wrongAttempts // ignore: cast_nullable_to_non_nullable
as int,showWrongCode: null == showWrongCode ? _self.showWrongCode : showWrongCode // ignore: cast_nullable_to_non_nullable
as bool,shakeCount: null == shakeCount ? _self.shakeCount : shakeCount // ignore: cast_nullable_to_non_nullable
as int,isVerifying: null == isVerifying ? _self.isVerifying : isVerifying // ignore: cast_nullable_to_non_nullable
as bool,isResending: null == isResending ? _self.isResending : isResending // ignore: cast_nullable_to_non_nullable
as bool,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as OtpResult?,
  ));
}


}

// dart format on
