import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../l10n/l10n.dart';
import '../../../../../../shared/components/components.dart';
import '../../../../../../shared/extensions/extensions.dart';
import '../../../../../../shared/styles/styles.dart';
import '../../../../domain/validators/validators.dart';
import '../../../widget/validation_messages.dart';
import '../cubit/name_cubit.dart';

class NameFields extends StatelessWidget {
  const NameFields({super.key, required this.onDone});

  /// Done on the last-name keyboard; same as Continue.
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NameCubit>();
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BlocSelector<NameCubit, NameState, NameValidationError?>(
          selector: (state) => state.visibleFirstNameError,
          builder: (context, error) => AppTextField(
            controller: cubit.firstNameController,
            hintText: l10n.authNameFirstHint,
            errorText: error?.message(l10n),
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.givenName],
            onChanged: cubit.firstNameChanged,
            onFocusLost: cubit.firstNameLeft,
          ),
        ),
        $styles.insets.md.toHeightSizedBox,
        BlocSelector<NameCubit, NameState, NameValidationError?>(
          selector: (state) => state.visibleLastNameError,
          builder: (context, error) => AppTextField(
            controller: cubit.lastNameController,
            hintText: l10n.authNameLastHint,
            errorText: error?.message(l10n),
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.familyName],
            onChanged: cubit.lastNameChanged,
            onSubmitted: (_) => onDone(),
            onFocusLost: cubit.lastNameLeft,
          ),
        ),
      ],
    );
  }
}
