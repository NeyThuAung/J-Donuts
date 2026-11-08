import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/shared/components/loading/app_shimmer.dart';
import 'package:j_donuts/shared/styles/styles.dart';

Widget _app(Widget child, {bool disableAnimations = false}) => MaterialApp(
  theme: AppTheme.light(const Locale('en')),
  home: MediaQuery(
    data: MediaQueryData(disableAnimations: disableAnimations),
    child: Center(child: child),
  ),
);

BoxDecoration _decorationOf(WidgetTester tester) =>
    tester.widget<DecoratedBox>(find.byType(DecoratedBox)).decoration
        as BoxDecoration;

void main() {
  group('AppShimmer', () {
    const skeleton = SkeletonBox(width: 120, height: 16);

    testWidgets('keeps animating the highlight over its skeleton', (
      tester,
    ) async {
      await tester.pumpWidget(_app(const AppShimmer(child: skeleton)));
      await tester.pump(AppMotion.shimmer * 1.5);

      expect(find.byType(ShaderMask), findsOneWidget);
      expect(tester.binding.hasScheduledFrame, isTrue);
    });

    testWidgets('shows a still skeleton when Reduce Motion is on', (
      tester,
    ) async {
      await tester.pumpWidget(
        _app(const AppShimmer(child: skeleton), disableAnimations: true),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ShaderMask), findsNothing);
      expect(find.byType(SkeletonBox), findsOneWidget);
    });

    testWidgets('stops animating when Reduce Motion turns on', (tester) async {
      await tester.pumpWidget(_app(const AppShimmer(child: skeleton)));
      await tester.pumpWidget(
        _app(const AppShimmer(child: skeleton), disableAnimations: true),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ShaderMask), findsNothing);
    });
  });

  group('SkeletonBox', () {
    testWidgets('draws a rounded box in the shimmer base colour', (
      tester,
    ) async {
      await tester.pumpWidget(_app(const SkeletonBox(width: 80, height: 20)));
      final decoration = _decorationOf(tester);

      expect(tester.getSize(find.byType(SkeletonBox)), const Size(80, 20));
      expect(decoration.color, AppThemeColors.light.shimmerBase);
      expect(decoration.shape, BoxShape.rectangle);
      expect(
        decoration.borderRadius,
        BorderRadius.circular($styles.corner.sm),
      );
    });

    testWidgets('uses a custom radius when one is given', (tester) async {
      await tester.pumpWidget(
        _app(const SkeletonBox(width: 80, height: 20, radius: 4)),
      );

      expect(_decorationOf(tester).borderRadius, BorderRadius.circular(4));
    });

    testWidgets('circle draws a round box of the given size', (tester) async {
      await tester.pumpWidget(_app(const SkeletonBox.circle(size: 48)));
      final decoration = _decorationOf(tester);

      expect(tester.getSize(find.byType(SkeletonBox)), const Size(48, 48));
      expect(decoration.shape, BoxShape.circle);
      expect(decoration.borderRadius, isNull);
    });
  });
}
