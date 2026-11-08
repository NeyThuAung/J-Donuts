import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../shared/components/components.dart';
import '../../../../../shared/extensions/extensions.dart';
import '../../cubit/authentication_cubit.dart';
import '../../widget/auth_step.dart';
import '../../widget/auth_step_scaffold.dart';
import 'cubit/date_of_birth_cubit.dart';
import 'widget/date_fields.dart';

class DateOfBirthArgs {
  const DateOfBirthArgs({
    required this.phone,
    required this.firstName,
    this.lastName,
  });

  final String phone;
  final String firstName;
  final String? lastName;
}

// Expects a DateOfBirthCubit from its route. Registering signs the new member
// in; the router then opens Welcome.
class DateOfBirthPage extends StatelessWidget {
  const DateOfBirthPage({super.key});

  static const routeName = 'date-of-birth';
  static const routePath = '/$routeName';

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AnnotatedRegion(
      value: context.systemOverlayStyle,
      child: BlocListener<DateOfBirthCubit, DateOfBirthState>(
        listenWhen: (previous, current) =>
            current.registeredUser != null &&
            previous.registeredUser != current.registeredUser,
        listener: (context, state) => context
            .read<AuthenticationCubit>()
            .signedIn(state.registeredUser!, isNewMember: true),
        child: AuthStepScaffold(
          step: AuthStep.dateOfBirth,
          title: l10n.authDobTitle,
          body: const DateFields(),
          action: BlocBuilder<DateOfBirthCubit, DateOfBirthState>(
            buildWhen: (previous, current) =>
                previous.canSubmit != current.canSubmit ||
                previous.isSubmitting != current.isSubmitting,
            builder: (context, state) => AppButton(
              label: l10n.commonContinue,
              isLoading: state.isSubmitting,
              onPressed: state.canSubmit
                  ? context.read<DateOfBirthCubit>().submit
                  : null,
            ),
          ),
          onTermsTap: () =>
              showComingSoonSheet(context, title: l10n.authTermsOfUse),
          onPrivacyTap: () =>
              showComingSoonSheet(context, title: l10n.authPrivacyPolicy),
        ),
      ),
    );
  }
}
