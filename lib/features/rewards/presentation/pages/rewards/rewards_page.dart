import 'package:flutter/material.dart';

import '../../../../../shared/extensions/extensions.dart';
import '../../../../../shared/styles/styles.dart';
import 'widget/rewards_content.dart';

// Rewards tab (screen 10). The tab shell provides RewardsCubit.
class RewardsPage extends StatelessWidget {
  const RewardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: context.systemOverlayStyle,
      child: ColoredBox(
        color: context.appColors.background,
        child: const RewardsContent(),
      ),
    );
  }
}
