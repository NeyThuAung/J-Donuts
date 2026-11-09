import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../l10n/l10n.dart';
import '../../../../../../../shared/components/components.dart';
import '../../../../../../../shared/extensions/extensions.dart';
import '../../../../../../../shared/styles/styles.dart';
import '../../../../../../member/domain/entity/member_entity.dart';
import '../../../../../domain/entity/banner_entity.dart';
import '../../cubit/home_cubit.dart';
import 'banner_carousel.dart';
import 'header_decorations.dart';
import 'home_skeletons.dart';
import 'member_summary.dart';

// Peach header: member summary, tier art, bell and the banner carousel,
// clipped by the rounded bottom edge.
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  static const _bottomRadius = 36.0;
  static const _badgeSize = 168.0;
  // Share of the tier art that runs off the right edge.
  static const _badgeOverhang = 0.25;

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top + $styles.insets.lg;
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(_bottomRadius),
      ),
      child: ColoredBox(
        color: context.appColors.homeHeader,
        child: Stack(
          children: [
            Positioned(
              top: top,
              right: -_badgeSize * _badgeOverhang,
              child: const TierBadgeArt(size: _badgeSize),
            ),
            Column(
              children: [
                top.toHeightSizedBox,
                const _MemberPart(),
                $styles.insets.lg.toHeightSizedBox,
                const _BannerPart(),
              ],
            ),
            Positioned(top: top, right: 0, child: const _Bell()),
          ],
        ),
      ),
    );
  }
}

class _MemberPart extends StatelessWidget {
  const _MemberPart();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: $styles.grid.pageMargin),
      child: BlocSelector<HomeCubit, HomeState, SectionData<MemberEntity?>>(
        selector: (state) => state.member,
        builder: (context, member) => SectionSwitcher<MemberEntity?>(
          data: member,
          skeleton: const MemberSkeleton(),
          isEmpty: (member) => member == null,
          emptyMessage: context.l10n.homeMemberEmpty,
          onRetry: cubit.retry,
          builder: (member) => MemberSummary(member: member!),
        ),
      ),
    );
  }
}

class _BannerPart extends StatelessWidget {
  const _BannerPart();

  static const _photoMinHeight = 72.0;
  static const _titleLines = 2;

  // Tag, two title lines and the photo, at the current text scale.
  double _height(BuildContext context) {
    final textTheme = context.textTheme;
    final insets = $styles.insets;
    return _photoMinHeight +
        context.textLinesHeight(textTheme.titleLarge, _titleLines) +
        context.textLinesHeight(textTheme.labelMedium, 1) +
        insets.sm +
        insets.xs * 2 +
        insets.xxs * 2;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return SizedBox(
      height: _height(context),
      child:
          BlocSelector<HomeCubit, HomeState, SectionData<List<BannerEntity>>>(
            selector: (state) => state.banners,
            builder: (context, banners) => SectionSwitcher(
              data: banners,
              skeleton: const BannerSkeleton(),
              isEmpty: (banners) => banners.isEmpty,
              onRetry: cubit.retry,
              builder: (banners) => BannerCarousel(banners: banners),
            ),
          ),
    );
  }
}

class _Bell extends StatelessWidget {
  const _Bell();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeCubit, HomeState, int?>(
      selector: (state) => switch (state.member) {
        SectionReady(:final data) => data?.notificationCount,
        _ => null,
      },
      builder: (context, count) => count == null
          ? const SizedBox.shrink()
          : NotificationBell(
              count: count,
              onTap: () => showComingSoonSheet(
                context,
                title: context.l10n.homeNotificationsTitle,
              ),
            ),
    );
  }
}
