import 'package:auto_route/auto_route.dart';
import 'package:example_flutter_app/features/envelop/create_session/presentation/create_envelop_session.dart';
import 'package:example_flutter_app/features/profile/presentation/profile_page.dart';
import 'package:example_flutter_app/features/setting/presentation/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
@lazySingleton
class AppRouter extends RootStackRouter {
  AppRouter() : super(navigatorKey: navigatorGlobalKey);
  @override
  List<AutoRoute> get routes => [
    // AutoRoute(
    //   initial: true,
    //   path: '/',
    //   page: MainRoute.page,
    //   children: [
    //     RedirectRoute(path: '', redirectTo: HomeRoute.name),
    //     AutoRoute(path: 'home-page', page: HomeRoute.page),
    //     AutoRoute(path: 'profile-page', page: ProfileRoute.page),
    //   ],
    // ),
    AutoRoute(
      path: '/create-envelop-session',
      page: CreateEnvelopSessionRoute.page,
      initial: true,
    ),
    AutoRoute(path: '/setting', page: SettingRoute.page),
  ];
}

final navigatorGlobalKey = GlobalKey<NavigatorState>();
