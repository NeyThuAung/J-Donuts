import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_envelope.dart';
import '../model/product_model.dart';

part 'product_rest_client.g.dart';

@lazySingleton
@RestApi()
abstract class ProductRestClient {
  @factoryMethod
  factory ProductRestClient(Dio dio) = _ProductRestClient;

  @GET('products.json')
  Future<ApiEnvelope<List<ProductModel>>> getProducts();
}
