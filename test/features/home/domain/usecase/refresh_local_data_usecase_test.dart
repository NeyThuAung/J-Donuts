import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/core.dart';
import 'package:j_donuts/features/member/data/model/member_model.dart';
import 'package:j_donuts/features/product/data/model/product_model.dart';
import 'package:j_donuts/gen/assets.gen.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/local_data_harness.dart';

// The local database is the source of truth: a refresh only ever adds newer
// data, and a failed one leaves what the screens show untouched.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late LocalDataHarness data;

  setUp(() async {
    data = LocalDataHarness();
    await data.seedUseCase(const NoParams());
  });
  tearDown(() => data.close());

  Future<void> serveMember({required int version, required int points}) async {
    final envelope = await data.seedAsApi(
      Assets.seed.v1.member,
      memberFromJson,
      version: version,
    );
    when(data.memberApi.getMember).thenAnswer(
      (_) async =>
          envelope.copyWith(data: envelope.data!.copyWith(points: points)),
    );
  }

  group('RefreshLocalDataUseCase', () {
    test(
      'reports no connection in airplane mode and keeps local data',
      () async {
        data.goOffline();

        final result = await data.refreshUseCase(const NoParams());

        expect(failureOf(result), isA<ConnectionFailure>());
        expect((await data.member.watchMember().first)?.points, 680000);
        expect(await data.products.watchProducts().first, hasLength(11));
        expect(await data.rewards.watchChallenges().first, hasLength(3));
      },
    );

    test('saves newer data from the API into the local database', () async {
      await serveMember(version: 2, points: 700000);

      await data.member.refresh();

      expect((await data.member.watchMember().first)?.points, 700000);
    });

    test('ignores API data that is not newer than what is stored', () async {
      await serveMember(version: 1, points: 1);

      await data.member.refresh();

      expect((await data.member.watchMember().first)?.points, 680000);
    });

    test('updates screens that are already watching the member', () async {
      final updates = data.member.watchMember().map((m) => m?.points);
      final seen = expectLater(updates, emitsInOrder([680000, 700000]));
      await serveMember(version: 2, points: 700000);

      await data.member.refresh();

      await seen;
    });

    test('stops at the first failure and leaves the rest untouched', () async {
      await serveMember(version: 2, points: 700000);
      when(data.productApi.getProducts).thenThrow(
        DioException(
          requestOptions: RequestOptions(),
          type: DioExceptionType.receiveTimeout,
        ),
      );

      final result = await data.refreshUseCase(const NoParams());

      expect(failureOf(result), isA<TimeoutFailure>());
      expect((await data.member.watchMember().first)?.points, 700000);
      verifyNever(data.homeApi.getBanners);
      verifyNever(data.rewardsApi.getTiers);
    });

    test('treats a malformed API response as a server failure', () async {
      final products = await data.seedAsApi(
        Assets.seed.v1.products,
        productsFromJson,
        version: 2,
      );
      when(
        data.productApi.getProducts,
      ).thenAnswer((_) async => products.copyWith(data: null));
      await serveMember(version: 1, points: 1);

      final result = await data.refreshUseCase(const NoParams());

      expect(failureOf(result), isA<ServerFailure>());
      expect(await data.products.watchProducts().first, hasLength(11));
    });
  });
}
