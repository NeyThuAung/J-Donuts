// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'date_of_birth_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DateOfBirthState {

 String get phone; String get firstName; String? get lastName; int? get year; int? get month; int? get day; DateOfBirthValidationError? get validationError; bool get isSubmitting; UserEntity? get registeredUser;
/// Create a copy of DateOfBirthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DateOfBirthStateCopyWith<DateOfBirthState> get copyWith => _$DateOfBirthStateCopyWithImpl<DateOfBirthState>(this as DateOfBirthState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DateOfBirthState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DateOfBirthState&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.firstName, _this.firstName) || other.firstName == _this.firstName)&&(identical(other.lastName, _this.lastName) || other.lastName == _this.lastName)&&(identical(other.year, _this.year) || other.year == _this.year)&&(identical(other.month, _this.month) || other.month == _this.month)&&(identical(other.day, _this.day) || other.day == _this.day)&&(identical(other.validationError, _this.validationError) || other.validationError == _this.validationError)&&(identical(other.isSubmitting, _this.isSubmitting) || other.isSubmitting == _this.isSubmitting)&&(identical(other.registeredUser, _this.registeredUser) || other.registeredUser == _this.registeredUser));
}


@override
int get hashCode {
  final _this = this as DateOfBirthState;
  return Object.hash(runtimeType,_this.phone,_this.firstName,_this.lastName,_this.year,_this.month,_this.day,_this.validationError,_this.isSubmitting,_this.registeredUser);
}

@override
String toString() {
  final _this = this as DateOfBirthState;
  return 'DateOfBirthState(phone: ${_this.phone}, firstName: ${_this.firstName}, lastName: ${_this.lastName}, year: ${_this.year}, month: ${_this.month}, day: ${_this.day}, validationError: ${_this.validationError}, isSubmitting: ${_this.isSubmitting}, registeredUser: ${_this.registeredUser})';
}


}

/// @nodoc
abstract mixin class $DateOfBirthStateCopyWith<$Res>  {
  factory $DateOfBirthStateCopyWith(DateOfBirthState value, $Res Function(DateOfBirthState) _then) = _$DateOfBirthStateCopyWithImpl;
@useResult
$Res call({
 String phone, String firstName, String? lastName, int? year, int? month, int? day, DateOfBirthValidationError? validationError, bool isSubmitting, UserEntity? registeredUser
});




}
/// @nodoc
class _$DateOfBirthStateCopyWithImpl<$Res>
    implements $DateOfBirthStateCopyWith<$Res> {
  _$DateOfBirthStateCopyWithImpl(this._self, this._then);

  final DateOfBirthState _self;
  final $Res Function(DateOfBirthState) _then;

/// Create a copy of DateOfBirthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phone = null,Object? firstName = null,Object? lastName = freezed,Object? year = freezed,Object? month = freezed,Object? day = freezed,Object? validationError = freezed,Object? isSubmitting = null,Object? registeredUser = freezed,}) {
  return _then(DateOfBirthState(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,month: freezed == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int?,day: freezed == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int?,validationError: freezed == validationError ? _self.validationError : validationError // ignore: cast_nullable_to_non_nullable
as DateOfBirthValidationError?,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,registeredUser: freezed == registeredUser ? _self.registeredUser : registeredUser // ignore: cast_nullable_to_non_nullable
as UserEntity?,
  ));
}

}


