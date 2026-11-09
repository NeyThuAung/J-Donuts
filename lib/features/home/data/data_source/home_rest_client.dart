import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_envelope.dart';
import '../model/home_models.dart';

part 'home_rest_client.g.dart';

@lazySingleton
@RestApi()
abstract class HomeRestClient {
  @factoryMethod
  factory HomeRestClient(Dio dio) = _HomeRestClient;

  @GET('banners.json')
  Future<ApiEnvelope<List<BannerModel>>> getBanners();

  @GET('sections.json')
  Future<ApiEnvelope<List<SectionModel>>> getSections();

  @GET('shops.json')
  Future<ApiEnvelope<List<ShopModel>>> getShops();
}
