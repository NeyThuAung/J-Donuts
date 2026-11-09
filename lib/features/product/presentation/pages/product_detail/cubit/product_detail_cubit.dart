import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../../../../../../shared/components/components.dart';
import '../../../../../../shared/styles/styles.dart';
import '../../../../domain/cart_rules.dart';
import '../../../../domain/entity/product_entity.dart';
import '../../../../domain/usecase/watch_product_usecase.dart';

part 'product_detail_cubit.freezed.dart';
part 'product_detail_state.dart';

// Follows the product in the local database; the cart is visual feedback
// only (brief), so Add to cart confirms without storing anything.
@injectable
class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit(this._watchProduct, this._snack)
    : super(const ProductDetailState.loading());

  final WatchProductUseCase _watchProduct;
  final ISnackShower _snack;

  StreamSubscription<DataState<ProductEntity?>>? _subscription;
  Timer? _addedTimer;
  String? _productId;

  void start(String productId) {
    _productId = productId;
    unawaited(_subscription?.cancel());
    _subscription = _watchProduct(productId).listen(_onProduct);
  }

  void retry() {
    final productId = _productId;
    if (productId == null) return;
    emit(const ProductDetailState.loading());
    start(productId);
  }

  void increment() => _setQuantity(1);

  void decrement() => _setQuantity(-1);

  void addToCart() {
    final current = state;
    if (current is! ProductDetailReady || current.justAdded) return;
    emit(current.copyWith(justAdded: true));
    _snack.success(
      (l10n) => l10n.productAddedMessage(
        current.quantity,
        current.product.name,
      ),
    );
    _addedTimer?.cancel();
    _addedTimer = Timer(AppMotion.addedFeedback, _clearAdded);
  }

  // Keeps the chosen quantity when the product updates in the background.
  void _onProduct(DataState<ProductEntity?> result) {
    if (isClosed) return;
    final current = state;
    final next = switch (result) {
      Success(data: final product?) when current is ProductDetailReady =>
        current.copyWith(product: product),
      Success(data: final product?) => ProductDetailState.ready(
        product: product,
      ),
      Success() => const ProductDetailState.notFound(),
      Failed(:final failure) => ProductDetailState.error(failure),
    };
    emit(next);
  }

  void _setQuantity(int change) {
    final current = state;
    if (current is! ProductDetailReady) return;
    final quantity = (current.quantity + change).clamp(
      CartRules.minQuantity,
      CartRules.maxQuantity,
    );
    if (quantity != current.quantity) {
      emit(current.copyWith(quantity: quantity));
    }
  }

  void _clearAdded() {
    final current = state;
    if (!isClosed && current is ProductDetailReady) {
      emit(current.copyWith(justAdded: false));
    }
  }

  @override
  Future<void> close() async {
    _addedTimer?.cancel();
    await _subscription?.cancel();
    return super.close();
  }
}
