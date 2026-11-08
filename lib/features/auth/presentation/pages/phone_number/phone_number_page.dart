import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../navigation/navigation.dart';
import '../../../../../shared/components/components.dart';
import '../../../../../shared/extensions/extensions.dart';
import '../../../domain/entity/auth_flow.dart';
import '../../widget/auth_step.dart';
import '../../widget/auth_step_scaffold.dart';
import '../verify_otp/verify_otp_page.dart';
import 'cubit/phone_number_cubit.dart';
import 'widget/phone_continue_button.dart';
import 'widget/phone_number_field.dart';
import 'widget/wrong_flow_message.dart';

// Expects a PhoneNumberCubit from its route.
class PhoneNumberPage extends StatelessWidget {
  const PhoneNumberPage({super.key});

  static const routeName = 'phone-number';
  static const routePath = '/$routeName';
  static const flowParam = 'flow';

  /// Unknown or missing values start the register flow.
  static AuthFlow flowFromQuery(String? value) =>
      AuthFlow.values.asNameMap()[value] ?? AuthFlow.register;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AnnotatedRegion(
      value: context.systemOverlayStyle,
      child: BlocListener<PhoneNumberCubit, PhoneNumberState>(
        listenWhen: (previous, current) =>
            current.otpSentTo != null &&
            previous.otpSentTo != current.otpSentTo,
        listener: (context, state) => unawaited(
          context.pushVerifyOtpPage(
            VerifyOtpArgs(phone: state.otpSentTo!, flow: state.flow),
          ),
        ),
        child: AuthStepScaffold(
          step: AuthStep.phone,
          title: l10n.authPhoneTitle,
          body: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [PhoneNumberField(), WrongFlowMessage()],
          ),
          action: const PhoneContinueButton(),
          onTermsTap: () =>
              showComingSoonSheet(context, title: l10n.authTermsOfUse),
          onPrivacyTap: () =>
              showComingSoonSheet(context, title: l10n.authPrivacyPolicy),
        ),
      ),
    );
  }
}
