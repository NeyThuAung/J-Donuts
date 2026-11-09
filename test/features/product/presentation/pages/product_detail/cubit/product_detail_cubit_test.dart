import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/core.dart';
import 'package:j_donuts/features/product/domain/cart_rules.dart';
import 'package:j_donuts/features/product/domain/entity/product_entity.dart';
import 'package:j_donuts/features/product/domain/usecase/watch_product_usecase.dart';
import 'package:j_donuts/features/product/presentation/pages/product_detail/cubit/product_detail_cubit.dart';
import 'package:j_donuts/shared/components/components.dart';
import 'package:j_donuts/shared/styles/styles.dart';
import 'package:mocktail/mocktail.dart';

class _MockWatchProduct extends Mock implements WatchProductUseCase {}

class _MockSnackShower extends Mock implements ISnackShower {}

const _id = 'p_coconut';
const _coconut = ProductEntity(
  id: _id,
  code: 'JD022123',
  name: 'Coconut Donut',
  priceMmk: 3200,
  isNew: true,
  image: AssetImageRef('donut.png'),
  description: 'Soft and sweet.',
);

void main() {
  late StreamController<DataState<ProductEntity?>> product;
  late _MockSnackShower snack;
  late ProductDetailCubit cubit;

  setUp(() {
    product = StreamController.broadcast();
    final watchProduct = _MockWatchProduct();
    snack = _MockSnackShower();
    when(() => watchProduct(_id)).thenAnswer((_) => product.stream);
    cubit = ProductDetailCubit(watchProduct, snack);
  });

  tearDown(() async {
    await cubit.close();
    await product.close();
  });

  Future<void> settle() => Future<void>.delayed(Duration.zero);

  ProductDetailReady ready() => cubit.state as ProductDetailReady;

  Future<void> startReady() async {
    cubit.start(_id);
    product.add(const Success(_coconut));
    await settle();
  }

  group('ProductDetailCubit', () {
    test('shows the skeleton until the product is read', () {
      cubit.start(_id);

      expect(cubit.state, isA<ProductDetailLoading>());
    });

    test('shows the tapped product at once, so the Hero can land', () {
      cubit.start(_id, preview: _coconut);

      expect(ready().product, _coconut);
    });

    test('starts at one with the live total', () async {
      await startReady();

      expect(ready().quantity, CartRules.minQuantity);
      expect(ready().totalMmk, 3200);
    });

    test('updates the total as the quantity changes', () async {
      await startReady();

      cubit
        ..increment()
        ..increment();

      expect(ready().quantity, 3);
      expect(ready().totalMmk, 9600);
    });

    test('never goes below one', () async {
      await startReady();

      cubit.decrement();

      expect(ready().quantity, CartRules.minQuantity);
    });

    test('never goes above the cart limit', () async {
      await startReady();

      for (var i = 0; i < CartRules.maxQuantity + 2; i++) {
        cubit.increment();
      }

      expect(ready().quantity, CartRules.maxQuantity);
    });

    test('keeps the chosen quantity when the product updates', () async {
      await startReady();
      cubit.increment();

      product.add(
        const Success(
          ProductEntity(
            id: _id,
            code: 'JD022123',
            name: 'Coconut Donut',
            priceMmk: 3500,
            isNew: false,
            image: AssetImageRef('donut.png'),
            description: 'Soft and sweet.',
          ),
        ),
      );
      await settle();

      expect(ready().quantity, 2);
      expect(ready().totalMmk, 7000);
    });

    test('shows not found for an unknown id', () async {
      cubit.start(_id);
      product.add(const Success(null));
      await settle();

      expect(cubit.state, isA<ProductDetailNotFound>());
    });

    test('shows an error the user can retry', () async {
      cubit.start(_id);
      product.add(const Failed(CacheFailure()));
      await settle();
      expect(cubit.state, isA<ProductDetailError>());

      cubit.retry();
      product.add(const Success(_coconut));
      await settle();

      expect(cubit.state, isA<ProductDetailReady>());
    });

    testWidgets('Add to cart confirms, then the button returns', (
      tester,
    ) async {
      cubit.start(_id, preview: _coconut);

      cubit
        ..addToCart()
        ..addToCart();

      expect(ready().justAdded, isTrue);
      verify(() => snack.success(any())).called(1);
      await tester.pump(AppMotion.addedFeedback);
      expect(ready().justAdded, isFalse);
    });
  });
}
