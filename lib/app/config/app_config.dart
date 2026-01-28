import 'package:example_flutter_app/app/config/firebase/firebase_options_dev.dart'
    as dev;
import 'package:example_flutter_app/app/config/firebase/firebase_options_prod.dart'
    as prod;
import 'package:example_flutter_app/core/config/core_config.dart';
import 'package:example_flutter_app/core/infrastructure/bloc_observer/bloc_observer.dart';
import 'package:example_flutter_app/core/injection/injection.dart';
import 'package:example_flutter_app/gen/assets.gen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

enum Flavor { dev, prod }

const flavor = String.fromEnvironment('FLAVOR');
Flavor get flavorEnum => flavor == 'prod' ? Flavor.prod : Flavor.dev;

class AppConfig implements CoreConfig {
  @override
  Future<void> init() async {
    await _initEnv();
    await Future.wait([
      _initDependencies(),
      _initFirebase(),
      _initBloc(),
      _initHydratedBloc(),
    ]);
  }

  Future<void> _initFirebase() async {
    await Firebase.initializeApp(options: firebaseOptions);
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
    await FirebaseAppCheck.instance.activate();
    await FirebaseAppCheck.instance.setTokenAutoRefreshEnabled(true);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  Future<void> _initEnv() async {
    // In a real app, you would load different env files based on flavor
    // For this template, we only have .env.example available
    switch (flavorEnum) {
      case Flavor.dev:
        // await dotenv.load(fileName: Assets.env.aEnvDev);
        await dotenv.load(fileName: Assets.env.aEnv);
        break;
      case Flavor.prod:
        await dotenv.load(fileName: Assets.env.aEnv);
        break;
    }
  }

  Future<void> _initBloc() async {
    Bloc.observer = SimpleBlocObserver();
  }

  Future<void> _initHydratedBloc() async {
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorageDirectory.web
          : HydratedStorageDirectory((await getTemporaryDirectory()).path),
    );
  }

  Future<void> _initDependencies() async {
    await configureDependencies();
    await getIt.allReady();
  }

  @override
  String get title {
    switch (flavorEnum) {
      case Flavor.dev:
        return 'LoyalT Dev';
      case Flavor.prod:
        return 'LoyalT';
    }
  }

  @override
  FirebaseOptions get firebaseOptions {
    switch (flavorEnum) {
      case Flavor.dev:
        return dev.DefaultFirebaseOptions.currentPlatform;
      case Flavor.prod:
        return prod.DefaultFirebaseOptions.currentPlatform;
    }
  }

  @override
  bool get isDev => flavorEnum == Flavor.dev;
}
