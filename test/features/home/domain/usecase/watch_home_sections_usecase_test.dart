import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/core.dart';
import 'package:j_donuts/features/home/domain/entity/home_section_entity.dart';
import 'package:j_donuts/features/home/domain/entity/home_section_type.dart';
import 'package:j_donuts/features/home/domain/repository/home_repository.dart';
import 'package:j_donuts/features/home/domain/usecase/watch_home_sections_usecase.dart';
import 'package:j_donuts/features/product/domain/entity/product_entity.dart';
import 'package:j_donuts/features/product/domain/repository/product_repository.dart';
import 'package:mocktail/mocktail.dart';

class _MockHomeRepository extends Mock implements HomeRepository {}

class _MockProductRepository extends Mock implements ProductRepository {}

ProductEntity _product(String id) => ProductEntity(
  id: id,
  code: 'JD$id',
  name: 'Donut $id',
  priceMmk: 3200,
  isNew: false,
  image: const AssetImageRef('donut.png'),
  description: '',
);

const _popular = HomeSectionLayout(
  id: 's_popular',
  type: HomeSectionType.popular,
  productIds: ['p2', 'p_missing', 'p1'],
);

List<String> _ids(DataState<List<HomeSectionEntity>> state) => [
  for (final product in state.dataOrNull!.single.products) product.id,
];

void main() {
  late StreamController<List<HomeSectionLayout>> layouts;
  late StreamController<List<ProductEntity>> products;
  late WatchHomeSectionsUseCase useCase;

  setUp(() {
    layouts = StreamController();
    products = StreamController();
    final home = _MockHomeRepository();
    final productRepository = _MockProductRepository();
    when(home.watchSectionLayouts).thenAnswer((_) => layouts.stream);
    when(productRepository.watchProducts).thenAnswer((_) => products.stream);
    useCase = WatchHomeSectionsUseCase(home, productRepository);
  });

  tearDown(() async {
    await layouts.close();
    await products.close();
  });

  group('WatchHomeSectionsUseCase', () {
    test('fills each section with its products in the section order', () {
      final sections = useCase(const NoParams());

      layouts.add([_popular]);
      products.add([_product('p1'), _product('p2')]);

      expect(sections.map(_ids), emits(['p2', 'p1']));
    });

    test('skips ids whose product is not stored', () {
      final sections = useCase(const NoParams());

      layouts.add([_popular]);
      products.add([_product('p1')]);

      expect(sections.map(_ids), emits(['p1']));
    });

    test('updates when the products change', () {
      final sections = useCase(const NoParams());

      layouts.add([_popular]);
      products
        ..add([_product('p1')])
        ..add([_product('p1'), _product('p2')]);

      expect(
        sections.map(_ids),
        emitsInOrder([
          ['p1'],
          ['p2', 'p1'],
        ]),
      );
    });

    test('reports a database error as a failure and keeps listening', () {
      final sections = useCase(const NoParams());

      products.add([_product('p1')]);
      layouts
        ..addError(const LocalException('disk'))
        ..add([_popular]);

      expect(
        sections,
        emitsInOrder([
          isA<Failed<List<HomeSectionEntity>>>(),
          isA<Success<List<HomeSectionEntity>>>(),
        ]),
      );
    });
  });
}
