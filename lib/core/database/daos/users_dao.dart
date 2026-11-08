import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/users.dart';

part 'users_dao.g.dart';

@DriftAccessor(tables: [Users])
class UsersDao extends DatabaseAccessor<AppDatabase> with _$UsersDaoMixin {
  UsersDao(super.attachedDatabase);

  Future<UserRow?> findByPhone(String phone) => (select(
    users,
  )..where((user) => user.phone.equals(phone))).getSingleOrNull();

  Future<UserRow?> findById(int id) =>
      (select(users)..where((user) => user.id.equals(id))).getSingleOrNull();

  /// Throws a SqliteException when the phone is already registered.
  Future<int> insertUser(UsersCompanion user) => into(users).insert(user);
}
