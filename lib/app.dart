import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'features/auth/presentation/cubit/authentication_cubit.dart';
import 'l10n/l10n.dart';
import 'shared/extensions/extensions.dart';
import 'shared/styles/styles.dart';

class App extends StatelessWidget {
  const App({super.key, required this.authCubit, required this.router});

  // The brief's largest supported system text size.
  static const maxTextScale = 1.3;
  static const _fallbackLocale = Locale('en');

  final AuthenticationCubit authCubit;
  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: authCubit,
      child: MaterialApp.router(
        onGenerateTitle: (context) => context.l10n.appTitle,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(_fallbackLocale),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
        builder: _buildFrame,
      ),
    );
  }

  // Runs below Localizations, so the theme can follow the resolved locale.
  Widget _buildFrame(BuildContext context, Widget? child) {
    updateStylesForScreen(MediaQuery.sizeOf(context));
    return MediaQuery.withClampedTextScaling(
      maxScaleFactor: maxTextScale,
      child: Theme(
        data: AppTheme.light(Localizations.localeOf(context)),
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: context.systemOverlayStyle,
          child: child ?? const SizedBox.shrink(),
        ),
      ),
    );
  }
}
