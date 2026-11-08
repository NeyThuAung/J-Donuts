import 'package:flutter/material.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../shared/components/components.dart';

// Body for the tabs the brief leaves unbuilt.
class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({super.key, required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppErrorView(
        icon: icon,
        title: title,
        message: context.l10n.commonComingSoon,
      ),
    );
  }
}
