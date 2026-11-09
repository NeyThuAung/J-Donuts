import 'package:injectable/injectable.dart';

import '../../../../core/data_state/data_state.dart';
import '../../../../core/usecase/guard.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../auth/domain/repository/auth_repository.dart';
import '../entity/member_entity.dart';
import '../repository/member_repository.dart';

/// The registered first name replaces the seeded member name.
@lazySingleton
class WatchMemberUseCase implements StreamUseCase<MemberEntity?, NoParams> {
  const WatchMemberUseCase(this._members, this._auth);

  final MemberRepository _members;
  final AuthRepository _auth;

  @override
  Stream<DataState<MemberEntity?>> call(NoParams param) =>
      guardStream(_members.watchMember().asyncMap(_withRegisteredName));

  Future<MemberEntity?> _withRegisteredName(MemberEntity? member) async {
    if (member == null) return null;
    final user = await _auth.currentUser();
    return user == null ? member : member.copyWith(name: user.firstName);
  }
}
