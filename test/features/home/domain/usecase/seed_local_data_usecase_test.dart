import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/core.dart';
import 'package:j_donuts/features/home/domain/entity/home_section_type.dart';
import 'package:j_donuts/features/member/data/model/member_model.dart';
import 'package:j_donuts/features/member/domain/entity/member_tier.dart';
import 'package:j_donuts/gen/assets.gen.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/local_data_harness.dart';

// First launch with no network: everything the screens need comes from the
// bundled seed files into the local database.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late LocalDataHarness data;

  setUp(() => data = LocalDataHarness());
  tearDown(() => data.close());

  group('SeedLocalDataUseCase', () {
    test(
      'fills every table from the bundled seed without the network',
      () async {
        data.goOffline();

        expect(await data.seedUseCase(const NoParams()), isA<Success<void>>());

        final member = await data.member.watchMember().first;
        expect(member?.tier, MemberTier.silver);
        expect(member?.points, 680000);
        expect(member?.pointsToNextTier, 500);
        expect(await data.products.watchProducts().first, hasLength(11));
        expect(await data.home.watchBanners().first, hasLength(3));
        expect(await data.home.watchShops().first, hasLength(4));
        expect(await data.rewards.watchTiers().first, hasLength(3));
        expect(await data.rewards.watchChallenges().first, hasLength(3));
      },
    );

    test('keeps the sections in their seed order', () async {
      await data.seedUseCase(const NoParams());

      final layouts = await data.home.watchSectionLayouts().first;

      expect(
        [for (final layout in layouts) layout.type],
        [
          HomeSectionType.seasonal,
          HomeSectionType.popular,
          HomeSectionType.orderAgain,
        ],
      );
    });

    test('points seed images at the bundled files', () async {
      await data.seedUseCase(const NoParams());

      final products = await data.products.watchProducts().first;

      expect(products.map((p) => p.image), everyElement(isA<AssetImageRef>()));
    });

    test('running again on the next launch writes nothing twice', () async {
      await data.seedUseCase(const NoParams());
      await data.seedUseCase(const NoParams());

      expect(await data.products.watchProducts().first, hasLength(11));
      expect(await data.home.watchBanners().first, hasLength(3));
    });

    test('never replaces newer data that a refresh already saved', () async {
      final newer = await data.seedAsApi(
        Assets.seed.v1.member,
        memberFromJson,
        version: 2,
      );
      when(data.memberApi.getMember).thenAnswer(
        (_) async => newer.copyWith(data: newer.data!.copyWith(points: 700000)),
      );
      await data.member.refresh();

      await data.seedUseCase(const NoParams());

      expect((await data.member.watchMember().first)?.points, 700000);
    });
  });
}
