import 'package:flutter/material.dart';

import '../../../../../shared/extensions/extensions.dart';
import '../../../../../shared/styles/styles.dart';
import 'widget/home_content.dart';

// Home tab (screen 8). The tab shell provides HomeCubit.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: context.systemOverlayStyle,
      child: ColoredBox(
        color: context.appColors.background,
        child: const HomeContent(),
      ),
    );
  }
}
