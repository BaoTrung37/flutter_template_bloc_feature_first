import 'package:example_flutter_app/core/config.dart';
import 'package:example_flutter_app/core/infrastructure/environment/env_keys.dart';
import 'package:example_flutter_app/core/infrastructure/services/network/client/auth_api_client.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get shared => SharedPreferences.getInstance();

  @lazySingleton
  RestApiClient get restApiClient {
    final dio = DioHelper.configApiDio();
    return RestApiClient(dio, baseUrl: EnvKeys.baseUrl);
  }

  @lazySingleton
  AuthApiClient get authApiClient {
    final dio = DioHelper.configApiDio();
    return AuthApiClient(dio, baseUrl: EnvKeys.baseUrl);
  }
}
