import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../../../shared/styles/app_motion.dart';
import '../../domain/usecase/refresh_local_data_usecase.dart';

// backOnline: the connection just returned after being offline; it turns
// into online after a short hold.
enum ConnectivityStatus { unknown, online, backOnline, offline }

// App-wide: drives the offline banner and refreshes the local data in the
// background at start and whenever the network comes back.
@lazySingleton
class ConnectivityCubit extends Cubit<ConnectivityStatus> {
  ConnectivityCubit(
    this._network,
    this._refresh,
    this._logger, {
    @ignoreParam this.backOnlineHold = AppMotion.backOnlineHold,
  }) : super(ConnectivityStatus.unknown);

  final NetworkInfo _network;
  final RefreshLocalDataUseCase _refresh;
  final AppLogger _logger;
  final Duration backOnlineHold;

  StreamSubscription<bool>? _subscription;
  Timer? _holdTimer;
  bool _isRefreshing = false;

  bool get _isOnline =>
      state == ConnectivityStatus.online ||
      state == ConnectivityStatus.backOnline;

  Future<void> start() async {
    _subscription ??= _network.onStatusChange.listen(_onStatus);
    _onStatus(await _network.isConnected);
  }

  void _onStatus(bool isOnline) {
    if (isClosed) return;
    if (isOnline) return _onOnline();
    _holdTimer?.cancel();
    emit(ConnectivityStatus.offline);
  }

  void _onOnline() {
    if (_isOnline) return;
    final wasOffline = state == ConnectivityStatus.offline;
    if (wasOffline) {
      emit(ConnectivityStatus.backOnline);
      _holdTimer = Timer(backOnlineHold, _endHold);
    } else {
      emit(ConnectivityStatus.online);
    }
    unawaited(_refreshInBackground());
  }

  void _endHold() {
    if (!isClosed) emit(ConnectivityStatus.online);
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
    _holdTimer?.cancel();
    await _subscription?.cancel();
    return super.close();
  }
}
