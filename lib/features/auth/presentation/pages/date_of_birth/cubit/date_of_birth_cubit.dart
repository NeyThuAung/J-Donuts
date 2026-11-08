import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../shared/components/components.dart';
import '../../../../domain/entity/registration_request.dart';
import '../../../../domain/entity/user_entity.dart';
import '../../../../domain/usecase/register_usecase.dart';
import '../../../../domain/validators/validators.dart';

part 'date_of_birth_cubit.freezed.dart';
part 'date_of_birth_state.dart';

// Where the wheels start when nothing is picked yet: 1 January, this many
// years ago.
const _initialAge = 25;

@injectable
class DateOfBirthCubit extends Cubit<DateOfBirthState> {
  DateOfBirthCubit(this._register, this._snack)
    : super(const DateOfBirthState());

  final RegisterUseCase _register;
  final ISnackShower _snack;

  void start({
    required String phone,
    required String firstName,
    String? lastName,
  }) => emit(
    state.copyWith(phone: phone, firstName: firstName, lastName: lastName),
  );

  /// The wheels open on a full date, so the fields fill in at once.
  void startPicking() {
    if (state.hasDate) return;
    _pick(year: DateTime.now().year - _initialAge, month: 1, day: 1);
  }

  void monthPicked(int month) => _pick(month: month);

  void dayPicked(int day) => _pick(day: day);

  void yearPicked(int year) => _pick(year: year);

  /// Ignored while a request is running, so a double tap sends one request.
  Future<void> submit() async {
    if (!state.canSubmit) return;
    emit(state.copyWith(isSubmitting: true));
    final result = await _register(
      RegistrationRequest(
        phone: state.phone,
        firstName: state.firstName,
        lastName: state.lastName,
        dateOfBirth: DateTime(state.year!, state.month!, state.day!),
      ),
    );
    if (isClosed) return;
    result
      ..onSuccess(
        (user) =>
            emit(state.copyWith(isSubmitting: false, registeredUser: user)),
      )
      ..onError((failure) {
        emit(state.copyWith(isSubmitting: false));
        _snack.error(failure);
      });
  }

  void _pick({int? year, int? month, int? day}) {
    final next = state.copyWith(
      year: year ?? state.year,
      month: month ?? state.month,
      day: day ?? state.day,
    );
    emit(next.copyWith(validationError: _validate(next)));
  }

  DateOfBirthValidationError? _validate(DateOfBirthState date) {
    if (!date.hasDate) return null;
    return validateDateOfBirth(
      year: date.year!,
      month: date.month!,
      day: date.day!,
      today: DateTime.now(),
    );
  }
}
