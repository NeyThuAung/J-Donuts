import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injector.config.dart';

final _getIt = GetIt.instance;

T inject<T extends Object>({String? instanceName}) =>
    _getIt.get<T>(instanceName: instanceName);

@InjectableInit()
Future<GetIt> configureDependencies() async => _getIt.init();
