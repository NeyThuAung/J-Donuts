import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_envelope.dart';
import '../model/member_model.dart';

part 'member_rest_client.g.dart';

@lazySingleton
@RestApi()
abstract class MemberRestClient {
  @factoryMethod
  factory MemberRestClient(Dio dio) = _MemberRestClient;

  @GET('member.json')
  Future<ApiEnvelope<MemberModel>> getMember();
}
