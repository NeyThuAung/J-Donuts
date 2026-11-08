import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../l10n/l10n.dart';
import '../../../../../../shared/components/components.dart';
import '../cubit/phone_number_cubit.dart';

class PhoneContinueButton extends StatelessWidget {
  const PhoneContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhoneNumberCubit, PhoneNumberState>(
      buildWhen: (previous, current) =>
          previous.canSubmit != current.canSubmit ||
          previous.isSubmitting != current.isSubmitting,
      builder: (context, state) => AppButton(
        label: context.l10n.commonContinue,
        isLoading: state.isSubmitting,
        onPressed: state.canSubmit
            ? context.read<PhoneNumberCubit>().submit
            : null,
      ),
    );
  }
}
