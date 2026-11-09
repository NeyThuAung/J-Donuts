part of 'home_cubit.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default(SectionLoading<MemberEntity?>()) SectionData<MemberEntity?> member,
    @Default(SectionLoading<List<BannerEntity>>())
    SectionData<List<BannerEntity>> banners,
    @Default(SectionLoading<List<HomeSectionEntity>>())
    SectionData<List<HomeSectionEntity>> sections,
    @Default(SectionLoading<List<ShopEntity>>())
    SectionData<List<ShopEntity>> shops,
  }) = _HomeState;
}