/// Adds pattern-matching-related methods to [DateOfBirthState].
extension DateOfBirthStatePatterns on DateOfBirthState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DateOfBirthState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DateOfBirthState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DateOfBirthState value)  $default,){
final _that = this;
switch (_that) {
case _DateOfBirthState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DateOfBirthState value)?  $default,){
final _that = this;
switch (_that) {
case _DateOfBirthState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String phone,  String firstName,  String? lastName,  int? year,  int? month,  int? day,  DateOfBirthValidationError? validationError,  bool isSubmitting,  UserEntity? registeredUser)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DateOfBirthState() when $default != null:
return $default(_that.phone,_that.firstName,_that.lastName,_that.year,_that.month,_that.day,_that.validationError,_that.isSubmitting,_that.registeredUser);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String phone,  String firstName,  String? lastName,  int? year,  int? month,  int? day,  DateOfBirthValidationError? validationError,  bool isSubmitting,  UserEntity? registeredUser)  $default,) {final _that = this;
switch (_that) {
case _DateOfBirthState():
return $default(_that.phone,_that.firstName,_that.lastName,_that.year,_that.month,_that.day,_that.validationError,_that.isSubmitting,_that.registeredUser);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String phone,  String firstName,  String? lastName,  int? year,  int? month,  int? day,  DateOfBirthValidationError? validationError,  bool isSubmitting,  UserEntity? registeredUser)?  $default,) {final _that = this;
switch (_that) {
case _DateOfBirthState() when $default != null:
return $default(_that.phone,_that.firstName,_that.lastName,_that.year,_that.month,_that.day,_that.validationError,_that.isSubmitting,_that.registeredUser);case _:
  return null;

}
}

}

/// @nodoc


class _DateOfBirthState extends DateOfBirthState {
  const _DateOfBirthState({this.phone = '', this.firstName = '', this.lastName, this.year, this.month, this.day, this.validationError, this.isSubmitting = false, this.registeredUser}): super._();
  

@override@JsonKey() final  String phone;
@override@JsonKey() final  String firstName;
@override final  String? lastName;
@override final  int? year;
@override final  int? month;
@override final  int? day;
@override final  DateOfBirthValidationError? validationError;
@override@JsonKey() final  bool isSubmitting;
@override final  UserEntity? registeredUser;

/// Create a copy of DateOfBirthState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DateOfBirthStateCopyWith<_DateOfBirthState> get copyWith => __$DateOfBirthStateCopyWithImpl<_DateOfBirthState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DateOfBirthState&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.day, day) || other.day == day)&&(identical(other.validationError, validationError) || other.validationError == validationError)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.registeredUser, registeredUser) || other.registeredUser == registeredUser));
}


@override
int get hashCode {
    return Object.hash(runtimeType,phone,firstName,lastName,year,month,day,validationError,isSubmitting,registeredUser);
}

@override
String toString() {
    return 'DateOfBirthState(phone: $phone, firstName: $firstName, lastName: $lastName, year: $year, month: $month, day: $day, validationError: $validationError, isSubmitting: $isSubmitting, registeredUser: $registeredUser)';
}


}

/// @nodoc
abstract mixin class _$DateOfBirthStateCopyWith<$Res> implements $DateOfBirthStateCopyWith<$Res> {
  factory _$DateOfBirthStateCopyWith(_DateOfBirthState value, $Res Function(_DateOfBirthState) _then) = __$DateOfBirthStateCopyWithImpl;
@override @useResult
$Res call({
 String phone, String firstName, String? lastName, int? year, int? month, int? day, DateOfBirthValidationError? validationError, bool isSubmitting, UserEntity? registeredUser
});




}
/// @nodoc
class __$DateOfBirthStateCopyWithImpl<$Res>
    implements _$DateOfBirthStateCopyWith<$Res> {
  __$DateOfBirthStateCopyWithImpl(this._self, this._then);

  final _DateOfBirthState _self;
  final $Res Function(_DateOfBirthState) _then;

/// Create a copy of DateOfBirthState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phone = null,Object? firstName = null,Object? lastName = freezed,Object? year = freezed,Object? month = freezed,Object? day = freezed,Object? validationError = freezed,Object? isSubmitting = null,Object? registeredUser = freezed,}) {
  return _then(_DateOfBirthState(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,month: freezed == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int?,day: freezed == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int?,validationError: freezed == validationError ? _self.validationError : validationError // ignore: cast_nullable_to_non_nullable
as DateOfBirthValidationError?,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,registeredUser: freezed == registeredUser ? _self.registeredUser : registeredUser // ignore: cast_nullable_to_non_nullable
as UserEntity?,
  ));
}


}

// dart format on
