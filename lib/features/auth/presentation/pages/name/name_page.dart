import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../navigation/navigation.dart';
import '../../../../../shared/components/components.dart';
import '../../../../../shared/extensions/extensions.dart';
import '../../widget/auth_step.dart';
import '../../widget/auth_step_scaffold.dart';
import '../date_of_birth/date_of_birth_page.dart';
import 'cubit/name_cubit.dart';
import 'widget/name_fields.dart';

class NameArgs {
  const NameArgs({required this.phone});

  /// Verified and normalized.
  final String phone;
}

// Expects a NameCubit from its route.
class NamePage extends StatelessWidget {
  const NamePage({super.key, required this.phone});

  static const routeName = 'name';
  static const routePath = '/$routeName';

  final String phone;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AnnotatedRegion(
      value: context.systemOverlayStyle,
      child: AuthStepScaffold(
        step: AuthStep.name,
        title: l10n.authNameTitle,
        body: NameFields(onDone: () => _continue(context)),
        action: BlocSelector<NameCubit, NameState, bool>(
          selector: (state) => state.canContinue,
          builder: (context, canContinue) => AppButton(
            label: l10n.commonContinue,
            onPressed: canContinue ? () => _continue(context) : null,
          ),
        ),
        onTermsTap: () =>
            showComingSoonSheet(context, title: l10n.authTermsOfUse),
        onPrivacyTap: () =>
            showComingSoonSheet(context, title: l10n.authPrivacyPolicy),
      ),
    );
  }

  // Synchronous check, so the page navigates directly; no listener needed.
  void _continue(BuildContext context) {
    final cubit = context.read<NameCubit>();
    if (!cubit.submit()) return;
    unawaited(
      context.pushDateOfBirthPage(
        DateOfBirthArgs(
          phone: phone,
          firstName: cubit.firstName,
          lastName: cubit.lastName,
        ),
      ),
    );
  }
}
