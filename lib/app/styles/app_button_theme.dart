import 'package:flutter/material.dart';

class AppButtonTheme {
  /// https://material.io/design/typography/the-type-system.html#type-scale - Helps to create textTheme

  static ButtonStyle outlinedEnabled = ButtonStyle(
      // backgroundColor:
      //     MaterialStateProperty.all<Color>(AppColorScheme.primaryColorButton),
      // foregroundColor: MaterialStateProperty.all<Color>(AppColorScheme.white),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
  ));

  static ButtonStyle outlinedDisable = const ButtonStyle(
      // backgroundColor:
      //     MaterialStateProperty.all<Color>(AppColorScheme.primaryColorButtonDisabled),
      // foregroundColor: MaterialStateProperty.all<Color>(AppColorScheme.black),
      //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      //   RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(18),
      //     // side: const BorderSide(color: AppColorScheme.primaryColorButtonDisabled),
      //   ),
      // )
      );
}
