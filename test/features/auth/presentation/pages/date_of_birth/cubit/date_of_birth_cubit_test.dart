import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/core.dart';
import 'package:j_donuts/features/auth/domain/auth_rules.dart';
import 'package:j_donuts/features/auth/domain/entity/registration_request.dart';
import 'package:j_donuts/features/auth/domain/entity/user_entity.dart';
import 'package:j_donuts/features/auth/domain/usecase/register_usecase.dart';
import 'package:j_donuts/features/auth/domain/validators/validators.dart';
import 'package:j_donuts/features/auth/presentation/pages/date_of_birth/cubit/date_of_birth_cubit.dart';
import 'package:j_donuts/shared/components/components.dart';
import 'package:mocktail/mocktail.dart';

class _MockRegister extends Mock implements RegisterUseCase {}

class _MockSnackShower extends Mock implements ISnackShower {}

const _phone = '+959254135592';
final _thisYear = DateTime.now().year;

void main() {
  late _MockRegister register;
  late _MockSnackShower snack;
  late DateOfBirthCubit cubit;

  setUpAll(() {
    registerFallbackValue(
      RegistrationRequest(
        phone: '',
        firstName: '',
        dateOfBirth: DateTime(2000),
      ),
    );
    registerFallbackValue(const CacheFailure());
  });

  setUp(() {
    register = _MockRegister();
    snack = _MockSnackShower();
    cubit = DateOfBirthCubit(register, snack)
      ..start(phone: _phone, firstName: 'Hania', lastName: 'Aung');
  });
  tearDown(() => cubit.close());

  void pick(int year, int month, int day) => cubit
    ..yearPicked(year)
    ..monthPicked(month)
    ..dayPicked(day);

  group('DateOfBirthCubit', () {
    test('opens the wheels on a valid default date', () {
      cubit.startPicking();

      expect(cubit.state.hasDate, isTrue);
      expect(cubit.state.validationError, isNull);
      expect(cubit.state.canSubmit, isTrue);
    });

    test('keeps a picked date when the wheels open again', () {
      pick(1990, 6, 15);
      cubit.startPicking();

      expect(cubit.state.year, 1990);
      expect(cubit.state.day, 15);
    });

    test('rejects a member younger than 13', () {
      pick(_thisYear - AuthRules.minimumAge + 1, 1, 1);

      expect(cubit.state.validationError, DateOfBirthValidationError.tooYoung);
      expect(cubit.state.canSubmit, isFalse);
    });

    test('rejects a date in the future', () {
      pick(_thisYear + 1, 1, 1);

      expect(cubit.state.validationError, isNotNull);
      expect(cubit.state.canSubmit, isFalse);
    });

    test('rejects a day the month does not have', () {
      pick(1990, 4, 31);

      expect(
        cubit.state.validationError,
        DateOfBirthValidationError.invalidDate,
      );
    });

    test('registers the member with every step\'s answers', () async {
      final user = UserEntity(
        id: '1',
        phone: _phone,
        firstName: 'Hania',
        lastName: 'Aung',
        dateOfBirth: DateTime(1990, 6, 15),
      );
      when(() => register(any())).thenAnswer((_) async => Success(user));
      pick(1990, 6, 15);

      await cubit.submit();

      final request =
          verify(() => register(captureAny())).captured.single
              as RegistrationRequest;
      expect(
        request,
        RegistrationRequest(
          phone: _phone,
          firstName: 'Hania',
          lastName: 'Aung',
          dateOfBirth: DateTime(1990, 6, 15),
        ),
      );
      expect(cubit.state.registeredUser, user);
    });

    test('sends one request when Continue is tapped twice', () async {
      when(() => register(any())).thenAnswer(
        (_) async => const Failed(ConnectionFailure()),
      );
      pick(1990, 6, 15);

      await Future.wait([cubit.submit(), cubit.submit()]);

      verify(() => register(any())).called(1);
    });

    test('keeps the date and shows a snack when registering fails', () async {
      when(() => register(any())).thenAnswer(
        (_) async => const Failed(ConnectionFailure()),
      );
      pick(1990, 6, 15);

      await cubit.submit();

      expect(cubit.state.isSubmitting, isFalse);
      expect(cubit.state.year, 1990);
      expect(cubit.state.registeredUser, isNull);
      verify(() => snack.error(any(that: isA<ConnectionFailure>()))).called(1);
    });
  });
}
