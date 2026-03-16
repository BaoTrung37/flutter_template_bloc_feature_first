import 'package:example_flutter_app/core/di/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit(
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async {
  await getIt.init();
}
