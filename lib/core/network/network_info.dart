import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

typedef HostLookup = Future<List<InternetAddress>> Function(String host);

abstract interface class NetworkInfo {
  Future<bool> get isConnected;

  Stream<bool> get onStatusChange;
}

class NetworkInfoImpl implements NetworkInfo {
  const NetworkInfoImpl(this._connectivity, this._lookup);

  final Connectivity _connectivity;
  final HostLookup _lookup;

  static const _probeHost = 'google.com';
  static const _probeTimeout = Duration(seconds: 3);

  @override
  Future<bool> get isConnected async {
    final results = await _connectivity.checkConnectivity();
    return _hasInterface(results) && await _canReachInternet();
  }

  @override
  Stream<bool> get onStatusChange => _connectivity.onConnectivityChanged
      .asyncMap(
        (results) async => _hasInterface(results) && await _canReachInternet(),
      )
      .distinct();

  bool _hasInterface(List<ConnectivityResult> results) =>
      results.any((result) => result != ConnectivityResult.none);

  // A Wi-Fi with a login page has an interface but no internet.
  Future<bool> _canReachInternet() async {
    try {
      final addresses = await _lookup(_probeHost).timeout(_probeTimeout);
      return addresses.any((address) => address.rawAddress.isNotEmpty);
    } on SocketException {
      return false;
    } on TimeoutException {
      return false;
    }
  }
}
