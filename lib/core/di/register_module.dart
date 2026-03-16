import 'package:dio/dio.dart';
import 'package:example_flutter_app/core/di/injection.dart';
import 'package:example_flutter_app/core/network/network.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get shared => SharedPreferences.getInstance();

  @lazySingleton
  ApiClient get apiClient {
    final dio = getIt<Dio>(instanceName: 'apiDio');
    return ApiClient(dio);
  }

  @lazySingleton
  @Named('apiDio')
  Dio get dio {
    return DioHelper.configApiDio();
  }
}
