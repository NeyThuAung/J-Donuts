import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:j_donuts/features/auth/domain/entity/auth_flow.dart';
import 'package:j_donuts/features/auth/domain/usecase/request_otp_usecase.dart';
import 'package:j_donuts/features/auth/presentation/pages/phone_number/cubit/phone_number_cubit.dart';
import 'package:j_donuts/features/auth/presentation/pages/phone_number/phone_number_page.dart';
import 'package:j_donuts/shared/components/components.dart';
import 'package:mocktail/mocktail.dart';

class _MockRequestOtp extends Mock implements RequestOtpUseCase {}

class _MockSnackShower extends Mock implements ISnackShower {}

/// Router tests build real routes, which inject their page cubits.
void registerPageCubits() {
  GetIt.instance.registerFactory(
    () => PhoneNumberCubit(_MockRequestOtp(), _MockSnackShower()),
  );
  addTearDown(GetIt.instance.reset);
}

AuthFlow phoneFlowOf(WidgetTester tester) => tester
    .element(find.byType(PhoneNumberPage))
    .read<PhoneNumberCubit>()
    .state
    .flow;
