import 'package:flutter/material.dart';

class AppColorScheme {
  static final ColorScheme colorSchemeLight = ColorScheme.fromSwatch(
    backgroundColor: const Color(0xffFFFFFF),
    accentColor: primaryswatchAccent,
    primarySwatch: primaryswatch,
    errorColor: feedbackDangerBase,
  ).copyWith(onPrimary: white);

  /// http://mcg.mbitson.com/
  static const MaterialColor primaryswatch =
      MaterialColor(_primaryswatchPrimaryValue, <int, Color>{
    50: Color(0xFFFFEBE3),
    100: Color(0xFFFFCCBA),
    200: Color(0xFFFFAA8C),
    300: Color(0xFFFF885D),
    400: Color(0xFFFF6F3B),
    500: Color(_primaryswatchPrimaryValue),
    600: Color(0xFFFF4E15),
    700: Color(0xFFFF4411),
    800: Color(0xFFFF3B0E),
    900: Color(0xFFFF2A08),
  });

  static const int _primaryswatchPrimaryValue = 0xFFFF5518;

  static const MaterialColor primaryswatchAccent =
      MaterialColor(_primaryswatchAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_primaryswatchAccentValue),
    400: Color(0xFFFFC7C1),
    700: Color(0xFFFFB0A7),
  });

  static const int _primaryswatchAccentValue = 0xFFFFF5F4;

  static const Color black = Color(0xff000000);
  static const Color white = Color(0xffFFFFFF);

  static const primaryColor = Color(0xFFFF4E15);
  static const primaryColor50 = Color(0xFFFFEBE3);

  static const neutralWhite2A = Color.fromRGBO(255, 255, 255, 0.1);
  static const neutralDefault2 = Color(0xff616e7c);
  static const neutralLight2 = Color(0xffcfdae5);
  static const neutralLighest2 = Color(0xfff2f4f7);
  static const neutralMedium2 = Color(0xff9aa5b1);
  static const neutralMedium3 = Color(0xff757575);
  static const neutralDark2 = Color(0xff1f2933);

  static const feedbackWarningDefault2 = Color(0xffffc300);
  static const feedbackWarningLighest2 = Color(0xfffff7de);
  static const feedbackWarningDark2 = Color(0xffcc9c00);
  static const feedbackWarningLight2 = Color(0xffffe799);
  static const feedbackWarningMedium2 = Color(0xffffdb66);
  static const feedbackDangerLighest = Color(0xfffeebed);
  static const feedbackDangerLight = Color(0xfffccdd1);
  static const feedbackDangerMedium = Color(0xfff6727f);
  static const feedbackDangerBase = Color(0xfff23548);
  static const feedbackDangerDark = Color(0xffff0000);
  static const feedbackSuccessDefault2 = Color(0xff00e484);
  static const feedbackSuccessLighest2 = Color(0xffebfaf3);
  static const feedbackSuccessLight2 = Color(0xff9dfad3);
  static const feedbackSuccessMedium2 = Color(0xff66efb5);
  static const feedbackSuccessDark2 = Color(0xff00cc76);

  static const tagRed2 = Color(0xffee4d4d);
  static const tagOrange2 = Color(0xffff884d);
  static const tagTurquesa2 = Color(0xff4ddbc4);
  static const tagGreen2 = Color(0xffa2d471);
  static const tagPurple2 = Color(0xffa67aff);
  static const tagBlue2 = Color(0xff6398ff);
  static const tagYellow2 = Color(0xffffc44d);

  static const googleButton = Color.fromRGBO(231, 77, 60, 1);
  static const facebookButton = Color.fromRGBO(66, 103, 178, 1);
  static const appleButton = Color.fromRGBO(0, 0, 0, 1);

  static const itemOptionCardShadow = Color(0xFFDCDCDC);
}
