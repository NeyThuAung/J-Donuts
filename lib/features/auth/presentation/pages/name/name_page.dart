import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../shared/components/components.dart';

class NameArgs {
  const NameArgs({required this.phone});

  /// Verified and normalized.
  final String phone;
}

// Placeholder until 1.9 builds the screen.
class NamePage extends StatelessWidget {
  const NamePage({super.key, required this.args});

  static const routeName = 'name';
  static const routePath = '/$routeName';

  final NameArgs args;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(),
    body: AppErrorView(
      icon: CupertinoIcons.person,
      title: context.l10n.appTitle,
      message: context.l10n.commonComingSoon,
    ),
  );
}
