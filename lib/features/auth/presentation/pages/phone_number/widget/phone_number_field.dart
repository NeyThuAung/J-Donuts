import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../l10n/l10n.dart';
import '../../../../../../shared/components/components.dart';
import '../../../../domain/auth_rules.dart';
import '../../../../domain/validators/validators.dart';
import '../../../widget/validation_messages.dart';
import '../cubit/phone_number_cubit.dart';

// Digits plus the spaces, dashes and + people paste; the validator strips them.
final _allowedCharacters = FilteringTextInputFormatter.allow(
  RegExp(r'[\d\s+-]'),
);
// "+95 09 254 135 592" with separators, plus a little slack.
const _maxInputLength = 20;

class PhoneNumberField extends StatelessWidget {
  const PhoneNumberField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PhoneNumberCubit>();
    final l10n = context.l10n;
    return BlocSelector<
      PhoneNumberCubit,
      PhoneNumberState,
      PhoneValidationError?
    >(
      selector: (state) => state.visibleError,
      builder: (context, error) => AppTextField(
        controller: cubit.phoneController,
        hintText: l10n.authPhoneHint,
        prefixText: AuthRules.countryCode,
        errorText: error?.message(l10n),
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.done,
        autofillHints: const [AutofillHints.telephoneNumberNational],
        inputFormatters: [
          _allowedCharacters,
          LengthLimitingTextInputFormatter(_maxInputLength),
        ],
        onChanged: cubit.phoneChanged,
        onSubmitted: (_) => cubit.submit(),
        onFocusLost: cubit.fieldLeft,
      ),
    );
  }
}
