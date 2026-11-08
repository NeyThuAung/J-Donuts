import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/network/network_info.dart';
import 'package:mocktail/mocktail.dart';

class _MockConnectivity extends Mock implements Connectivity {}

void main() {
  late _MockConnectivity connectivity;
  final reachable = [InternetAddress('8.8.8.8')];

  setUp(() => connectivity = _MockConnectivity());

  NetworkInfo build(HostLookup lookup) => NetworkInfoImpl(connectivity, lookup);

  void givenInterfaces(List<ConnectivityResult> results) => when(
    () => connectivity.checkConnectivity(),
  ).thenAnswer((_) async => results);

  group('isConnected', () {
    test('returns false without a network interface', () async {
      givenInterfaces([ConnectivityResult.none]);
      var lookedUp = false;

      final info = build((_) async {
        lookedUp = true;
        return reachable;
      });

      expect(await info.isConnected, isFalse);
      expect(lookedUp, isFalse);
    });

    test('returns true when on wifi and the host resolves', () async {
      givenInterfaces([ConnectivityResult.wifi]);

      expect(await build((_) async => reachable).isConnected, isTrue);
    });

    test('returns false when on wifi but the lookup fails', () async {
      givenInterfaces([ConnectivityResult.wifi]);

      final info = build((_) async => throw const SocketException('no dns'));

      expect(await info.isConnected, isFalse);
    });
  });

  group('onStatusChange', () {
    test('emits only when reachability actually changes', () {
      when(() => connectivity.onConnectivityChanged).thenAnswer(
        (_) => Stream.fromIterable([
          [ConnectivityResult.wifi],
          [ConnectivityResult.mobile],
          [ConnectivityResult.none],
        ]),
      );

      expect(
        build((_) async => reachable).onStatusChange,
        emitsInOrder(<Object>[true, false, emitsDone]),
      );
    });
  });
}
