import 'package:example_flutter_app/app/theme/app_colors.dart';
import 'package:example_flutter_app/app/theme/app_text_theme.dart';
import 'package:example_flutter_app/core/theme/theme_data/theme_data.dart';

/// This is the factory used to create the theme from the colors and textTheme
/// You can create your own factory to create your own theme
/// see universal_theme.dart for an example
abstract class AppThemeDataFactory {
  const AppThemeDataFactory();

  AppThemeData build({
    required AppColors colors,
    required AppTextTheme defaultTextStyle,
  });
}
