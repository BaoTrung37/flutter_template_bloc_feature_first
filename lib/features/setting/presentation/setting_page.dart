import 'package:auto_route/auto_route.dart';
import 'package:example_flutter_app/features/language/application/bloc/language_bloc.dart';
import 'package:example_flutter_app/core/injection/injection.dart';
import 'package:example_flutter_app/core/shared/languages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
        leading: IconButton(
          onPressed: () {
            context.router.pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            BlocBuilder<LanguageBloc, LanguageState>(
              bloc: getIt<LanguageBloc>(),
              builder: (context, state) {
                return DropdownButton<Languages>(
                  items: Languages.values
                      .map(
                        (language) => DropdownMenuItem(
                          value: language,
                          child: Text(language.name),
                        ),
                      )
                      .toList(),
                  value: state.language,
                  onChanged: (value) {
                    getIt<LanguageBloc>()
                        .add(LanguageEvent.changeTempLanguage(value!));
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
