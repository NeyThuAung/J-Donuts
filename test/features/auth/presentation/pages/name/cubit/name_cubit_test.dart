import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/features/auth/domain/validators/validators.dart';
import 'package:j_donuts/features/auth/presentation/pages/name/cubit/name_cubit.dart';

void main() {
  late NameCubit cubit;

  setUp(() => cubit = NameCubit());
  tearDown(() => cubit.close());

  void typeFirst(String input) {
    cubit.firstNameController.text = input;
    cubit.firstNameChanged(input);
  }

  void typeLast(String input) {
    cubit.lastNameController.text = input;
    cubit.lastNameChanged(input);
  }

  group('NameCubit', () {
    test('needs a first name before Continue is enabled', () {
      expect(cubit.state.canContinue, isFalse);
      typeFirst('Hania');
      expect(cubit.state.canContinue, isTrue);
    });

    test('rejects digits in the first name', () {
      typeFirst('Hania2');
      expect(cubit.state.firstNameError, NameValidationError.containsDigits);
      expect(cubit.state.canContinue, isFalse);
    });

    test('accepts a Burmese first name', () {
      typeFirst('ဟနိယ');
      expect(cubit.state.firstNameError, isNull);
    });

    test('lets the last name stay empty', () {
      typeFirst('Hania');
      typeLast('');
      expect(cubit.state.canContinue, isTrue);
      expect(cubit.lastName, isNull);
    });

    test('blocks Continue when the optional last name is invalid', () {
      typeFirst('Hania');
      typeLast('Aung1');
      expect(cubit.state.lastNameError, NameValidationError.containsDigits);
      expect(cubit.state.canContinue, isFalse);
    });

    test('shows each message only after its field loses focus', () {
      typeFirst('1');
      expect(cubit.state.visibleFirstNameError, isNull);
      cubit.firstNameLeft();
      expect(
        cubit.state.visibleFirstNameError,
        NameValidationError.containsDigits,
      );
    });

    test('submit reveals both messages when a name is invalid', () {
      expect(cubit.submit(), isFalse);
      expect(cubit.state.visibleFirstNameError, NameValidationError.empty);
    });

    test('passes trimmed names on when both are valid', () {
      typeFirst('  Hania   Min ');
      typeLast(' Aung ');
      expect(cubit.submit(), isTrue);
      expect(cubit.firstName, 'Hania Min');
      expect(cubit.lastName, 'Aung');
    });
  });
}
