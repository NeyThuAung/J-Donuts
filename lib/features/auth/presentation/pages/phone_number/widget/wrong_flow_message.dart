import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../l10n/l10n.dart';
import '../../../../../../shared/extensions/extensions.dart';
import '../../../../../../shared/styles/styles.dart';
import '../../../../domain/entity/auth_flow.dart';
import '../cubit/phone_number_cubit.dart';

// "Not registered yet. Register" on log in, "Already has an account. Log in"
// on register. Slides open under the field.
class WrongFlowMessage extends StatelessWidget {
  const WrongFlowMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhoneNumberCubit, PhoneNumberState>(
      buildWhen: (previous, current) =>
          previous.isWrongFlow != current.isWrongFlow ||
          previous.flow != current.flow,
      builder: (context, state) => AnimatedSize(
        duration: context.motion(AppMotion.fieldState),
        curve: AppMotion.standard,
        alignment: AlignmentDirectional.topStart,
        child: state.isWrongFlow
            ? _Message(flow: state.flow)
            : const SizedBox(width: double.infinity),
      ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({required this.flow});

  final AuthFlow flow;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isLogIn = flow == AuthFlow.logIn;
    final style = context.textTheme.bodySmall;
    return Padding(
      padding: EdgeInsets.only(top: $styles.insets.xs),
      child: Semantics(
        liveRegion: true,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              isLogIn
                  ? l10n.authPhoneNotRegistered
                  : l10n.authPhoneAlreadyRegistered,
              style: style?.copyWith(color: context.appColors.accent),
            ),
            TextButton(
              onPressed: () => context.read<PhoneNumberCubit>().switchFlow(),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: $styles.insets.xxs),
                minimumSize: Size.square($styles.size.minTapTarget),
              ),
              child: Text(
                isLogIn
                    ? l10n.authPhoneRegisterInstead
                    : l10n.authPhoneLogInInstead,
                style: style?.copyWith(
                  color: context.appColors.accent,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                  decorationColor: context.appColors.accent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
