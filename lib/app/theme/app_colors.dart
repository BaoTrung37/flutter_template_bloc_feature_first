import 'package:flutter/material.dart';

/// Color constants for the App theme
class AppColorConstants {
  static const Color primary = Color(0xFF006FFD);
  static const Color grey1Dark = Color(0xFFB0B0B0);
  static const Color grey2Dark = Color(0xFF2E2E2E);
  static const Color grey3Dark = Color(0xFF4A4A4A);
  static const Color blackDark = Color(0xFFE0E0E0);
  static const Color whiteDark = Color(0xFF1A1A1A);
  static const Color greyDark = Color(0xFF9E9E9E);
  static const Color grey5Dark = Color(0xFF3A3A3A);
  static const Color greenDark = Color(0xFF00E676);
  static const Color greenSupportDark = Color(0xFF1B5E20);
  static const Color greenSupport2Dark = Color(0xFFD5F6D6);
  static const Color redSupportDark = Color(0xFFB71C1C);
  static const Color redSupport2Dark = Color(0xFFFFDCDC);
  static const Color redDark = Color(0xFFFF8A80);
  static const Color blueDark = Color(0xFF0D47A1);

  static const Color grey1Light = Color(0xFF71727A);
  static const Color grey2Light = Color(0xFFF5F5F5);
  static const Color grey3Light = Color(0xFFC5C6CC);
  static const Color blackLight = Color(0xFF13132D);
  static const Color whiteLight = Color(0xFFFFFFFF);
  static const Color greyLight = Color(0xFF5F5B5B);
  static const Color grey5Light = Color(0xFFEBEBEB);
  static const Color greenLight = Color(0xff2CD232);
  static const Color greenSupportLight = Color(0xff2CD232);
  static const Color greenSupport2Light = Color(0xFFD5F6D6);
  static const Color redSupportLight = Color(0xffFF616D);
  static const Color redSupport2Light = Color(0xFFFFDCDC);
  static const Color redLight = Color(0xffFF616D);
  static const Color blueLight = Color(0xffEFF3FF);
}

class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.primary,
    required this.grey1,
    required this.grey2,
    required this.grey3,
    required this.black,
    required this.white,
    required this.grey,
    required this.grey5,
    required this.green,
    required this.greenSupport,
    required this.greenSupport2,
    required this.red,
    required this.redSupport,
    required this.redSupport2,
    required this.blue,
  });

  factory AppColors.dark() => const AppColors(
        primary: AppColorConstants.primary,
        grey1: AppColorConstants.grey1Dark,
        grey2: AppColorConstants.grey2Dark,
        grey3: AppColorConstants.grey3Dark,
        black: AppColorConstants.blackDark,
        white: AppColorConstants.whiteDark,
        grey: AppColorConstants.greyDark,
        grey5: AppColorConstants.grey5Dark,
        green: AppColorConstants.greenDark,
        greenSupport: AppColorConstants.greenSupportDark,
        greenSupport2: AppColorConstants.greenSupport2Dark,
        redSupport: AppColorConstants.redSupportDark,
        redSupport2: AppColorConstants.redSupport2Dark,
        red: AppColorConstants.redDark,
        blue: AppColorConstants.blueDark,
      );

  factory AppColors.light() => const AppColors(
        primary: AppColorConstants.primary,
        grey1: AppColorConstants.grey1Light,
        grey2: AppColorConstants.grey2Light,
        grey3: AppColorConstants.grey3Light,
        black: AppColorConstants.blackLight,
        white: AppColorConstants.whiteLight,
        grey: AppColorConstants.greyLight,
        grey5: AppColorConstants.grey5Light,
        green: AppColorConstants.greenLight,
        greenSupport: AppColorConstants.greenSupportLight,
        greenSupport2: AppColorConstants.greenSupport2Light,
        redSupport: AppColorConstants.redSupportLight,
        redSupport2: AppColorConstants.redSupport2Light,
        red: AppColorConstants.redLight,
        blue: AppColorConstants.blueLight,
      );

  final Color primary;
  final Color blue;
  final Color black;
  final Color grey;
  final Color grey1;
  final Color grey2;
  final Color grey3;
  final Color grey5;
  final Color white;
  final Color green;
  final Color greenSupport;
  final Color greenSupport2;
  final Color red;
  final Color redSupport;
  final Color redSupport2;

  @override
  ThemeExtension<AppColors> copyWith({
    Color? primary,
    Color? black,
    Color? white,
    Color? grey,
    Color? grey1,
    Color? grey2,
    Color? grey3,
    Color? grey5,
    Color? green,
    Color? greenSupport,
    Color? greenSupport2,
    Color? redSupport,
    Color? red,
    Color? blue,
    Color? redSupport2,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      black: black ?? this.black,
      white: white ?? this.white,
      grey: grey ?? this.grey,
      grey1: grey1 ?? this.grey1,
      grey2: grey2 ?? this.grey2,
      grey3: grey3 ?? this.grey3,
      grey5: grey5 ?? this.grey5,
      green: green ?? this.green,
      greenSupport: greenSupport ?? this.greenSupport,
      greenSupport2: greenSupport2 ?? this.greenSupport2,
      redSupport: redSupport ?? this.redSupport,
      blue: blue ?? this.blue,
      red: red ?? this.red,
      redSupport2: redSupport2 ?? this.redSupport2,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(
    covariant ThemeExtension<AppColors>? other,
    double t,
  ) {
    if (other == null || other is! AppColors) {
      return this;
    }

    return AppColors(
      primary: Color.lerp(primary, other.primary, t)!,
      black: Color.lerp(black, other.black, t)!,
      white: Color.lerp(white, other.white, t)!,
      grey: Color.lerp(grey, other.grey, t)!,
      grey1: Color.lerp(grey1, other.grey1, t)!,
      grey2: Color.lerp(grey2, other.grey2, t)!,
      grey3: Color.lerp(grey3, other.grey3, t)!,
      grey5: Color.lerp(grey5, other.grey5, t)!,
      green: Color.lerp(green, other.green, t)!,
      greenSupport: Color.lerp(greenSupport, other.greenSupport, t)!,
      greenSupport2: Color.lerp(greenSupport2, other.greenSupport2, t)!,
      redSupport: Color.lerp(redSupport, other.redSupport, t)!,
      redSupport2: Color.lerp(redSupport2, other.redSupport2, t)!,
      red: Color.lerp(red, other.red, t)!,
      blue: Color.lerp(blue, other.blue, t)!,
    );
  }
}
