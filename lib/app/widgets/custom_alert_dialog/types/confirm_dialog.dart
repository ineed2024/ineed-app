import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../styles/app_color_scheme.dart';

class ConfirmDialog extends StatelessWidget {
  final String message;
  final String? title;
  final Function onClickButton;
  const ConfirmDialog(
      {Key? key,
      required this.message,
      this.title,
      required this.onClickButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: AppColorScheme.primaryColor)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle,
              color: AppColorScheme.feedbackSuccessDark2),
          SizedBox(
            width: 20.w,
          ),
          Flexible(
            child: Text(
              title ?? '',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
      content: Text(message),
      actions: [
        TextButton(
            child: const Text("Ok"),
            onPressed: () {
              Navigator.of(context).pop();
              onClickButton();
            }),
      ],
    );
  }
}
