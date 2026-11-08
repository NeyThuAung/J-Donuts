import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/core.dart';
import 'package:j_donuts/features/auth/domain/entity/user_entity.dart';
import 'package:j_donuts/features/auth/domain/usecase/check_session_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '_mock_auth_repository.dart';

void main() {
  late MockAuthRepository repository;
  late CheckSessionUseCase checkSession;

  setUp(() {
    repository = MockAuthRepository();
    checkSession = CheckSessionUseCase(repository);
  });

  group('CheckSessionUseCase', () {
    test('returns the signed-in member', () async {
      final user = UserEntity(
        id: '1',
        phone: '+959254135592',
        firstName: 'Ye Min',
        dateOfBirth: DateTime(1980, 5),
      );
      when(repository.currentUser).thenAnswer((_) async => user);

      expect(await checkSession(const NoParams()), Success<UserEntity?>(user));
    });

    test('returns null when signed out', () async {
      when(repository.currentUser).thenAnswer((_) async => null);

      expect(
        await checkSession(const NoParams()),
        const Success<UserEntity?>(null),
      );
    });

    test('returns CacheFailure when the session cannot be read', () async {
      when(repository.currentUser).thenThrow(const LocalException('locked'));

      expect(
        await checkSession(const NoParams()),
        const Failed<UserEntity?>(CacheFailure('locked')),
      );
    });
  });
}
