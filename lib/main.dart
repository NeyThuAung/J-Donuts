import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'core/core.dart';
import 'di/di.dart';
import 'features/auth/presentation/cubit/authentication_cubit.dart';
import 'navigation/navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await configureDependencies();
  _logUncaughtErrors(inject<AppLogger>());

  // Known before the first frame, so the router never shows the wrong screen.
  final authCubit = inject<AuthenticationCubit>();
  await authCubit.checkSession();

  runApp(App(authCubit: authCubit, router: inject<NavigationRouter>().router));
}

void _logUncaughtErrors(AppLogger logger) {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    logger.error(
      'Flutter error',
      error: details.exception,
      stackTrace: details.stack,
    );
  };
  PlatformDispatcher.instance.onError = (error, stackTrace) {
    logger.error('Uncaught error', error: error, stackTrace: stackTrace);
    return true;
  };
}
