import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:j_donuts/core/core.dart';
import 'package:j_donuts/core/database/database.dart';
import 'package:j_donuts/features/home/data/data_source/home_local_data_source.dart';
import 'package:j_donuts/features/home/data/data_source/home_rest_client.dart';
import 'package:j_donuts/features/home/data/repository_impl/home_repository_impl.dart';
import 'package:j_donuts/features/home/domain/usecase/refresh_local_data_usecase.dart';
import 'package:j_donuts/features/home/domain/usecase/seed_local_data_usecase.dart';
import 'package:j_donuts/features/member/data/data_source/member_local_data_source.dart';
import 'package:j_donuts/features/member/data/data_source/member_rest_client.dart';
import 'package:j_donuts/features/member/data/repository_impl/member_repository_impl.dart';
import 'package:j_donuts/features/product/data/data_source/product_local_data_source.dart';
import 'package:j_donuts/features/product/data/data_source/product_rest_client.dart';
import 'package:j_donuts/features/product/data/repository_impl/product_repository_impl.dart';
import 'package:j_donuts/features/rewards/data/data_source/rewards_local_data_source.dart';
import 'package:j_donuts/features/rewards/data/data_source/rewards_rest_client.dart';
import 'package:j_donuts/features/rewards/data/repository_impl/rewards_repository_impl.dart';
import 'package:j_donuts/gen/assets.gen.dart';
import 'package:mocktail/mocktail.dart';

class MockMemberRestClient extends Mock implements MemberRestClient {}

class MockProductRestClient extends Mock implements ProductRestClient {}

class MockHomeRestClient extends Mock implements HomeRestClient {}

class MockRewardsRestClient extends Mock implements RewardsRestClient {}

/// The real local data stack over an in-memory database and the bundled
/// seed files; only the API clients are mocks.
class LocalDataHarness {
  LocalDataHarness() : database = AppDatabase(NativeDatabase.memory()) {
    member = MemberRepositoryImpl(
      MemberLocalDataSourceImpl(database),
      memberApi,
      seedReader,
      images,
    );
    products = ProductRepositoryImpl(
      ProductLocalDataSourceImpl(database),
      productApi,
      seedReader,
      images,
    );
    home = HomeRepositoryImpl(
      HomeLocalDataSourceImpl(database),
      homeApi,
      seedReader,
      images,
    );
    rewards = RewardsRepositoryImpl(
      RewardsLocalDataSourceImpl(database),
      rewardsApi,
      seedReader,
      images,
    );
  }

  final AppDatabase database;
  final seedReader = SeedAssetReader(rootBundle);
  final images = ImageRefResolver(
    bundledPaths: {for (final image in Assets.images.values) image.path},
    bundledDirectory: 'assets/images',
  );
  final memberApi = MockMemberRestClient();
  final productApi = MockProductRestClient();
  final homeApi = MockHomeRestClient();
  final rewardsApi = MockRewardsRestClient();

  late final MemberRepositoryImpl member;
  late final ProductRepositoryImpl products;
  late final HomeRepositoryImpl home;
  late final RewardsRepositoryImpl rewards;

  SeedLocalDataUseCase get seedUseCase =>
      SeedLocalDataUseCase(member, products, home, rewards);

  RefreshLocalDataUseCase get refreshUseCase =>
      RefreshLocalDataUseCase(member, products, home, rewards);

  /// Every API call fails as it does in airplane mode.
  void goOffline() {
    final offline = DioException(
      requestOptions: RequestOptions(),
      type: DioExceptionType.connectionError,
    );
    when(memberApi.getMember).thenThrow(offline);
    when(productApi.getProducts).thenThrow(offline);
    when(homeApi.getBanners).thenThrow(offline);
    when(homeApi.getSections).thenThrow(offline);
    when(homeApi.getShops).thenThrow(offline);
    when(rewardsApi.getTiers).thenThrow(offline);
    when(rewardsApi.getChallenges).thenThrow(offline);
  }

  /// A bundled seed file as the API would send it, at [version].
  Future<ApiEnvelope<T>> seedAsApi<T>(
    String path,
    T Function(Object? json) fromJson, {
    required int version,
  }) async {
    final envelope = await seedReader.read(path, fromJson);
    return envelope.copyWith(meta: ApiMeta(version: version));
  }

  Future<void> close() => database.close();
}

/// Failure type of a [DataState], for compact expectations.
Failure? failureOf(DataState<Object?> state) => switch (state) {
  Failed(:final failure) => failure,
  Success() => null,
};
