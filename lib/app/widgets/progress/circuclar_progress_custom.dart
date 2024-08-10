import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../styles/app_color_scheme.dart';

class CircularProgressCustom extends StatelessWidget {
  final Color color;
  const CircularProgressCustom(
      {super.key, this.color = AppColorScheme.primaryColor});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 36.h,
        height: 36.h,
        child: CircularProgressIndicator(
          strokeWidth: 5.w,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ));
  }
}
