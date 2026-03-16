import 'package:auto_route/auto_route.dart';
import 'package:example_flutter_app/features/language/domain/languages.dart';
import 'package:example_flutter_app/features/language/presentation/bloc/language_bloc.dart';
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
                    context.read<LanguageBloc>().add(
                      LanguageEvent.changeTempLanguage(value!),
                    );
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
