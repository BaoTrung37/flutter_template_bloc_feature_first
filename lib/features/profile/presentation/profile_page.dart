import 'package:auto_route/auto_route.dart';
import 'package:example_flutter_app/core/router/app_router.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Screen'),
        actions: [
          IconButton(
            onPressed: () {
              context.router.push(const SettingRoute());
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: const Center(
        child: Column(
          children: [
            Text('Profile Screen'),
          ],
        ),
      ),
    );
  }
}
