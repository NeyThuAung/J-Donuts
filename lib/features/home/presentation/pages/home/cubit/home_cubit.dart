import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../../../../../../shared/components/components.dart';
import '../../../../../member/domain/entity/member_entity.dart';
import '../../../../../member/domain/usecase/watch_member_usecase.dart';
import '../../../../domain/entity/banner_entity.dart';
import '../../../../domain/entity/home_section_entity.dart';
import '../../../../domain/entity/shop_entity.dart';
import '../../../../domain/usecase/refresh_local_data_usecase.dart';
import '../../../../domain/usecase/watch_banners_usecase.dart';
import '../../../../domain/usecase/watch_home_sections_usecase.dart';
import '../../../../domain/usecase/watch_shops_usecase.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

// Every section follows its own local-database stream; refresh only writes
// to the database, and the streams update the screen.
@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this._watchMember,
    this._watchBanners,
    this._watchSections,
    this._watchShops,
    this._refresh,
    this._snack,
  ) : super(const HomeState());

  final WatchMemberUseCase _watchMember;
  final WatchBannersUseCase _watchBanners;
  final WatchHomeSectionsUseCase _watchSections;
  final WatchShopsUseCase _watchShops;
  final RefreshLocalDataUseCase _refresh;
  final ISnackShower _snack;

  final _subscriptions = <StreamSubscription<Object?>>[];

  void start() {
    const noParams = NoParams();
    _subscriptions.addAll([
      _watchMember(noParams).listen(
        (result) => _update((s) => s.copyWith(member: result.toSection())),
      ),
      _watchBanners(noParams).listen(
        (result) => _update((s) => s.copyWith(banners: result.toSection())),
      ),
      _watchSections(noParams).listen(
        (result) => _update((s) => s.copyWith(sections: result.toSection())),
      ),
      _watchShops(noParams).listen(
        (result) => _update((s) => s.copyWith(shops: result.toSection())),
      ),
    ]);
  }

  /// Re-reads every section after a failure, showing skeletons again.
  Future<void> retry() async {
    await _cancelSubscriptions();
    if (isClosed) return;
    emit(const HomeState());
    start();
  }

  /// Pull to refresh: content stays on screen; a failure shows a snack.
  Future<void> refresh() async {
    final result = await _refresh(const NoParams());
    if (isClosed) return;
    result.onError(_snack.error);
  }

  void _update(HomeState Function(HomeState state) change) {
    if (!isClosed) emit(change(state));
  }

  Future<void> _cancelSubscriptions() async {
    await Future.wait(_subscriptions.map((sub) => sub.cancel()));
    _subscriptions.clear();
  }

  @override
  Future<void> close() async {
    await _cancelSubscriptions();
    return super.close();
  }
}
