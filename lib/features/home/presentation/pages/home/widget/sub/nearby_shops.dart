import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../l10n/l10n.dart';
import '../../../../../../../shared/components/components.dart';
import '../../../../../../../shared/extensions/extensions.dart';
import '../../../../../../../shared/styles/styles.dart';
import '../../../../../domain/entity/shop_entity.dart';
import '../../cubit/home_cubit.dart';
import 'home_skeletons.dart';
import 'landscape_backdrop.dart';
import 'shop_card.dart';

// "There are 4 J'Donut shops near you" on a drawn landscape. Display only:
// Explore now and Order online have no action (brief).
class NearbyShops extends StatelessWidget {
  const NearbyShops({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return Stack(
      children: [
        const Positioned.fill(child: LandscapeBackdrop()),
        BlocSelector<HomeCubit, HomeState, SectionData<List<ShopEntity>>>(
          selector: (state) => state.shops,
          builder: (context, shops) => SectionSwitcher(
            data: shops,
            skeleton: _padded(
              context,
              RowSectionSkeleton(
                tileWidth: ShopCard.width,
                tileHeight: ShopCard.height(context),
              ),
            ),
            isEmpty: (shops) => shops.isEmpty,
            onRetry: cubit.retry,
            builder: (shops) => _padded(context, _ShopsContent(shops: shops)),
          ),
        ),
      ],
    );
  }

  // Top breathing room, and space under the cards for the floating nav bar.
  Widget _padded(BuildContext context, Widget child) => Padding(
    padding: EdgeInsets.only(
      top: $styles.insets.xl,
      bottom:
          $styles.size.navBarHeight +
          MediaQuery.paddingOf(context).bottom +
          $styles.insets.xl,
    ),
    child: child,
  );
}

class _ShopsContent extends StatelessWidget {
  const _ShopsContent({required this.shops});

  // The title stays left of the clouds, as in the design.
  static const _titleWidthFactor = 0.78;

  final List<ShopEntity> shops;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final margin = $styles.grid.pageMargin;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: margin),
          child: FractionallySizedBox(
            widthFactor: _titleWidthFactor,
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              context.l10n.homeNearbyShops(shops.length),
              style: context.textTheme.headlineSmall?.copyWith(
                color: colors.onPrimary,
              ),
            ),
          ),
        ),
        $styles.insets.md.toHeightSizedBox,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: margin),
          child: const _ExploreNowPill(),
        ),
        $styles.insets.lg.toHeightSizedBox,
        SizedBox(
          height: ShopCard.height(context),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: margin),
            itemCount: shops.length,
            separatorBuilder: (_, _) => $styles.insets.md.toWidthSizedBox,
            itemBuilder: (context, index) =>
                ShopCard(key: ValueKey(shops[index].id), shop: shops[index]),
          ),
        ),
      ],
    );
  }
}

class _ExploreNowPill extends StatelessWidget {
  const _ExploreNowPill();

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final insets = $styles.insets;
    return DecoratedBox(
      decoration: ShapeDecoration(
        color: colors.surface,
        shape: const StadiumBorder(),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: insets.lg,
          vertical: insets.sm,
        ),
        child: Text(
          context.l10n.homeExploreNow.toUpperCase(),
          style: context.textTheme.labelLarge?.copyWith(color: colors.primary),
        ),
      ),
    );
  }
}
