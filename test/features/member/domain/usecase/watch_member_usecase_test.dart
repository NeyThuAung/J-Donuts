import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/core.dart';
import 'package:j_donuts/features/auth/domain/entity/user_entity.dart';
import 'package:j_donuts/features/auth/domain/repository/auth_repository.dart';
import 'package:j_donuts/features/member/domain/entity/member_entity.dart';
import 'package:j_donuts/features/member/domain/entity/member_tier.dart';
import 'package:j_donuts/features/member/domain/repository/member_repository.dart';
import 'package:j_donuts/features/member/domain/usecase/watch_member_usecase.dart';
import 'package:mocktail/mocktail.dart';

class _MockMemberRepository extends Mock implements MemberRepository {}

class _MockAuthRepository extends Mock implements AuthRepository {}

const _seeded = MemberEntity(
  name: 'Hania',
  tier: MemberTier.silver,
  points: 680000,
  notificationCount: 2,
  availableRewards: 3,
);

void main() {
  late _MockMemberRepository members;
  late _MockAuthRepository auth;

  setUp(() {
    members = _MockMemberRepository();
    auth = _MockAuthRepository();
  });

  Stream<String?> names() => WatchMemberUseCase(
    members,
    auth,
  )(const NoParams()).map((state) => state.dataOrNull?.name);

  group('WatchMemberUseCase', () {
    test('shows the registered first name instead of the seeded one', () {
      when(members.watchMember).thenAnswer((_) => Stream.value(_seeded));
      when(auth.currentUser).thenAnswer(
        (_) async => UserEntity(
          id: '1',
          phone: '+959254135592',
          firstName: 'Ye Min',
          dateOfBirth: DateTime(1990),
        ),
      );

      expect(names(), emits('Ye Min'));
    });

    test('keeps the seeded name when nobody is signed in', () {
      when(members.watchMember).thenAnswer((_) => Stream.value(_seeded));
      when(auth.currentUser).thenAnswer((_) async => null);

      expect(names(), emits('Hania'));
    });

    test('is empty until the member has been seeded', () {
      when(members.watchMember).thenAnswer((_) => Stream.value(null));

      expect(names(), emits(isNull));
      verifyNever(auth.currentUser);
    });
  });
}
