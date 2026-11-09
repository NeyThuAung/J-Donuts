import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/core.dart';
import 'package:j_donuts/features/home/domain/usecase/refresh_local_data_usecase.dart';
import 'package:j_donuts/features/home/presentation/cubit/connectivity_cubit.dart';
import 'package:mocktail/mocktail.dart';

class _MockNetworkInfo extends Mock implements NetworkInfo {}

class _MockRefresh extends Mock implements RefreshLocalDataUseCase {}

class _MockLogger extends Mock implements AppLogger {}

const _noParams = NoParams();

void main() {
  late StreamController<bool> status;
  late _MockNetworkInfo network;
  late _MockRefresh refresh;
  late ConnectivityCubit cubit;

  setUp(() {
    status = StreamController.broadcast();
    network = _MockNetworkInfo();
    refresh = _MockRefresh();
    when(() => network.onStatusChange).thenAnswer((_) => status.stream);
    when(
      () => refresh(_noParams),
    ).thenAnswer((_) async => const Success(null));
    cubit = ConnectivityCubit(network, refresh, _MockLogger());
  });

  tearDown(() async {
    await cubit.close();
    await status.close();
  });

  Future<void> settle() => Future<void>.delayed(Duration.zero);

  group('ConnectivityCubit', () {
    test('shows the offline banner when started without internet', () async {
      when(() => network.isConnected).thenAnswer((_) async => false);

      await cubit.start();

      expect(cubit.state, ConnectivityStatus.offline);
      verifyNever(() => refresh(_noParams));
    });

    test('refreshes in the background when the app starts online', () async {
      when(() => network.isConnected).thenAnswer((_) async => true);

      await cubit.start();
      await settle();

      expect(cubit.state, ConnectivityStatus.online);
      verify(() => refresh(_noParams)).called(1);
    });

    test('refreshes again when the connection comes back', () async {
      when(() => network.isConnected).thenAnswer((_) async => false);
      await cubit.start();

      status.add(true);
      await settle();

      expect(cubit.state, ConnectivityStatus.online);
      verify(() => refresh(_noParams)).called(1);
    });

    test('does not refresh again while it stays online', () async {
      when(() => network.isConnected).thenAnswer((_) async => true);
      await cubit.start();

      status
        ..add(true)
        ..add(true);
      await settle();

      verify(() => refresh(_noParams)).called(1);
    });

    test('shows the banner again when the connection drops', () async {
      when(() => network.isConnected).thenAnswer((_) async => true);
      await cubit.start();

      status.add(false);
      await settle();

      expect(cubit.state, ConnectivityStatus.offline);
    });

    test(
      'a failed background refresh keeps the app online and quiet',
      () async {
        when(
          () => refresh(_noParams),
        ).thenAnswer((_) async => const Failed(ConnectionFailure()));
        when(() => network.isConnected).thenAnswer((_) async => true);

        await cubit.start();
        await settle();

        expect(cubit.state, ConnectivityStatus.online);
      },
    );
  });
}
