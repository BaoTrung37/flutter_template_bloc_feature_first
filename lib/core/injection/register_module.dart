import 'package:dio/dio.dart';
import 'package:example_flutter_app/core/infrastructure/environment/env_keys.dart';
import 'package:example_flutter_app/core/infrastructure/network/network.dart';
import 'package:example_flutter_app/core/injection/injection.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get shared => SharedPreferences.getInstance();

  @lazySingleton
  ApiClient get apiClient {
    final dio = getIt<Dio>(instanceName: 'apiDio');
    return ApiClient(dio, baseUrl: EnvKeys.baseUrl);
  }

  @lazySingleton
  @Named('apiDio')
  Dio get dio {
    return DioHelper.configApiDio();
  }
}
