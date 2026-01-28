import 'dart:async';

import 'package:catcher_2/catcher_2.dart';
import 'package:example_flutter_app/core/config/core_config.dart';
import 'package:example_flutter_app/core/infrastructure/network/overrides/http_overrides.dart';
import 'package:example_flutter_app/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';

Future<void> bootstrap({
  required CoreConfig config,
  required Widget Function() builder,
}) async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  if (config.isDev) {
    setupHttpOverrides();
  }

  // Register config so it can be injected
  GetIt.I.registerSingleton<CoreConfig>(config);

  await config.init();

  final debugOptions = Catcher2Options(SilentReportMode(), [
    ToastHandler(
      customMessage: 'An error occurred. Please try again!',
      textSize: 14,
    ),
    ConsoleHandler(),
    // CrashlyticsHandler(),
  ]);
  final releaseOptions = Catcher2Options(SilentReportMode(), [
    // CrashlyticsHandler(),
  ]);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  Catcher2(
    rootWidget: builder(),
    debugConfig: debugOptions,
    releaseConfig: releaseOptions,
    navigatorKey: navigatorGlobalKey,
  );

  FlutterNativeSplash.remove();
}
