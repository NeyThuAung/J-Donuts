import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../l10n/l10n.dart';
import '../../extensions/extensions.dart';
import '../../styles/styles.dart';

// Wraps every screen: while offline a small strip slides down under the
// status bar and the page moves down with it, so nothing is covered.
class OfflineBannerFrame extends StatelessWidget {
  const OfflineBannerFrame({
    super.key,
    required this.isOffline,
    required this.child,
  });

  final bool isOffline;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(end: isOffline ? 1 : 0),
      duration: context.motion(AppMotion.offlineBanner),
      curve: AppMotion.standard,
      child: child,
      builder: (context, shown, child) {
        final media = MediaQuery.of(context);
        // The banner takes over the status bar padding as it appears.
        final topPadding = media.padding.top * (1 - shown);
        return Column(
          children: [
            if (shown > 0) _Banner(shown: shown),
            Expanded(
              child: MediaQuery(
                data: media.copyWith(
                  padding: media.padding.copyWith(top: topPadding),
                  viewPadding: media.viewPadding.copyWith(top: topPadding),
                ),
                child: child!,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner({required this.shown});

  /// 0 hidden … 1 fully shown.
  final double shown;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final insets = $styles.insets;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: ClipRect(
        child: Align(
          alignment: Alignment.bottomCenter,
          heightFactor: shown,
          child: ColoredBox(
            color: colors.inverseSurface,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: insets.md,
                  vertical: insets.xs,
                ),
                child: const _BannerMessage(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BannerMessage extends StatelessWidget {
  const _BannerMessage();

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Semantics(
      liveRegion: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.wifi_slash,
            color: colors.onInverseSurface,
            size: $styles.size.iconSm,
          ),
          SizedBox(width: $styles.insets.xs),
          Flexible(
            child: Text(
              context.l10n.commonOfflineBanner,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: context.textTheme.labelMedium?.copyWith(
                color: colors.onInverseSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
