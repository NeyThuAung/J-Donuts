import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../navigation/router_extension.dart';
import '../../../../../../shared/components/components.dart';
import '../../../../../../shared/extensions/extensions.dart';
import '../../../../../../shared/styles/styles.dart';
import '../../../../domain/entity/home_section_entity.dart';
import '../../../../domain/entity/home_section_type.dart';
import '../cubit/home_cubit.dart';
import 'sub/home_header.dart';
import 'sub/home_skeletons.dart';
import 'sub/nearby_shops.dart';
import 'sub/product_section.dart';
import 'sub/product_tiles.dart';

// Header, product sections and shops; they enter staggered, and pull to
// refresh fetches newer data while the current content stays on screen.
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  static const _headerIndex = 0;
  static const _firstSectionIndex = 1;
  static const _shopsIndex = 4;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return StaggeredEntrance(
      duration: AppMotion.homeEntrance,
      builder: (context, animation) => RefreshIndicator(
        onRefresh: cubit.refresh,
        color: context.appColors.accent,
        edgeOffset: MediaQuery.paddingOf(context).top,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: EntranceItem(
                animation: animation,
                index: _headerIndex,
                slideFrom: Offset.zero,
                child: const HomeHeader(),
              ),
            ),
            SliverToBoxAdapter(child: _Sections(animation: animation)),
            SliverToBoxAdapter(
              child: EntranceItem(
                animation: animation,
                index: _shopsIndex,
                child: const NearbyShops(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Sections extends StatelessWidget {
  const _Sections({required this.animation});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: $styles.insets.xl),
      child:
          BlocSelector<
            HomeCubit,
            HomeState,
            SectionData<List<HomeSectionEntity>>
          >(
            selector: (state) => state.sections,
            builder: (context, sections) => SectionSwitcher(
              data: sections,
              skeleton: const _SectionsSkeleton(),
              isEmpty: (sections) => sections.isEmpty,
              onRetry: cubit.retry,
              builder: (sections) => _SectionList(
                sections: sections,
                animation: animation,
              ),
            ),
          ),
    );
  }
}

class _SectionList extends StatelessWidget {
  const _SectionList({required this.sections, required this.animation});

  final List<HomeSectionEntity> sections;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final (index, section) in sections.indexed) ...[
          if (index > 0) $styles.insets.xl.toHeightSizedBox,
          EntranceItem(
            key: ValueKey(section.id),
            animation: animation,
            index: HomeContent._firstSectionIndex + index,
            child: ProductSection(
              section: section,
              onProductTap: (product) =>
                  context.pushProductDetailPage(productId: product.id),
            ),
          ),
        ],
      ],
    );
  }
}

class _SectionsSkeleton extends StatelessWidget {
  const _SectionsSkeleton();

  @override
  Widget build(BuildContext context) {
    const seasonal = HomeSectionType.seasonal;
    const popular = HomeSectionType.popular;
    return Column(
      children: [
        RowSectionSkeleton(
          tileWidth: seasonal.tileWidth,
          tileHeight: seasonal.imageHeight,
        ),
        $styles.insets.xl.toHeightSizedBox,
        RowSectionSkeleton(
          tileWidth: popular.tileWidth,
          tileHeight: popular.imageHeight,
        ),
      ],
    );
  }
}
