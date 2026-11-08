class UserEntity {
  const UserEntity({
    required this.id,
    required this.phone,
    required this.firstName,
    required this.dateOfBirth,
    this.lastName,
  });

  final String id;

  /// Normalized, e.g. +959254135592.
  final String phone;
  final String firstName;
  final String? lastName;
  final DateTime dateOfBirth;

  @override
  bool operator ==(Object other) =>
      other is UserEntity &&
      other.id == id &&
      other.phone == phone &&
      other.firstName == firstName &&
      other.lastName == lastName &&
      other.dateOfBirth == dateOfBirth;

  @override
  int get hashCode => Object.hash(id, phone, firstName, lastName, dateOfBirth);
}
