import '../../styles/app_color_scheme.dart';
import 'package:flutter/material.dart';

class OutlinedTextFieldLightFormWidget extends StatelessWidget {
  final String hint;
  final String labelText;
  final IconData prefixIcon;
  final bool obscure;
  final Function(String)? onChanged;
  final Function()? onComplete;
  final Function(String)? onSubmitted;
  final Function()? onSaved;
  final int maxLines;
  final bool autofocus;
  final int? maxLength;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextInputAction? inputAction;
  final FocusNode? focusNode;
  final String? textError;
  final IconData? leftIcon;
  final Function()? onPressLeftIcon;
  const OutlinedTextFieldLightFormWidget(
      {super.key,
      required this.hint,
      required this.labelText,
      required this.prefixIcon,
      this.obscure = false,
      this.onChanged,
      this.onComplete,
      this.onSubmitted,
      this.onSaved,
      this.controller,
      this.maxLines = 1,
      this.autofocus = false,
      this.maxLength,
      this.validator,
      this.keyboardType,
      this.inputAction,
      this.focusNode,
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
      style: const TextStyle(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 15.0,
        ),
        suffixIcon: leftIcon != null
            ? IconButton(
                onPressed: onPressLeftIcon,
                icon: Icon(leftIcon),
                color: AppColorScheme.primaryColor)
            : null,
        errorText: textError,
        errorMaxLines: 2,
        errorStyle: const TextStyle(color: AppColorScheme.feedbackDangerDark),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        // labelText: labelText,

        hintText: hint,
        hintStyle: TextStyle(fontSize: 14.0, color: Colors.grey[400]),
        // fillColor: textError == null
        //     ? AppColorScheme.white
        //     : AppColorScheme.feedbackDangerLight,
        filled: true,
      ),
    );
  }
}
