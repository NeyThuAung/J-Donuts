import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:j_donuts/features/auth/domain/entity/auth_flow.dart';
import 'package:j_donuts/features/auth/domain/usecase/register_usecase.dart';
import 'package:j_donuts/features/auth/domain/usecase/request_otp_usecase.dart';
import 'package:j_donuts/features/auth/domain/usecase/verify_otp_usecase.dart';
import 'package:j_donuts/features/auth/presentation/pages/date_of_birth/cubit/date_of_birth_cubit.dart';
import 'package:j_donuts/features/auth/presentation/pages/name/cubit/name_cubit.dart';
import 'package:j_donuts/features/auth/presentation/pages/phone_number/cubit/phone_number_cubit.dart';
import 'package:j_donuts/features/auth/presentation/pages/phone_number/phone_number_page.dart';
import 'package:j_donuts/features/auth/presentation/pages/verify_otp/cubit/verify_otp_cubit.dart';
import 'package:j_donuts/shared/components/components.dart';
import 'package:mocktail/mocktail.dart';

class _MockRequestOtp extends Mock implements RequestOtpUseCase {}

class _MockVerifyOtp extends Mock implements VerifyOtpUseCase {}

class _MockRegister extends Mock implements RegisterUseCase {}

class _MockSnackShower extends Mock implements ISnackShower {}

/// Router tests build real routes, which inject their page cubits.
void registerPageCubits() {
  final snack = _MockSnackShower();
  GetIt.instance
    ..registerFactory(() => PhoneNumberCubit(_MockRequestOtp(), snack))
    ..registerFactory(
      () => VerifyOtpCubit(_MockVerifyOtp(), _MockRequestOtp(), snack),
    )
    ..registerFactory(NameCubit.new)
    ..registerFactory(() => DateOfBirthCubit(_MockRegister(), snack));
  addTearDown(GetIt.instance.reset);
}

AuthFlow phoneFlowOf(WidgetTester tester) => tester
    .element(find.byType(PhoneNumberPage))
    .read<PhoneNumberCubit>()
    .state
    .flow;
