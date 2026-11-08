import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../shared/components/components.dart';

class DateOfBirthArgs {
  const DateOfBirthArgs({
    required this.phone,
    required this.firstName,
    this.lastName,
  });

  final String phone;
  final String firstName;
  final String? lastName;
}

// Placeholder until 1.10 builds the screen.
class DateOfBirthPage extends StatelessWidget {
  const DateOfBirthPage({super.key, required this.args});

  static const routeName = 'date-of-birth';
  static const routePath = '/$routeName';

  final DateOfBirthArgs args;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(),
    body: AppErrorView(
      icon: CupertinoIcons.calendar,
      title: context.l10n.appTitle,
      message: context.l10n.commonComingSoon,
    ),
  );
}
