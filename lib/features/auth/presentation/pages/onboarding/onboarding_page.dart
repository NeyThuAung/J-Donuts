import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../shared/components/components.dart';

// Placeholder until Task 1 builds the onboarding screen.
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  static const routeName = 'onboarding';
  static const routePath = '/$routeName';

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: SafeArea(
        child: AppErrorView(
          icon: CupertinoIcons.person_crop_circle,
          title: l10n.appTitle,
          message: l10n.commonComingSoon,
        ),
      ),
    );
  }
}
