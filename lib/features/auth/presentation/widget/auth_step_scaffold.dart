import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../shared/components/components.dart';
import '../../../../shared/extensions/extensions.dart';
import '../../../../shared/styles/styles.dart';
import 'auth_step.dart';
import 'step_progress_ring.dart';
import 'terms_footer.dart';

// Shared frame of the Phone, OTP, Name and Date of birth screens: back button
// and progress ring, title, the step's fields, then the action and the terms.
// Scrolls when the keyboard or a large text size needs the room.
class AuthStepScaffold extends StatelessWidget {
  const AuthStepScaffold({
    super.key,
    required this.step,
    required this.title,
    required this.body,
    required this.action,
    required this.onTermsTap,
    required this.onPrivacyTap,
    this.subtitle,
  });

  final AuthStep step;
  final String title;
  final Widget? subtitle;
  final Widget body;

  /// Usually the Continue button; OTP has none.
  final Widget? action;
  final VoidCallback onTermsTap;
  final VoidCallback onPrivacyTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [colors.authGradientTop, colors.authGradientBottom],
          ),
        ),
        child: SafeArea(
          child: DismissFocusWrapper(
            // Not SliverFillRemaining: that sizes from intrinsic heights,
            // which lag behind an error message animating open or closed.
            child: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: $styles.grid.authPageMargin,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [_top(context), _bottom()],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _top(BuildContext context) {
    final insets = $styles.insets;
    final subtitle = this.subtitle;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        insets.md.toHeightSizedBox,
        Row(
          children: [
            const _BackButton(),
            const Spacer(),
            StepProgressRing(step: step),
          ],
        ),
        insets.xl.toHeightSizedBox,
        Text(title, style: context.textTheme.headlineMedium),
        if (subtitle != null) ...[insets.xs.toHeightSizedBox, subtitle],
        insets.xl.toHeightSizedBox,
        body,
      ],
    );
  }

  Widget _bottom() {
    final insets = $styles.insets;
    final action = this.action;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        insets.lg.toHeightSizedBox,
        ?action,
        insets.lg.toHeightSizedBox,
        TermsFooter(onTermsTap: onTermsTap, onPrivacyTap: onPrivacyTap),
        insets.md.toHeightSizedBox,
      ],
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return IconButton(
      onPressed: () => Navigator.of(context).maybePop(),
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      icon: const Icon(CupertinoIcons.arrow_left),
      style: IconButton.styleFrom(
        backgroundColor: colors.surface,
        foregroundColor: colors.textPrimary,
        fixedSize: Size.square($styles.size.iconButton),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular($styles.corner.sm),
        ),
      ),
    );
  }
}
