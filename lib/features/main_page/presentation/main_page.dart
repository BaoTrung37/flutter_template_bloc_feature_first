import 'package:auto_route/auto_route.dart';
import 'package:example_flutter_app/core/injection/injection.dart';
import 'package:example_flutter_app/core/router/app_router.dart';
import 'package:example_flutter_app/features/main_page/application/bottom_tab_cubit.dart';
import 'package:example_flutter_app/features/main_page/presentation/widgets/main_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class MainPage extends StatelessWidget implements AutoRouteWrapper {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        HomeRoute(),
        ProfileRoute(),
      ],
      transitionBuilder: (context, child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          body: child,
          bottomNavigationBar: BlocListener<BottomTabCubit, int>(
            listener: (context, state) {
              tabsRouter.setActiveIndex(state);
            },
            child: MainBottomBar(
              bottomTabCubit: context.read<BottomTabCubit>(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<BottomTabCubit>(),
      child: this,
    );
  }
}
