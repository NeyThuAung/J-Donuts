import '../../../../core/database/database.dart';
import '../../domain/entity/user_entity.dart';

extension UserRowMapper on UserRow {
  UserEntity toEntity() => UserEntity(
    id: '$id',
    phone: phone,
    firstName: firstName,
    lastName: lastName,
    dateOfBirth: dateOfBirth,
  );
}
