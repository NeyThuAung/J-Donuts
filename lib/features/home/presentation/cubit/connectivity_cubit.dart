import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/usecase/refresh_local_data_usecase.dart';

enum ConnectivityStatus { unknown, online, offline }

// App-wide: drives the offline banner and refreshes the local data in the
// background at start and whenever the network comes back.
@lazySingleton
class ConnectivityCubit extends Cubit<ConnectivityStatus> {
  ConnectivityCubit(this._network, this._refresh, this._logger)
    : super(ConnectivityStatus.unknown);

  final NetworkInfo _network;
  final RefreshLocalDataUseCase _refresh;
  final AppLogger _logger;

  StreamSubscription<bool>? _subscription;
  bool _isRefreshing = false;

  Future<void> start() async {
    _subscription ??= _network.onStatusChange.listen(_onStatus);
    _onStatus(await _network.isConnected);
  }

  void _onStatus(bool isOnline) {
    if (isClosed) return;
    final cameOnline = isOnline && state != ConnectivityStatus.online;
    emit(isOnline ? ConnectivityStatus.online : ConnectivityStatus.offline);
    if (cameOnline) unawaited(_refreshInBackground());
  }

  // Silent on failure: the screens keep their local data, and
  // pull-to-refresh reports errors.
  Future<void> _refreshInBackground() async {
    if (_isRefreshing) return;
    _isRefreshing = true;
    final result = await _refresh(const NoParams());
    _isRefreshing = false;
    result.onError(
      (failure) => _logger.debug('Background refresh failed: $failure'),
    );
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
