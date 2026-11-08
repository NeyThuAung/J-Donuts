import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../shared/components/components.dart';

// Placeholder until 1.11 builds the screen.
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  static const routeName = 'welcome';
  static const routePath = '/$routeName';

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: AppErrorView(
        icon: CupertinoIcons.heart,
        title: context.l10n.appTitle,
        message: context.l10n.commonComingSoon,
      ),
    ),
  );
}
