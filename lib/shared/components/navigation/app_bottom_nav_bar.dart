import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../extensions/extensions.dart';
import '../../styles/styles.dart';

class AppNavItem {
  const AppNavItem({required this.icon, required this.label});

  final SvgGenImage icon;
  final String label;
}

// Cyan bar with rounded top corners over a pink strip. The selected tab is a
// pink pill with its label that grows from its centre with a small bounce,
// while the previous one shrinks back to its icon.
class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<AppNavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final insets = $styles.insets;
    final radius = Radius.circular($styles.corner.lg);
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: $styles.size.navStrip,
          child: ColoredBox(color: colors.accent),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: insets.md),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colors.primary,
              borderRadius: BorderRadius.vertical(top: radius),
              border: Border(
                top: _edge(colors),
                left: _edge(colors),
                right: _edge(colors),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                insets.xs,
                insets.md,
                insets.xs,
                // A gap above the system navigation bar, never less than md.
                math.max(bottomInset + insets.sm, insets.md),
              ),
              child: _row(),
            ),
          ),
        ),
      ],
    );
  }

  BorderSide _edge(AppThemeColors colors) =>
      BorderSide(color: colors.onPrimary, width: $styles.size.focusBorder);

  Widget _row() => LayoutBuilder(
    builder: (context, constraints) {
      final labelMaxWidth = _labelMaxWidth(constraints.maxWidth);
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (var i = 0; i < items.length; i++)
            _NavButton(
              item: items[i],
              isSelected: i == selectedIndex,
              labelMaxWidth: labelMaxWidth,
              onTap: () => onSelected(i),
            ),
        ],
      );
    },
  );

  // Room left for the selected label after every tab's icon and padding.
  double _labelMaxWidth(double width) {
    final size = $styles.size;
    final insets = $styles.insets;
    final tab = size.navIcon + 2 * (insets.xs + insets.xxs);
    final selectedExtra = 2 * (size.navPillPadding - insets.xs) + insets.xxs;
    return math.max(0, width - items.length * tab - selectedExtra);
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.item,
    required this.isSelected,
    required this.labelMaxWidth,
    required this.onTap,
  });

  final AppNavItem item;
  final bool isSelected;
  final double labelMaxWidth;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isSelected,
      label: item.label,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        // Widens the tap target past the icon-only pill.
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: $styles.insets.xxs),
          // Each tab runs its own tween, so only the old and new tabs move.
          child: TweenAnimationBuilder<double>(
            tween: Tween(end: isSelected ? 1 : 0),
            duration: context.motion(AppMotion.navPill),
            curve: AppMotion.navPillBounce,
            builder: (context, progress, _) => _NavPill(
              item: item,
              progress: progress,
              labelMaxWidth: labelMaxWidth,
            ),
          ),
        ),
      ),
    );
  }
}

// [progress] is 0 for an icon-only tab and 1 for the full pill; it overshoots
// 1 briefly on the way in, which gives the bounce.
class _NavPill extends StatelessWidget {
  const _NavPill({
    required this.item,
    required this.progress,
    required this.labelMaxWidth,
  });

  final AppNavItem item;
  final double progress;
  final double labelMaxWidth;

  @override
  Widget build(BuildContext context) {
    final size = $styles.size;
    final reveal = progress.clamp(0.0, 1.0);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        if (progress > 0) Positioned.fill(child: _Pill(progress: progress)),
        SizedBox(
          height: size.navPillHeight,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: lerpDouble(
                $styles.insets.xs,
                size.navPillPadding,
                reveal,
              )!,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _icon(context),
                if (reveal > 0) _label(context, reveal),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _icon(BuildContext context) {
    final iconSize = $styles.size.navIcon;
    return item.icon.svg(
      width: iconSize,
      height: iconSize,
      colorFilter: ColorFilter.mode(
        context.appColors.onPrimary,
        BlendMode.srcIn,
      ),
    );
  }

  // Clipped to a growing width, so the label slides out of the icon.
  Widget _label(BuildContext context, double reveal) => ClipRect(
    child: Align(
      alignment: Alignment.centerLeft,
      widthFactor: reveal,
      child: Padding(
        padding: EdgeInsets.only(left: $styles.insets.xxs),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: labelMaxWidth),
          // Only the label shrinks to fit (Burmese, text scale 1.3).
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              item.label,
              maxLines: 1,
              style: context.textTheme.labelMedium?.copyWith(
                color: context.appColors.onPrimary.withValues(alpha: reveal),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

// Starts as a circle behind the icon and widens to both sides from the
// centre; past 1 it is briefly wider than the tab, which gives the bounce.
class _Pill extends StatelessWidget {
  const _Pill({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final fade = (progress / AppMotion.navPillFadeIn).clamp(0.0, 1.0);
    return LayoutBuilder(
      builder: (context, constraints) => OverflowBox(
        minWidth: 0,
        maxWidth: double.infinity,
        child: SizedBox(
          width: lerpDouble(
            constraints.maxHeight,
            constraints.maxWidth,
            progress,
          ),
          height: constraints.maxHeight,
          child: DecoratedBox(
            decoration: ShapeDecoration(
              color: colors.accent.withValues(alpha: fade),
              shape: StadiumBorder(
                side: BorderSide(
                  color: colors.onPrimary.withValues(alpha: fade),
                  width: $styles.size.focusBorder,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
