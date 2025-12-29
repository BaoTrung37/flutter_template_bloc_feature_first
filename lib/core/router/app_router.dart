import 'package:auto_route/auto_route.dart';
import 'package:example_flutter_app/features/home/presentation/home_page.dart';
import 'package:example_flutter_app/features/main_page/presentation/main_page.dart';
import 'package:example_flutter_app/features/profile/presentation/profile_page.dart';
import 'package:example_flutter_app/features/setting/presentation/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
@lazySingleton
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      initial: true,
      path: '/',
      page: MainRoute.page,
      children: [
        RedirectRoute(path: '', redirectTo: HomeRoute.name),
        AutoRoute(path: 'home-page', page: HomeRoute.page),
        AutoRoute(path: 'profile-page', page: ProfileRoute.page),
      ],
    ),
    AutoRoute(path: '/setting-page', page: SettingRoute.page),
  ];
}

final navigatorGlobalKey = GlobalKey<NavigatorState>();
