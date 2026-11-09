import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'core/core.dart';
import 'di/di.dart';
import 'features/auth/presentation/cubit/authentication_cubit.dart';
import 'features/home/domain/usecase/seed_local_data_usecase.dart';
import 'features/home/presentation/cubit/connectivity_cubit.dart';
import 'navigation/navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // Draw behind the system bars (Android below 15 doesn't by default), so
  // the transparent navigation bar shows the bottom nav, not a white strip.
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  await configureDependencies();
  await _seedLocalData();

  // Known before the first frame, so the router never shows the wrong screen.
  final authCubit = inject<AuthenticationCubit>();
  await authCubit.checkSession();

  // Offline banner and background refresh; never blocks the first frame.
  final connectivityCubit = inject<ConnectivityCubit>();
  unawaited(connectivityCubit.start());

  runApp(
    App(
      authCubit: authCubit,
      connectivityCubit: connectivityCubit,
      router: inject<NavigationRouter>().router,
    ),
  );
}

// Bundled data first, so every screen works offline from the first launch.
// A failure is logged; the screens then show their empty or error states.
Future<void> _seedLocalData() async {
  final result = await inject<SeedLocalDataUseCase>().call(const NoParams());
  if (result case Failed(:final failure, :final error)) {
    inject<AppLogger>().error('Seeding failed: $failure', error: error);
  }
}
