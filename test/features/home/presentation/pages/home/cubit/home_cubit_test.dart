import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/core.dart';
import 'package:j_donuts/features/home/domain/entity/banner_entity.dart';
import 'package:j_donuts/features/home/domain/entity/home_section_entity.dart';
import 'package:j_donuts/features/home/domain/entity/shop_entity.dart';
import 'package:j_donuts/features/home/domain/usecase/refresh_local_data_usecase.dart';
import 'package:j_donuts/features/home/domain/usecase/watch_banners_usecase.dart';
import 'package:j_donuts/features/home/domain/usecase/watch_home_sections_usecase.dart';
import 'package:j_donuts/features/home/domain/usecase/watch_shops_usecase.dart';
import 'package:j_donuts/features/home/presentation/pages/home/cubit/home_cubit.dart';
import 'package:j_donuts/features/member/domain/entity/member_entity.dart';
import 'package:j_donuts/features/member/domain/entity/member_tier.dart';
import 'package:j_donuts/features/member/domain/usecase/watch_member_usecase.dart';
import 'package:j_donuts/shared/components/components.dart';
import 'package:mocktail/mocktail.dart';

class _MockWatchMember extends Mock implements WatchMemberUseCase {}

class _MockWatchBanners extends Mock implements WatchBannersUseCase {}

class _MockWatchSections extends Mock implements WatchHomeSectionsUseCase {}

class _MockWatchShops extends Mock implements WatchShopsUseCase {}

class _MockRefresh extends Mock implements RefreshLocalDataUseCase {}

class _MockSnackShower extends Mock implements ISnackShower {}

const _noParams = NoParams();
const _member = MemberEntity(
  name: 'Hania',
  tier: MemberTier.silver,
  points: 680000,
  notificationCount: 2,
  availableRewards: 3,
);

void main() {
  late StreamController<DataState<MemberEntity?>> member;
  late StreamController<DataState<List<BannerEntity>>> banners;
  late _MockWatchMember watchMember;
  late _MockWatchBanners watchBanners;
  late _MockRefresh refresh;
  late _MockSnackShower snack;
  late HomeCubit cubit;

  setUpAll(() => registerFallbackValue(const CacheFailure()));

  setUp(() {
    member = StreamController.broadcast();
    banners = StreamController.broadcast();
    watchMember = _MockWatchMember();
    watchBanners = _MockWatchBanners();
    final watchSections = _MockWatchSections();
    final watchShops = _MockWatchShops();
    refresh = _MockRefresh();
    snack = _MockSnackShower();
    when(() => watchMember(_noParams)).thenAnswer((_) => member.stream);
    when(() => watchBanners(_noParams)).thenAnswer((_) => banners.stream);
    when(() => watchSections(_noParams)).thenAnswer(
      (_) => Stream.value(const Success(<HomeSectionEntity>[])),
    );
    when(
      () => watchShops(_noParams),
    ).thenAnswer((_) => Stream.value(const Success(<ShopEntity>[])));
    cubit = HomeCubit(
      watchMember,
      watchBanners,
      watchSections,
      watchShops,
      refresh,
      snack,
    );
  });

  tearDown(() async {
    await cubit.close();
    await member.close();
    await banners.close();
  });

  Future<void> settle() => Future<void>.delayed(Duration.zero);

  group('HomeCubit', () {
    test('shows skeletons for every section until data arrives', () {
      expect(cubit.state.member, isA<SectionLoading<MemberEntity?>>());
      expect(cubit.state.banners, isA<SectionLoading<List<BannerEntity>>>());
      expect(
        cubit.state.sections,
        isA<SectionLoading<List<HomeSectionEntity>>>(),
      );
    });

    test('fills each section from its own stream', () async {
      cubit.start();
      member.add(const Success(_member));
      await settle();

      expect(
        cubit.state.member,
        const SectionData<MemberEntity?>.ready(_member),
      );
      expect(
        cubit.state.sections,
        isA<SectionReady<List<HomeSectionEntity>>>(),
      );
      expect(cubit.state.banners, isA<SectionLoading<List<BannerEntity>>>());
    });

    test('a failing section never blanks the others', () async {
      cubit.start();
      member.add(const Success(_member));
      banners.add(const Failed(CacheFailure()));
      await settle();

      expect(cubit.state.banners, isA<SectionFailed<List<BannerEntity>>>());
      expect(cubit.state.member, isA<SectionReady<MemberEntity?>>());
      expect(cubit.state.shops, isA<SectionReady<List<ShopEntity>>>());
    });

    test('follows later database updates without a reload', () async {
      cubit.start();
      member
        ..add(const Success(_member))
        ..add(Success(_member.copyWith(points: 700000)));
      await settle();

      final shown = cubit.state.member as SectionReady<MemberEntity?>;
      expect(shown.data?.points, 700000);
    });

    test('retry shows skeletons again and listens afresh', () async {
      cubit.start();
      banners.add(const Failed(CacheFailure()));
      await settle();

      await cubit.retry();

      expect(cubit.state.banners, isA<SectionLoading<List<BannerEntity>>>());
      verify(() => watchBanners(_noParams)).called(2);
    });

    test('pull to refresh keeps the content when the refresh fails', () async {
      when(
        () => refresh(_noParams),
      ).thenAnswer((_) async => const Failed(ConnectionFailure()));
      cubit.start();
      member.add(const Success(_member));
      await settle();

      await cubit.refresh();

      expect(cubit.state.member, isA<SectionReady<MemberEntity?>>());
      verify(() => snack.error(any(that: isA<ConnectionFailure>()))).called(1);
    });

    test('pull to refresh shows nothing extra when it succeeds', () async {
      when(
        () => refresh(_noParams),
      ).thenAnswer((_) async => const Success(null));

      await cubit.refresh();

      verifyNever(() => snack.error(any()));
    });
  });
}
