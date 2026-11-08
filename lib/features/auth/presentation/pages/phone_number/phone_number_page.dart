import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../shared/components/components.dart';
import '../../../domain/entity/auth_flow.dart';

// Placeholder until 1.7 builds the screen.
class PhoneNumberPage extends StatelessWidget {
  const PhoneNumberPage({super.key, required this.flow});

  static const routeName = 'phone-number';
  static const routePath = '/$routeName';
  static const flowParam = 'flow';

  final AuthFlow flow;

  /// Unknown or missing values start the register flow.
  static AuthFlow flowFromQuery(String? value) =>
      AuthFlow.values.asNameMap()[value] ?? AuthFlow.register;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(),
    body: AppErrorView(
      icon: CupertinoIcons.phone,
      title: context.l10n.appTitle,
      message: context.l10n.commonComingSoon,
    ),
  );
}
