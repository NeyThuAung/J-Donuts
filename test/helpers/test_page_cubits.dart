import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:j_donuts/core/core.dart';
import 'package:j_donuts/features/auth/domain/entity/auth_flow.dart';
import 'package:j_donuts/features/auth/domain/usecase/register_usecase.dart';
import 'package:j_donuts/features/auth/domain/usecase/request_otp_usecase.dart';
import 'package:j_donuts/features/auth/domain/usecase/verify_otp_usecase.dart';
import 'package:j_donuts/features/auth/presentation/pages/date_of_birth/cubit/date_of_birth_cubit.dart';
import 'package:j_donuts/features/auth/presentation/pages/name/cubit/name_cubit.dart';
import 'package:j_donuts/features/auth/presentation/pages/phone_number/cubit/phone_number_cubit.dart';
import 'package:j_donuts/features/auth/presentation/pages/phone_number/phone_number_page.dart';
import 'package:j_donuts/features/auth/presentation/pages/verify_otp/cubit/verify_otp_cubit.dart';
import 'package:j_donuts/features/home/domain/entity/banner_entity.dart';
import 'package:j_donuts/features/home/domain/entity/home_section_entity.dart';
import 'package:j_donuts/features/home/domain/entity/shop_entity.dart';
import 'package:j_donuts/features/home/domain/usecase/refresh_local_data_usecase.dart';
import 'package:j_donuts/features/home/domain/usecase/watch_banners_usecase.dart';
import 'package:j_donuts/features/home/domain/usecase/watch_home_sections_usecase.dart';
import 'package:j_donuts/features/home/domain/usecase/watch_shops_usecase.dart';
import 'package:j_donuts/features/home/presentation/pages/home/cubit/home_cubit.dart';
import 'package:j_donuts/features/member/domain/entity/member_entity.dart';
import 'package:j_donuts/features/member/domain/usecase/watch_member_usecase.dart';
import 'package:j_donuts/features/product/domain/entity/product_entity.dart';
import 'package:j_donuts/features/product/domain/usecase/watch_product_usecase.dart';
import 'package:j_donuts/features/product/presentation/pages/product_detail/cubit/product_detail_cubit.dart';
import 'package:j_donuts/features/rewards/domain/entity/challenge_entity.dart';
import 'package:j_donuts/features/rewards/domain/entity/tier_progress_entity.dart';
import 'package:j_donuts/features/rewards/domain/usecase/watch_challenges_usecase.dart';
import 'package:j_donuts/features/rewards/domain/usecase/watch_tier_progress_usecase.dart';
import 'package:j_donuts/features/rewards/presentation/pages/rewards/cubit/rewards_cubit.dart';
import 'package:j_donuts/shared/components/components.dart';
import 'package:mocktail/mocktail.dart';

class _MockRequestOtp extends Mock implements RequestOtpUseCase {}

class _MockVerifyOtp extends Mock implements VerifyOtpUseCase {}

class _MockRegister extends Mock implements RegisterUseCase {}

class _MockSnackShower extends Mock implements ISnackShower {}

class _MockRefresh extends Mock implements RefreshLocalDataUseCase {}

// Home with no data: every section settles on its empty state.
class _NoMember implements WatchMemberUseCase {
  @override
  Stream<DataState<MemberEntity?>> call(NoParams param) =>
      Stream.value(const Success(null));
}

class _NoBanners implements WatchBannersUseCase {
  @override
  Stream<DataState<List<BannerEntity>>> call(NoParams param) =>
      Stream.value(const Success([]));
}

class _NoSections implements WatchHomeSectionsUseCase {
  @override
  Stream<DataState<List<HomeSectionEntity>>> call(NoParams param) =>
      Stream.value(const Success([]));
}

// No product with that id: product detail shows its not-found state.
class _NoProduct implements WatchProductUseCase {
  @override
  Stream<DataState<ProductEntity?>> call(String productId) =>
      Stream.value(const Success(null));
}

class _NoShops implements WatchShopsUseCase {
  @override
  Stream<DataState<List<ShopEntity>>> call(NoParams param) =>
      Stream.value(const Success([]));
}

// Rewards with no data: both sections settle on their empty states.
class _NoTierProgress implements WatchTierProgressUseCase {
  @override
  Stream<DataState<TierProgressEntity?>> call(NoParams param) =>
      Stream.value(const Success(null));
}

class _NoChallenges implements WatchChallengesUseCase {
  @override
  Stream<DataState<List<ChallengeEntity>>> call(NoParams param) =>
      Stream.value(const Success([]));
}

/// Router tests build real routes, which inject their page cubits.
void registerPageCubits() {
  final snack = _MockSnackShower();
  GetIt.instance
    ..registerFactory(() => PhoneNumberCubit(_MockRequestOtp(), snack))
    ..registerFactory(
      () => VerifyOtpCubit(_MockVerifyOtp(), _MockRequestOtp(), snack),
    )
    ..registerFactory(NameCubit.new)
    ..registerFactory(() => DateOfBirthCubit(_MockRegister(), snack))
    ..registerFactory(
      () => HomeCubit(
        _NoMember(),
        _NoBanners(),
        _NoSections(),
        _NoShops(),
        _MockRefresh(),
        snack,
      ),
    )
    ..registerFactory(
      () => RewardsCubit(
        _NoTierProgress(),
        _NoChallenges(),
        _MockRefresh(),
        snack,
      ),
    )
    ..registerFactory(() => ProductDetailCubit(_NoProduct(), snack));
  addTearDown(GetIt.instance.reset);
}

AuthFlow phoneFlowOf(WidgetTester tester) => tester
    .element(find.byType(PhoneNumberPage))
    .read<PhoneNumberCubit>()
    .state
    .flow;
