import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../styles/app_color_scheme.dart';

class ErrorDialog extends StatelessWidget {
  final String error;
  const ErrorDialog({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(Icons.error, color: AppColorScheme.feedbackDangerDark),
          SizedBox(
            width: 20.w,
          ),
          const Flexible(
            child: Text(
              "Ocorreu um erro",
            ),
          )
        ],
      ),
      content: Text(error),
      actions: [
        TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
  }
}
