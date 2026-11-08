import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../../shared/components/components.dart';
import '../../../../../shared/styles/styles.dart';
import 'widget/donut_cluster.dart';
import 'widget/onboarding_actions.dart';

// Share of the screen height given to the donut cluster, and its floor for
// very short screens.
const _clusterShare = 0.56;
const _minClusterHeight = 220.0;

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  static const routeName = 'onboarding';
  static const routePath = '/$routeName';

  @override
  Widget build(BuildContext context) {
    final clusterHeight = math.max(
      MediaQuery.sizeOf(context).height * _clusterShare,
      _minClusterHeight,
    );
    return Scaffold(
      backgroundColor: context.appColors.authGradientTop,
      body: StaggeredEntrance(
        duration: AppMotion.donutDrift,
        builder: (context, animation) => CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  DonutCluster(animation: animation, height: clusterHeight),
                  Expanded(
                    child: SafeArea(
                      top: false,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: $styles.grid.authPageMargin,
                        ),
                        child: OnboardingActions(animation: animation),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
