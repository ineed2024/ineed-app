import 'package:Ineed/app/widgets/custom_alert_dialog/types/info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:Ineed/app/widgets/custom_alert_dialog/types/error_dialog.dart';

import 'types/confirm_dialog.dart';
import 'types/question_dialog.dart';

class CustomAlertDialog {
  static Future<void> error(BuildContext context, String error) {
    return showDialog(
      context: context,
      builder: (context) => ErrorDialog(
        error: error,
      ),
    );
  }

  static Future<void> success(
      {required BuildContext context,
      String? title,
      required String message,
      required Function onActionButton}) {
    return showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
          title: title, message: message, onClickButton: onActionButton),
    );
  }

  static Future<void> question(BuildContext context,
      {required String title,
      required String message,
      required Function onActionPositiveButton,
      required Function onActionNegativeButton,
      String? textButtonPositive,
      String? textButtonNegative}) {
    return showDialog(
      context: context,
      builder: (context) => QuestionDialog(
        title: title,
        message: message,
        onActionPositiveButton: onActionPositiveButton,
        onActionNegativeButton: onActionNegativeButton,
        textButtonPositive: textButtonPositive,
        textButtonNegative: textButtonNegative,
      ),
    );
  }

  static Future<void> info(BuildContext context, String title, String message,
      Function()? onActionButton) {
    return showDialog(
        context: context,
        builder: (context) => InfoDialog(
              title: title,
              message: message,
              onClickButton: onActionButton,
            ));
  }
}
