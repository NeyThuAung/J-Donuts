import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../l10n/l10n.dart';
import '../../../../../../navigation/navigation.dart';
import '../../../../../../shared/components/components.dart';
import '../../../../../../shared/extensions/extensions.dart';
import '../../../../../../shared/resources/r.dart';
import '../../../../../../shared/styles/styles.dart';
import '../../../../domain/entity/auth_flow.dart';
import '../../../widget/terms_footer.dart';
import 'donut_cluster.dart';

// Title, the two entry points, social sign-in and terms. They enter after the
// donuts, in order.
class OnboardingActions extends StatelessWidget {
  const OnboardingActions({super.key, required this.animation});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final insets = $styles.insets;
    Widget enter(int slot, Widget child) => EntranceItem(
      animation: animation,
      index: DonutCluster.entranceSlots - 2 + slot,
      child: child,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        enter(
          0,
          Text(
            l10n.authOnboardingTitle,
            textAlign: TextAlign.center,
            style: context.textTheme.headlineMedium,
          ),
        ),
        insets.lg.toHeightSizedBox,
        enter(
          1,
          AppButton(
            label: l10n.authGetStarted,
            onPressed: () => unawaited(
              context.pushPhoneNumberPage(flow: AuthFlow.register),
            ),
          ),
        ),
        insets.xs.toHeightSizedBox,
        enter(2, const _LogInPrompt()),
        insets.xs.toHeightSizedBox,
        enter(3, const _SocialRow()),
        const Spacer(),
        insets.md.toHeightSizedBox,
        TermsFooter(
          onTermsTap: () =>
              showComingSoonSheet(context, title: l10n.authTermsOfUse),
          onPrivacyTap: () =>
              showComingSoonSheet(context, title: l10n.authPrivacyPolicy),
        ),
        insets.md.toHeightSizedBox,
      ],
    );
  }
}

class _LogInPrompt extends StatelessWidget {
  const _LogInPrompt();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final style = context.textTheme.bodyMedium;
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(l10n.authHaveAccount, style: style),
        TextButton(
          onPressed: () =>
              unawaited(context.pushPhoneNumberPage(flow: AuthFlow.logIn)),
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: $styles.insets.xxs),
            minimumSize: Size.square($styles.size.minTapTarget),
          ),
          child: Text(
            l10n.authLogIn,
            style: style?.copyWith(
              color: context.appColors.accent,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _SocialRow extends StatelessWidget {
  const _SocialRow();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialButton(icon: R.icons.google, label: l10n.authContinueWithGoogle),
        _SocialButton(icon: R.icons.apple, label: l10n.authContinueWithApple),
        _SocialButton(
          icon: R.icons.facebook,
          label: l10n.authContinueWithFacebook,
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.icon, required this.label});

  final AssetGenImage icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final size = $styles.size.icon;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
      child: IconButton(
        tooltip: label,
        onPressed: () => showComingSoonSheet(context, title: label),
        icon: icon.image(width: size, height: size),
      ),
    );
  }
}
