import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../l10n/l10n.dart';
import '../../../../../../shared/components/components.dart';
import '../../../../../../shared/extensions/extensions.dart';
import '../../../../../../shared/styles/styles.dart';
import '../../../../domain/auth_rules.dart';
import '../cubit/verify_otp_cubit.dart';
import 'otp_code_input.dart';

// The boxes plus the wrong-code / locked message under them.
class OtpCodeField extends StatelessWidget {
  const OtpCodeField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VerifyOtpCubit>();
    return BlocBuilder<VerifyOtpCubit, VerifyOtpState>(
      buildWhen: (previous, current) =>
          previous.canType != current.canType ||
          previous.showWrongCode != current.showWrongCode ||
          previous.shakeCount != current.shakeCount ||
          previous.isLocked != current.isLocked,
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OtpCodeInput(
            controller: cubit.codeController,
            length: AuthRules.otpLength,
            semanticsLabel: context.l10n.authOtpCodeLabel,
            onChanged: cubit.codeChanged,
            enabled: state.canType,
            hasError: state.showWrongCode,
            shakeCount: state.shakeCount,
          ),
          AppAnimatedSize(
            duration: AppMotion.fieldState,
            child: _Message(text: _message(context.l10n, state)),
          ),
        ],
      ),
    );
  }

  String? _message(AppLocalizations l10n, VerifyOtpState state) {
    if (state.isLocked) return l10n.authOtpLocked;
    if (state.showWrongCode) return l10n.authOtpWrongCode(state.attemptsLeft);
    return null;
  }
}

class _Message extends StatelessWidget {
  const _Message({required this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    final text = this.text;
    if (text == null) return const SizedBox(width: double.infinity);
    return Padding(
      padding: EdgeInsets.only(top: $styles.insets.xs),
      child: Semantics(
        liveRegion: true,
        child: Text(
          text,
          style: context.textTheme.bodySmall?.copyWith(
            color: context.appColors.accent,
          ),
        ),
      ),
    );
  }
}
