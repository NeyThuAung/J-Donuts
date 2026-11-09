import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/members.dart';

part 'members_dao.g.dart';

@DriftAccessor(tables: [Members])
class MembersDao extends DatabaseAccessor<AppDatabase> with _$MembersDaoMixin {
  MembersDao(super.attachedDatabase);

  Stream<MemberRow?> watchMember() => _member.watchSingleOrNull();

  Future<MemberRow?> readMember() => _member.getSingleOrNull();

  /// The row's id is always [Members.singleRowId].
  Future<void> saveMember(MemberRow member) =>
      into(members).insertOnConflictUpdate(member);

  SimpleSelectStatement<$MembersTable, MemberRow> get _member => select(
    members,
  )..where((member) => member.id.equals(Members.singleRowId));
}
