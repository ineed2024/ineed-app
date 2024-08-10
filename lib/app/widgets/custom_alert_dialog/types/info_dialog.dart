import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../styles/app_color_scheme.dart';

class InfoDialog extends StatelessWidget {
  final String title;
  final String message;

  const InfoDialog({Key? key, required this.title, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(Icons.error, color: AppColorScheme.feedbackWarningDark2),
          SizedBox(
            width: 20.w,
          ),
          Flexible(
            child: Text(
              title,
            ),
          )
        ],
      ),
      content: Text(message),
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
