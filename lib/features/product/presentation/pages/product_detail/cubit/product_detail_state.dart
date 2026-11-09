part of 'product_detail_cubit.dart';

@freezed
sealed class ProductDetailState with _$ProductDetailState {
  const factory ProductDetailState.loading() = ProductDetailLoading;

  const factory ProductDetailState.ready({
    required ProductEntity product,
    @Default(CartRules.minQuantity) int quantity,

    @Default(false) bool justAdded,
  }) = ProductDetailReady;

  const factory ProductDetailState.notFound() = ProductDetailNotFound;

  const factory ProductDetailState.error(Failure failure) = ProductDetailError;
}

extension ProductDetailReadyTotal on ProductDetailReady {
  int get totalMmk => quantity * product.priceMmk;
}
