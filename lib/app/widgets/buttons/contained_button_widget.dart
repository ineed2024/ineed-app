import 'package:Ineed/app/styles/app_color_scheme.dart';
import 'package:Ineed/app/styles/app_text_theme.dart';
import 'package:Ineed/app/widgets/progress/circuclar_progress_custom.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContainedButtonWidget extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final bool loading;
  ContainedButtonWidget(
      {required this.text, required this.onPressed, this.loading: false});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            backgroundColor: AppColorScheme.primaryColor),
        child: loading
            ? CircularProgressCustom(color: AppColorScheme.white)
            : Text(
                text,
                textAlign: TextAlign.center,
                style: AppTextTheme.buttonContained,
              ),
        onPressed: loading ? null : onPressed,
      ),
    );
  }
}
