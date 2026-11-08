import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../shared/components/components.dart';
import '../../../domain/entity/auth_flow.dart';

class VerifyOtpArgs {
  const VerifyOtpArgs({required this.phone, required this.flow});

  /// Normalized, e.g. +959254135592.
  final String phone;
  final AuthFlow flow;
}

// Placeholder until 1.8 builds the screen.
class VerifyOtpPage extends StatelessWidget {
  const VerifyOtpPage({super.key, required this.args});

  static const routeName = 'verify-otp';
  static const routePath = '/$routeName';

  final VerifyOtpArgs args;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(),
    body: AppErrorView(
      icon: CupertinoIcons.lock,
      title: context.l10n.appTitle,
      message: context.l10n.commonComingSoon,
    ),
  );
}
