import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/core.dart';
import 'package:j_donuts/features/auth/domain/usecase/log_out_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '_mock_auth_repository.dart';

void main() {
  group('LogOutUseCase', () {
    test('ends the session through the repository', () async {
      final repository = MockAuthRepository();
      when(repository.logOut).thenAnswer((_) async {});

      final result = await LogOutUseCase(repository)(const NoParams());

      expect(result, isA<Success<void>>());
      verify(repository.logOut).called(1);
    });
  });
}
