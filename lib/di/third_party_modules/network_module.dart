import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

import '../../core/network/network_info.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Connectivity get connectivity => Connectivity();

  @LazySingleton(as: NetworkInfo)
  NetworkInfoImpl networkInfo(Connectivity connectivity) =>
      NetworkInfoImpl(connectivity, InternetAddress.lookup);
}
