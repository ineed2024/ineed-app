import 'package:flutter/material.dart';

import '../../styles/app_color_scheme.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key,
    this.icon,
    this.iconColor,
    required this.textButton,
    this.funcao,
    this.color,
    this.colorText,
  });
  final IconData? icon;
  final Color? iconColor;
  final String textButton;
  final void Function()? funcao;
  final Color? color;
  final Color? colorText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(
              vertical: 10.0,
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
              color ?? AppColorScheme.primaryColor),
          foregroundColor: MaterialStateProperty.all<Color>(
              colorText ?? AppColorScheme.neutralDark2),
        ),
        onPressed: funcao,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Icon(
                      icon!,
                      color: iconColor,
                    ),
                  )
                : const SizedBox(),
            Text(
              textButton,
              style: TextStyle(
                color: colorText,
              ).copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
