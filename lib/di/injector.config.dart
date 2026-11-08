// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:j_donuts/core/database/database.dart' as _i416;
import 'package:j_donuts/core/logging/app_logger.dart' as _i479;
import 'package:j_donuts/core/network/network_info.dart' as _i296;
import 'package:j_donuts/di/third_party_modules/database_module.dart' as _i1057;
import 'package:j_donuts/di/third_party_modules/logger_module.dart' as _i20;
import 'package:j_donuts/di/third_party_modules/network_module.dart' as _i869;
import 'package:j_donuts/di/third_party_modules/storage_module.dart' as _i767;
import 'package:j_donuts/features/auth/data/data_source/fake_latency.dart'
    as _i88;
import 'package:j_donuts/features/auth/data/data_source/session_local_data_source.dart'
    as _i702;
import 'package:j_donuts/features/auth/data/repository_impl/fake_auth_repository.dart'
    as _i315;
import 'package:j_donuts/features/auth/domain/repository/auth_repository.dart'
    as _i907;
import 'package:j_donuts/features/auth/domain/usecase/check_session_usecase.dart'
    as _i191;
import 'package:j_donuts/features/auth/domain/usecase/log_out_usecase.dart'
    as _i865;
import 'package:j_donuts/features/auth/domain/usecase/register_usecase.dart'
    as _i872;
import 'package:j_donuts/features/auth/domain/usecase/request_otp_usecase.dart'
    as _i653;
import 'package:j_donuts/features/auth/domain/usecase/verify_otp_usecase.dart'
    as _i617;
import 'package:j_donuts/features/auth/presentation/cubit/authentication_cubit.dart'
    as _i618;
import 'package:j_donuts/features/auth/presentation/pages/name/cubit/name_cubit.dart'
    as _i965;
import 'package:j_donuts/features/auth/presentation/pages/phone_number/cubit/phone_number_cubit.dart'
    as _i1028;
import 'package:j_donuts/features/auth/presentation/pages/verify_otp/cubit/verify_otp_cubit.dart'
    as _i131;
import 'package:j_donuts/navigation/navigation_key_provider.dart' as _i168;
import 'package:j_donuts/navigation/navigation_router.dart' as _i1038;
import 'package:j_donuts/shared/components/components.dart' as _i995;
import 'package:j_donuts/shared/components/snack/snack_shower.dart' as _i52;
import 'package:logger/logger.dart' as _i974;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final databaseModule = _$DatabaseModule();
    final loggerModule = _$LoggerModule();
    final networkModule = _$NetworkModule();
    final storageModule = _$StorageModule();
    gh.factory<_i965.NameCubit>(() => _i965.NameCubit());
    gh.lazySingleton<_i416.AppDatabase>(
      () => databaseModule.database,
      dispose: _i1057.closeDatabase,
    );
    gh.lazySingleton<_i974.Logger>(() => loggerModule.logger);
    gh.lazySingleton<_i895.Connectivity>(() => networkModule.connectivity);
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => storageModule.secureStorage,
    );
    gh.lazySingleton<_i88.FakeLatency>(() => const _i88.FakeLatency());
    gh.lazySingleton<_i416.UsersDao>(
      () => databaseModule.usersDao(gh<_i416.AppDatabase>()),
    );
    gh.singleton<_i168.INavigationKeyProvider>(
      () => _i168.NavigationKeyProvider(),
    );
    gh.lazySingleton<_i702.SessionLocalDataSource>(
      () => _i702.SessionLocalDataSourceImpl(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i52.ISnackShower>(
      () => _i52.SnackShower(gh<_i168.INavigationKeyProvider>()),
    );
    gh.lazySingleton<_i296.NetworkInfo>(
      () => networkModule.networkInfo(gh<_i895.Connectivity>()),
    );
    gh.lazySingleton<_i479.AppLogger>(
      () => loggerModule.appLogger(gh<_i974.Logger>()),
    );
    gh.lazySingleton<_i907.AuthRepository>(
      () => _i315.FakeAuthRepository(
        gh<_i416.UsersDao>(),
        gh<_i702.SessionLocalDataSource>(),
        gh<_i88.FakeLatency>(),
      ),
    );
    gh.lazySingleton<_i191.CheckSessionUseCase>(
      () => _i191.CheckSessionUseCase(gh<_i907.AuthRepository>()),
    );
    gh.lazySingleton<_i865.LogOutUseCase>(
      () => _i865.LogOutUseCase(gh<_i907.AuthRepository>()),
    );
    gh.lazySingleton<_i872.RegisterUseCase>(
      () => _i872.RegisterUseCase(gh<_i907.AuthRepository>()),
    );
    gh.lazySingleton<_i653.RequestOtpUseCase>(
      () => _i653.RequestOtpUseCase(gh<_i907.AuthRepository>()),
    );
    gh.lazySingleton<_i617.VerifyOtpUseCase>(
      () => _i617.VerifyOtpUseCase(gh<_i907.AuthRepository>()),
    );
    gh.factory<_i131.VerifyOtpCubit>(
      () => _i131.VerifyOtpCubit(
        gh<_i617.VerifyOtpUseCase>(),
        gh<_i653.RequestOtpUseCase>(),
        gh<_i995.ISnackShower>(),
      ),
    );
    gh.lazySingleton<_i618.AuthenticationCubit>(
      () => _i618.AuthenticationCubit(
        gh<_i191.CheckSessionUseCase>(),
        gh<_i865.LogOutUseCase>(),
        gh<_i995.ISnackShower>(),
      ),
    );
    gh.factory<_i1028.PhoneNumberCubit>(
      () => _i1028.PhoneNumberCubit(
        gh<_i653.RequestOtpUseCase>(),
        gh<_i995.ISnackShower>(),
      ),
    );
    gh.lazySingleton<_i1038.NavigationRouter>(
      () => _i1038.NavigationRouter(
        gh<_i168.INavigationKeyProvider>(),
        gh<_i618.AuthenticationCubit>(),
      ),
      dispose: (i) => i.dispose(),
    );
    return this;
  }
}

class _$DatabaseModule extends _i1057.DatabaseModule {}

class _$LoggerModule extends _i20.LoggerModule {}

class _$NetworkModule extends _i869.NetworkModule {}

class _$StorageModule extends _i767.StorageModule {}
