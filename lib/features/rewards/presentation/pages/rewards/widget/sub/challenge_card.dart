import 'package:flutter/material.dart';

import '../../../../../../../l10n/l10n.dart';
import '../../../../../../../shared/extensions/extensions.dart';
import '../../../../../../../shared/styles/styles.dart';
import '../../../../../domain/entity/challenge_entity.dart';
import 'challenge_art.dart';
import 'earn_button.dart';

// Artwork on the left (it draws the progress); title, progress, Earn and
// the reward on the right.
class ChallengeCard extends StatelessWidget {
  const ChallengeCard({super.key, required this.challenge, required this.art});

  final ChallengeEntity challenge;

  /// 0 to 1 while the artwork draws the progress.
  final Animation<double> art;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = context.textTheme;
    final insets = $styles.insets;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.appColors.surface,
        borderRadius: BorderRadius.circular($styles.corner.lg),
      ),
      child: Padding(
        padding: EdgeInsets.all(insets.lg),
        child: LayoutBuilder(
          builder: (context, constraints) => Row(
            children: [
              ChallengeArt(
                challenge: challenge,
                size: ChallengeArt.sizeFor(constraints.maxWidth),
                progress: art,
              ),
              insets.md.toWidthSizedBox,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      challenge.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleLarge,
                    ),
                    insets.xs.toHeightSizedBox,
                    Text(
                      l10n.rewardsProgress(challenge.progress, challenge.goal),
                      style: textTheme.bodyLarge,
                    ),
                    insets.md.toHeightSizedBox,
                    _EarnRow(challenge: challenge),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EarnRow extends StatelessWidget {
  const _EarnRow({required this.challenge});

  final ChallengeEntity challenge;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: $styles.insets.sm,
      runSpacing: $styles.insets.xs,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        EarnButton(isActive: challenge.isComplete),
        Text(
          context.l10n.rewardsPoints(challenge.rewardPoints.grouped(context)),
          style: context.textTheme.bodyLarge,
        ),
      ],
    );
  }
}
