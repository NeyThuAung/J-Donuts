import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../navigation/navigation.dart';
import '../../../../../shared/components/components.dart';
import '../../../../../shared/extensions/extensions.dart';
import '../../../../../shared/styles/styles.dart';
import '../../../domain/auth_rules.dart';
import '../../../domain/entity/auth_flow.dart';
import '../../../domain/entity/otp_result.dart';
import '../../cubit/authentication_cubit.dart';
import '../../widget/auth_step.dart';
import '../../widget/auth_step_scaffold.dart';
import '../name/name_page.dart';
import 'cubit/verify_otp_cubit.dart';
import 'widget/otp_code_field.dart';
import 'widget/resend_code.dart';

class VerifyOtpArgs {
  const VerifyOtpArgs({required this.phone, required this.flow});

  /// Normalized, e.g. +959254135592.
  final String phone;
  final AuthFlow flow;
}

// Expects a VerifyOtpCubit from its route. No Continue: the code is checked
// as soon as all digits are in.
class VerifyOtpPage extends StatelessWidget {
  const VerifyOtpPage({super.key, required this.phone});

  static const routeName = 'verify-otp';
  static const routePath = '/$routeName';

  final String phone;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AnnotatedRegion(
      value: context.systemOverlayStyle,
      child: BlocListener<VerifyOtpCubit, VerifyOtpState>(
        listenWhen: (previous, current) =>
            current.result != null && previous.result != current.result,
        listener: (context, state) => _onVerified(context, state.result!),
        child: AuthStepScaffold(
          step: AuthStep.otp,
          title: l10n.authOtpTitle,
          subtitle: Text(
            l10n.authOtpSentTo(AuthRules.otpLength, phone),
            style: context.textTheme.bodyMedium,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const OtpCodeField(),
              $styles.insets.lg.toHeightSizedBox,
              const ResendCode(),
            ],
          ),
          action: null,
          onTermsTap: () =>
              showComingSoonSheet(context, title: l10n.authTermsOfUse),
          onPrivacyTap: () =>
              showComingSoonSheet(context, title: l10n.authPrivacyPolicy),
        ),
      ),
    );
  }

  // A member signs in (the router opens Home); a new number goes on to Name.
  Future<void> _onVerified(BuildContext context, OtpResult result) async {
    switch (result) {
      case OtpSignedIn(:final user):
        context.read<AuthenticationCubit>().signedIn(user);
      case OtpNeedsRegistration():
        final cubit = context.read<VerifyOtpCubit>();
        await context.pushNamePage(NameArgs(phone: phone));
        if (!cubit.isClosed) cubit.resumed();
    }
  }
}
