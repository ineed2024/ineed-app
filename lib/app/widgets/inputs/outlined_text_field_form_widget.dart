import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../styles/app_color_scheme.dart';

class OutlinedTextFieldFormWidget extends StatelessWidget {
  final String? hint;
  final String? labelText;
  final IconData? prefixIcon;
  final bool obscure;
  final void Function(String?)? onChanged;
  final void Function()? onComplete;
  final void Function(String?)? onSubmitted;
  final Function? onSaved;
  final int? maxLines;
  final bool autofocus;
  final int? maxLength;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextInputAction? inputAction;
  final FocusNode? focusNode;
  final String? textError;
  final IconData? leftIcon;
  final void Function()? onPressLeftIcon;
  const OutlinedTextFieldFormWidget(
      {super.key,
      required this.hint,
      this.labelText,
      this.prefixIcon,
      this.obscure = false,
      this.onChanged,
      this.onComplete,
      this.onSubmitted,
      this.onSaved,
      required this.controller,
      this.maxLines = 1,
      this.autofocus = false,
      this.maxLength,
      this.validator,
      this.keyboardType,
      required this.inputAction,
      required this.focusNode,
      this.textError,
      this.leftIcon,
      this.onPressLeftIcon});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: validator != null
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      onFieldSubmitted: onSubmitted,
      obscureText: obscure,
      cursorColor: AppColorScheme.primaryColor,
      onChanged: onChanged,
      onEditingComplete: onComplete,
      controller: controller,
      maxLines: maxLines,
      autofocus: autofocus,
      keyboardType: keyboardType,
      maxLength: maxLength,
      textInputAction: inputAction,
      focusNode: focusNode,
      validator: validator,
      decoration: InputDecoration(
        suffixIcon: leftIcon != null
            ? IconButton(
                onPressed: onPressLeftIcon,
                icon: Icon(leftIcon),
                color: AppColorScheme.primaryColor,
              )
            : null,
        errorText: textError,
        errorMaxLines: 2,
        errorStyle: const TextStyle(color: AppColorScheme.feedbackDangerDark),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        prefixIcon: Icon(
          prefixIcon,
          color: AppColorScheme.primaryColor,
        ),
        labelText: labelText,
        hintText: hint,
        fillColor: textError == null
            ? AppColorScheme.white
            : AppColorScheme.feedbackDangerLight,
        filled: true,
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: AppColorScheme.primaryColor, width: 2.0.h),
            borderRadius: BorderRadius.circular(50)),
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: AppColorScheme.primaryColor, width: 2.0.h),
            borderRadius: BorderRadius.circular(50)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: AppColorScheme.feedbackDangerDark, width: 2.0.h),
            borderRadius: BorderRadius.circular(50)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: AppColorScheme.feedbackDangerDark, width: 2.0.h),
            borderRadius: BorderRadius.circular(50)),
      ),
    );
  }
}
