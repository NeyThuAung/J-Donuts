import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../../../core/database/database.dart';
import '../../../../gen/assets.gen.dart';
import '../../domain/entity/member_entity.dart';
import '../../domain/repository/member_repository.dart';
import '../data_source/member_local_data_source.dart';
import '../data_source/member_rest_client.dart';
import '../model/member_mapper.dart';
import '../model/member_model.dart';

@LazySingleton(as: MemberRepository)
class MemberRepositoryImpl implements MemberRepository {
  const MemberRepositoryImpl(
    this._local,
    this._remote,
    this._seedReader,
    this._images,
  );

  final MemberLocalDataSource _local;
  final MemberRestClient _remote;
  final SeedAssetReader _seedReader;
  final ImageRefResolver _images;

  @override
  Stream<MemberEntity?> watchMember() => runLocalStream(
    _local.watchMember().map((row) => row?.toEntity(_images)),
  );

  @override
  Future<void> seed() async {
    final envelope = await runLocal(
      () => _seedReader.read(Assets.seed.v1.member, memberFromJson),
    );
    await _save(envelope);
  }

  @override
  Future<void> refresh() async {
    final envelope = await runRemote(_remote.getMember);
    await _save(envelope);
  }

  Future<void> _save(ApiEnvelope<MemberModel> envelope) => runLocal(
    () => saveIfNewer(
      envelope,
      storedVersion: _local.readVersion,
      save: (member, version) => _local.save(member.toRow(), version),
    ),
  );
}
