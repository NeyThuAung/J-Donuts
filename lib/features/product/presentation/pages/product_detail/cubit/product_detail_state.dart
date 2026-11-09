part of 'product_detail_cubit.dart';

@freezed
sealed class ProductDetailState with _$ProductDetailState {
  const factory ProductDetailState.loading() = ProductDetailLoading;

  const factory ProductDetailState.ready({
    required ProductEntity product,
    @Default(CartRules.minQuantity) int quantity,

    /// True for a moment after Add to cart, for the button's added state.
    @Default(false) bool justAdded,
  }) = ProductDetailReady;

  const factory ProductDetailState.notFound() = ProductDetailNotFound;

  const factory ProductDetailState.error(Failure failure) = ProductDetailError;
}

extension ProductDetailReadyTotal on ProductDetailReady {
  /// Live total on the button: quantity × price.
  int get totalMmk => quantity * product.priceMmk;
}
