import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../l10n/l10n.dart';
import '../../../../../../shared/extensions/extensions.dart';
import '../../../../../../shared/styles/styles.dart';
import '../cubit/verify_otp_cubit.dart';

// The countdown text is one translated sentence; the time is cut out of it by
// marker so it can be highlighted in any word order.
const _timeMarker = '{time}';

// "Didn't receive the code? resend in 4:58 min", then a Resend link at 0:00.
class ResendCode extends StatelessWidget {
  const ResendCode({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final style = context.textTheme.bodyMedium;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.authOtpNoCode, style: style),
        BlocBuilder<VerifyOtpCubit, VerifyOtpState>(
          buildWhen: (previous, current) =>
              previous.resendIn != current.resendIn ||
              previous.canResend != current.canResend,
          builder: (context, state) => AnimatedSwitcher(
            duration: context.motion(AppMotion.fieldState),
            child: state.resendIn == Duration.zero
                ? _ResendButton(enabled: state.canResend)
                : _Countdown(remaining: state.resendIn),
          ),
        ),
      ],
    );
  }
}

class _Countdown extends StatelessWidget {
  const _Countdown({required this.remaining});

  final Duration remaining;

  @override
  Widget build(BuildContext context) {
    final sentence = context.l10n.authOtpResendIn(_timeMarker);
    final parts = sentence.split(_timeMarker);
    final style = context.textTheme.bodyMedium;
    return Text.rich(
      key: const ValueKey(_Countdown),
      TextSpan(
        children: [
          TextSpan(text: parts.first),
          TextSpan(
            text: remaining.minutesSeconds,
            style: style?.copyWith(
              color: context.appColors.accent,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          if (parts.length > 1) TextSpan(text: parts.last),
        ],
      ),
      style: style,
    );
  }
}

class _ResendButton extends StatelessWidget {
  const _ResendButton({required this.enabled});

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final accent = context.appColors.accent;
    return TextButton(
      key: const ValueKey(_ResendButton),
      onPressed: enabled ? context.read<VerifyOtpCubit>().resend : null,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.square($styles.size.minTapTarget),
        alignment: AlignmentDirectional.centerStart,
        foregroundColor: accent,
      ),
      child: Text(
        context.l10n.authOtpResend,
        style: context.textTheme.bodyMedium?.copyWith(
          color: enabled ? accent : context.appColors.disabled,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
