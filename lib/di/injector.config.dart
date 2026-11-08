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
import 'package:j_donuts/core/logging/app_logger.dart' as _i479;
import 'package:j_donuts/core/network/network_info.dart' as _i296;
import 'package:j_donuts/di/third_party_modules/logger_module.dart' as _i20;
import 'package:j_donuts/di/third_party_modules/network_module.dart' as _i869;
import 'package:j_donuts/di/third_party_modules/storage_module.dart' as _i767;
import 'package:j_donuts/navigation/navigation_key_provider.dart' as _i168;
import 'package:j_donuts/shared/components/snack/snack_shower.dart' as _i52;
import 'package:logger/logger.dart' as _i974;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final loggerModule = _$LoggerModule();
    final networkModule = _$NetworkModule();
    final storageModule = _$StorageModule();
    gh.lazySingleton<_i974.Logger>(() => loggerModule.logger);
    gh.lazySingleton<_i895.Connectivity>(() => networkModule.connectivity);
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => storageModule.secureStorage,
    );
    gh.singleton<_i168.INavigationKeyProvider>(
      () => _i168.NavigationKeyProvider(),
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
    return this;
  }
}

class _$LoggerModule extends _i20.LoggerModule {}

class _$NetworkModule extends _i869.NetworkModule {}

class _$StorageModule extends _i767.StorageModule {}
