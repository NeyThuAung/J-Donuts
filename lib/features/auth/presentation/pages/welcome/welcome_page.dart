import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../shared/components/components.dart';
import '../../../../../shared/extensions/extensions.dart';
import '../../../../../shared/styles/styles.dart';
import '../../cubit/authentication_cubit.dart';
import 'widget/welcome_tiles.dart';

// The title slides up by this share of its own height while it fades in.
const _titleRise = Offset(0, 0.4);

// Shown once to a new member. Let's explore marks Welcome as seen; the router
// then opens Home.
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  static const routeName = 'welcome';
  static const routePath = '/$routeName';

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: context.systemOverlayStyle,
      child: Scaffold(
        backgroundColor: context.appColors.authGradientTop,
        body: StaggeredEntrance(
          duration: AppMotion.welcomeEntrance,
          // Title and button keep their height; the tiles take the rest.
          builder: (context, animation) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: WelcomeTiles(animation: animation)),
              _WelcomeActions(animation: animation),
            ],
          ),
        ),
      ),
    );
  }
}

// Title, then Let's explore; both enter after all the tiles.
class _WelcomeActions extends StatelessWidget {
  const _WelcomeActions({required this.animation});

  final Animation<double> animation;

  static const _titleSlot = WelcomeTiles.entranceSlots + 1;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final insets = $styles.insets;
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: $styles.grid.authPageMargin),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            EntranceItem(
              animation: animation,
              index: _titleSlot,
              slideFrom: _titleRise,
              child: Text(
                l10n.authWelcomeTitle,
                textAlign: TextAlign.center,
                style: context.textTheme.headlineMedium,
              ),
            ),
            insets.lg.toHeightSizedBox,
            EntranceItem(
              animation: animation,
              index: _titleSlot + 1,
              child: AppButton(
                label: l10n.authWelcomeExplore,
                onPressed: () =>
                    context.read<AuthenticationCubit>().welcomeSeen(),
              ),
            ),
            insets.xl.toHeightSizedBox,
          ],
        ),
      ),
    );
  }
}
