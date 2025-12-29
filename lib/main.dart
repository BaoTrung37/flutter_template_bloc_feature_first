import 'dart:async';
import 'dart:io';

import 'package:catcher_2/catcher_2.dart';
import 'package:example_flutter_app/core/application/language/language_bloc.dart';
import 'package:example_flutter_app/core/config.dart';
import 'package:example_flutter_app/core/injection/injection.dart';
import 'package:example_flutter_app/core/theme/colors.dart';
import 'package:example_flutter_app/core/theme/providers/theme_provider.dart';
import 'package:example_flutter_app/core/theme/texts.dart';
import 'package:example_flutter_app/core/theme/universal_theme.dart';
import 'package:example_flutter_app/gen/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  HttpOverrides.global = MyHttpOverrides();

  await AppConfig.configure();

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
    rootWidget: const MyApp(),
    debugConfig: debugOptions,
    releaseConfig: releaseOptions,
    navigatorKey: navigatorGlobalKey,
  );

  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: child,
      ),
      child: ThemeProvider(
        notifier: AppTheme.uniform(
          themeFactory: const UniversalThemeFactory(),
          lightColors: NikeColors.light(),
          darkColors: NikeColors.dark(),
          defaultMode: ThemeMode.light,
          textTheme: NikeTextTheme.build(),
        ),
        child: BlocBuilder<LanguageBloc, LanguageState>(
          bloc: getIt<LanguageBloc>(),
          builder: (context, state) {
            return MaterialApp.router(
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              theme: ThemeProvider.of(context).light,
              darkTheme: ThemeProvider.of(context).dark,
              themeMode: ThemeProvider.of(context).mode,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: state.language.locale,
              // routerConfig: getIt<AppRouter>().config(),
              routerDelegate: getIt<AppRouter>().delegate(),
              routeInformationParser: getIt<AppRouter>().defaultRouteParser(),
            );
          },
        ),
      ),
    );
  }
}
