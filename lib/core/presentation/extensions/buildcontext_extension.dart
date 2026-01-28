import 'package:example_flutter_app/app/theme/app_colors.dart';
import 'package:example_flutter_app/app/theme/app_text_theme.dart';
import 'package:example_flutter_app/core/theme/providers/theme_provider.dart';
import 'package:example_flutter_app/core/theme/theme_data/theme_data.dart';
import 'package:example_flutter_app/gen/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  // Access the AppColors extension from the current theme
  AppColors get colors => Theme.of(this).extension<AppColors>()!;

  // Retrieve the localized strings for the current context
  AppLocalizations? get locate => AppLocalizations.of(this);

  // Access the text theme from the current theme
  AppTextTheme get textTheme => Theme.of(this).extension<AppTextTheme>()!;

  // Access the full theme data for the current context
  ThemeData get theme => Theme.of(this);

  // Get the current brightness setting (light or dark mode)
  Brightness get brightness => Theme.of(this).brightness;

  // Access the current AppThemeData from the ThemeProvider
  AppThemeData get kitTheme => ThemeProvider.of(this).current.data;
}
