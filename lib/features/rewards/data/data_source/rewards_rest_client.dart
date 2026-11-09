import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_envelope.dart';
import '../model/rewards_models.dart';

part 'rewards_rest_client.g.dart';

@lazySingleton
@RestApi()
abstract class RewardsRestClient {
  @factoryMethod
  factory RewardsRestClient(Dio dio) = _RewardsRestClient;

  @GET('tiers.json')
  Future<ApiEnvelope<List<TierModel>>> getTiers();

  @GET('challenges.json')
  Future<ApiEnvelope<List<ChallengeModel>>> getChallenges();
}
