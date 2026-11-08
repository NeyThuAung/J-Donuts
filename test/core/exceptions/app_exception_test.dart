import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/core.dart';

void main() {
  group('AppException.toFailure', () {
    final cases = <AppException, Failure>{
      const InternetConnectionException('offline'): const ConnectionFailure(
        'offline',
      ),
      const RequestTimeoutException('slow'): const TimeoutFailure('slow'),
      const NotFoundException('gone'): const NotFoundFailure('gone'),
      const BadRequestException('bad'): const BadRequestFailure('bad'),
      const UnauthorizedException('expired'): const SessionFailure('expired'),
      const ServerException('down'): const ServerFailure('down'),
      const LocalException('disk'): const CacheFailure('disk'),
    };

    cases.forEach((exception, failure) {
      test('maps ${exception.runtimeType} to ${failure.runtimeType}', () {
        expect(exception.toFailure(), failure);
      });
    });
  });
}
