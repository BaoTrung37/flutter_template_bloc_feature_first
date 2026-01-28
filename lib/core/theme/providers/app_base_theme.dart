import 'dart:io';

import 'package:example_flutter_app/app/theme/app_colors.dart';
import 'package:example_flutter_app/app/theme/app_text_theme.dart';
import 'package:example_flutter_app/core/theme/theme_data/theme_data.dart';

sealed class AppBaseTheme {
  const AppBaseTheme();

  AppColors get colors;

  AppTextTheme get textTheme;

  AppThemeData get data;
}

class AppBaseThemeUniform extends AppBaseTheme {
  const AppBaseThemeUniform(this.data);

  @override
  final AppThemeData data;

  @override
  AppColors get colors => data.colors;

  @override
  AppTextTheme get textTheme => data.defaultTextTheme;
}

/// If you want to have different
/// themes for different platforms
class AppBaseThemeAdaptive extends AppBaseTheme {
  const AppBaseThemeAdaptive({
    this.ios,
    this.android,
    this.web,
  });
  final AppThemeData? ios;
  final AppThemeData? android;
  final AppThemeData? web;

  @override
  AppColors get colors {
    if (Platform.isIOS) {
      return ios!.colors;
    } else if (Platform.isAndroid) {
      return android!.colors;
    } else {
      return web!.colors;
    }
  }

  @override
  AppTextTheme get textTheme {
    if (Platform.isIOS) {
      return ios!.defaultTextTheme;
    } else if (Platform.isAndroid) {
      return android!.defaultTextTheme;
    } else {
      return web!.defaultTextTheme;
    }
  }

  @override
  AppThemeData get data {
    if (Platform.isIOS) {
      return ios!;
    } else if (Platform.isAndroid) {
      return android!;
    } else {
      return web!;
    }
  }
}
