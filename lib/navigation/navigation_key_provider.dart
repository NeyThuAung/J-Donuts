import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

// Gives services outside the widget tree (router, snack shower) the root
// navigator, and through it the overlay, theme and localizations.
abstract interface class INavigationKeyProvider {
  GlobalKey<NavigatorState> get navigatorKey;
}

@Singleton(as: INavigationKeyProvider)
class NavigationKeyProvider implements INavigationKeyProvider {
  @override
  final navigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
}
