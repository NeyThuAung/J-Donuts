import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/features/settings/presentation/pages/placeholder/placeholder_page.dart';
import 'package:j_donuts/l10n/l10n.dart';
import 'package:j_donuts/shared/styles/styles.dart';

void main() {
  group('PlaceholderPage', () {
    testWidgets('shows the tab icon, title and a coming-soon message', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(const Locale('en')),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(
            body: PlaceholderPage(
              title: 'Wallet',
              icon: CupertinoIcons.creditcard,
            ),
          ),
        ),
      );

      expect(find.byIcon(CupertinoIcons.creditcard), findsOneWidget);
      expect(find.text('Wallet'), findsOneWidget);
      expect(find.text('Coming soon'), findsOneWidget);
      expect(find.text('Retry'), findsNothing);
    });
  });
}
