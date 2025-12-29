// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:example_flutter_app/core/infrastructure/bloc_observer/bloc_observer.dart';
import 'package:example_flutter_app/core/infrastructure/environment/env_keys.dart';
import 'package:example_flutter_app/core/infrastructure/firebase/firebase_options_dev.dart'
    as dev;
import 'package:example_flutter_app/core/infrastructure/firebase/firebase_options_prod.dart'
    as prod;
import 'package:example_flutter_app/core/injection/injection.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

class AppConfig {
  static Future<void> configure() async {
    await _initEnvKeys();
    await Future.wait([
      _initDependencies(),
      _initFirebase(),
      _initBloc(),
      _initHydratedBloc(),
    ]);
  }

  static Future<void> _initFirebase() async {
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

  static Future<void> _initEnvKeys() async {
    await EnvKeys.loadEnv();
  }

  static Future<void> _initBloc() async {
    Bloc.observer = SimpleBlocObserver();
  }

  static Future<void> _initHydratedBloc() async {
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorageDirectory.web
          : HydratedStorageDirectory((await getTemporaryDirectory()).path),
    );
  }

  static Future<void> _initDependencies() async {
    await configureDependencies();
    await getIt.allReady();
  }

  static String get title {
    switch (flavorEnum) {
      case Flavor.dev:
        return 'LoyalT Dev';
      case Flavor.prod:
        return 'LoyalT';
    }
  }

  static FirebaseOptions get firebaseOptions {
    switch (flavorEnum) {
      case Flavor.dev:
        return dev.DefaultFirebaseOptions.currentPlatform;
      case Flavor.prod:
        return prod.DefaultFirebaseOptions.currentPlatform;
    }
  }
}

enum Flavor { dev, prod }

const flavor = String.fromEnvironment('FLAVOR');
Flavor get flavorEnum => flavor == 'prod' ? Flavor.prod : Flavor.dev;
