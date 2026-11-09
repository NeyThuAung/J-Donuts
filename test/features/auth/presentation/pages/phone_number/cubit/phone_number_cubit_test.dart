import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/core.dart';
import 'package:j_donuts/features/auth/domain/entity/auth_flow.dart';
import 'package:j_donuts/features/auth/domain/failure/auth_failure.dart';
import 'package:j_donuts/features/auth/domain/usecase/request_otp_usecase.dart';
import 'package:j_donuts/features/auth/domain/validators/validators.dart';
import 'package:j_donuts/features/auth/presentation/pages/phone_number/cubit/phone_number_cubit.dart';
import 'package:j_donuts/shared/components/components.dart';
import 'package:mocktail/mocktail.dart';

class _MockRequestOtp extends Mock implements RequestOtpUseCase {}

class _MockSnackShower extends Mock implements ISnackShower {}

const _validInput = '09 254 135 592';
const _normalized = '+959254135592';

void main() {
  late _MockRequestOtp requestOtp;
  late _MockSnackShower snack;

  setUpAll(() {
    registerFallbackValue(
      const RequestOtpParam(phone: '', flow: AuthFlow.register),
    );
    registerFallbackValue(const CacheFailure());
  });

  setUp(() {
    requestOtp = _MockRequestOtp();
    snack = _MockSnackShower();
  });

  PhoneNumberCubit build({AuthFlow flow = AuthFlow.register}) {
    final cubit = PhoneNumberCubit(requestOtp, snack)..start(flow);
    return cubit;
  }

  void typePhone(PhoneNumberCubit cubit, String input) {
    cubit.phoneController.text = input;
    cubit.phoneChanged(input);
  }

  void whenRequest(DataState<void> result) =>
      when(() => requestOtp(any())).thenAnswer((_) async => result);

  group('PhoneNumberCubit', () {
    test('keeps Continue disabled until the number is valid', () {
      final cubit = build();
      addTearDown(cubit.close);

      expect(cubit.state.canSubmit, isFalse);
      typePhone(cubit, '0925');
      expect(cubit.state.validationError, PhoneValidationError.tooShort);
      expect(cubit.state.canSubmit, isFalse);
      typePhone(cubit, _validInput);
      expect(cubit.state.canSubmit, isTrue);
    });

    test('shows the error only after the field loses focus', () {
      final cubit = build();
      addTearDown(cubit.close);

      typePhone(cubit, '0825');
      expect(cubit.state.visibleError, isNull);
      cubit.fieldLeft();
      expect(cubit.state.visibleError, PhoneValidationError.wrongLeadingDigit);
    });

    test('reveals the error instead of sending an invalid number', () async {
      final cubit = build();
      addTearDown(cubit.close);
      typePhone(cubit, '0925');

      await cubit.submit();

      expect(cubit.state.visibleError, PhoneValidationError.tooShort);
      verifyNever(() => requestOtp(any()));
    });

    test(
      'sends the code to the normalized number in the chosen flow',
      () async {
        whenRequest(const Success(null));
        final cubit = build(flow: AuthFlow.logIn);
        addTearDown(cubit.close);
        typePhone(cubit, _validInput);

        await cubit.submit();

        final param =
            verify(() => requestOtp(captureAny())).captured.single
                as RequestOtpParam;
        expect(param.phone, _normalized);
        expect(param.flow, AuthFlow.logIn);
        expect(cubit.state.otpSentTo, _normalized);
        expect(cubit.state.isSubmitting, isFalse);
      },
    );

    test('sends one request when Continue is tapped twice', () async {
      whenRequest(const Success(null));
      final cubit = build();
      addTearDown(cubit.close);
      typePhone(cubit, _validInput);

      await Future.wait([cubit.submit(), cubit.submit()]);

      verify(() => requestOtp(any())).called(1);
    });

    test(
      'shows the inline register link when logging in with a new number',
      () async {
        whenRequest(const Failed(PhoneNotRegisteredFailure()));
        final cubit = build(flow: AuthFlow.logIn);
        addTearDown(cubit.close);
        typePhone(cubit, _validInput);

        await cubit.submit();

        expect(cubit.state.isWrongFlow, isTrue);
        expect(cubit.state.otpSentTo, isNull);
        verifyNever(() => snack.error(any()));
      },
    );

    test('shows the inline link when registering a known number', () async {
      whenRequest(const Failed(PhoneAlreadyRegisteredFailure()));
      final cubit = build();
      addTearDown(cubit.close);
      typePhone(cubit, _validInput);

      await cubit.submit();

      expect(cubit.state.isWrongFlow, isTrue);
    });

    test('reports any other failure in a snack', () async {
      whenRequest(const Failed(ConnectionFailure()));
      final cubit = build();
      addTearDown(cubit.close);
      typePhone(cubit, _validInput);

      await cubit.submit();

      expect(cubit.state.isWrongFlow, isFalse);
      verify(() => snack.error(any(that: isA<ConnectionFailure>()))).called(1);
    });

    test('switchFlow resends the same number in the other flow', () async {
      when(
        () => requestOtp(
          any(
            that: isA<RequestOtpParam>().having(
              (p) => p.flow,
              'flow',
              AuthFlow.logIn,
            ),
          ),
        ),
      ).thenAnswer((_) async => const Failed(PhoneNotRegisteredFailure()));
      when(
        () => requestOtp(
          any(
            that: isA<RequestOtpParam>().having(
              (p) => p.flow,
              'flow',
              AuthFlow.register,
            ),
          ),
        ),
      ).thenAnswer((_) async => const Success(null));
      final cubit = build(flow: AuthFlow.logIn);
      addTearDown(cubit.close);
      typePhone(cubit, _validInput);
      await cubit.submit();

      await cubit.switchFlow();

      expect(cubit.state.flow, AuthFlow.register);
      expect(cubit.state.isWrongFlow, isFalse);
      expect(cubit.state.otpSentTo, _normalized);
    });

    blocTest<PhoneNumberCubit, PhoneNumberState>(
      'hides the wrong-flow message as soon as the number is edited',
      setUp: () => whenRequest(const Failed(PhoneNotRegisteredFailure())),
      build: () => build(flow: AuthFlow.logIn),
      act: (cubit) async {
        typePhone(cubit, _validInput);
        await cubit.submit();
        typePhone(cubit, '09254135593');
      },
      verify: (cubit) => expect(cubit.state.isWrongFlow, isFalse),
    );
  });
}
