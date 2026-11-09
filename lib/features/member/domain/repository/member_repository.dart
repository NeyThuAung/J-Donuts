import '../entity/member_entity.dart';

abstract interface class MemberRepository {
  /// Emits null until the member has been seeded.
  Stream<MemberEntity?> watchMember();

  /// Writes the bundled member when it is newer than what is stored.
  Future<void> seed();

  /// Fetches the member from the API and stores it when its version is newer.
  Future<void> refresh();
}
