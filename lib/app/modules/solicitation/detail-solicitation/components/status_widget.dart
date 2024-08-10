import 'package:Ineed/app/styles/app_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusWidget extends StatelessWidget {
  final String valueStatus;

  const StatusWidget({Key? key, required this.valueStatus}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
      color: AppColorScheme.neutralLight2,
      child: RichText(
          text: TextSpan(
              text: 'Status: ',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 32.w,
                  color: AppColorScheme.black),
              children: [
            TextSpan(
                text: valueStatus.toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 32.w,
                    color: AppColorScheme.black))
          ])),
    );
  }
}
