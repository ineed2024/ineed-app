import 'package:flutter/material.dart';

import '../../styles/app_button_theme.dart';
import '../../styles/app_color_scheme.dart';

import '../progress/circuclar_progress_custom.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final String text;
  final Function? onPressed;
  final bool loading;
  final bool loadingInitial;
  final String progress;
  final Color? color;
  final bool enabled;
  final IconData? icon;

  const ElevatedButtonWidget({
    Key? key,
    required this.text,
    this.onPressed,
    this.loading = false,
    this.loadingInitial = true,
    this.progress = '0',
    this.color,
    this.enabled = true,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // if (loading && loadingInitial) {
    //   return const ElevatedButtonLoadingWidget();
    // }

    return SizedBox(
        height: 52,
        child: ElevatedButton(
            onPressed: () => onPressed!(),
            style: enabled
                ? AppButtonTheme.outlinedEnabled.copyWith(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        color ?? AppColorScheme.primaryColor.withOpacity(0.9)),
                    side:
                        MaterialStateProperty.all<BorderSide>(BorderSide.none),
                  )
                : AppButtonTheme.outlinedDisable,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: loading
                    ? [
                        const CircularProgressCustom(
                          color: AppColorScheme.white,
                        )
                      ]
                    : icon != null
                        ? [
                            Icon(icon),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(text)
                          ]
                        : [Text(text)])));
  }
}
