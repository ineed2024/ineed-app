import 'package:Ineed/app/styles/app_color_scheme.dart';
import 'package:Ineed/app/styles/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarCustom extends AppBar {
  AppBarCustom(BuildContext context,
      {Key? key,
      Widget? title,
      String? textTitle,
      List<Widget>? actions,
      double elevation = 6,
      bool automaticallyImplyLeading = true,
      double titleSpacing = 0.0,
      Widget? leading,
      PreferredSizeWidget? bottom,
      Widget? flexibleSpace})
      : super(
            flexibleSpace: flexibleSpace,
            key: key,
            backgroundColor: AppColorScheme.primaryColor,
            title: textTitle != null
                ? Text(
                    textTitle,
                    textAlign: TextAlign.center,
                    style: AppTextTheme.titleAppBar,
                  )
                : title,
            centerTitle: true,
            actions: actions,
            elevation: elevation,
            automaticallyImplyLeading: automaticallyImplyLeading,
            leading: leading == null
                ? !Navigator.of(context).canPop()
                    ? const SizedBox()
                    : IconButton(
                        icon: Icon(
                          Icons.chevron_left,
                          size: 60.h,
                        ),
                        onPressed: () => Modular.to.pop(),
                      )
                : leading,
            titleSpacing: titleSpacing,
            bottom: bottom);
}
