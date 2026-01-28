import 'package:example_flutter_app/app/config/app_config.dart';
import 'package:example_flutter_app/app/theme/app_colors.dart';
import 'package:example_flutter_app/app/theme/app_text_theme.dart';
import 'package:example_flutter_app/app/theme/app_theme_factory.dart';
import 'package:example_flutter_app/bootstrap.dart';
import 'package:example_flutter_app/core/injection/injection.dart';
import 'package:example_flutter_app/core/router/app_router.dart';
import 'package:example_flutter_app/core/shared/languages.dart';
import 'package:example_flutter_app/core/theme/providers/theme_provider.dart';
import 'package:example_flutter_app/features/language/application/bloc/language_bloc.dart';
import 'package:example_flutter_app/gen/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  await bootstrap(
    config: AppConfig(),
    builder: () => const MyApp(),
  );
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
          themeFactory: const DefaultThemeFactory(),
          lightColors: AppColors.light(),
          darkColors: AppColors.dark(),
          defaultMode: ThemeMode.light,
          textTheme: AppTextTheme.build(),
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
