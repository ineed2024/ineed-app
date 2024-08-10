import 'package:Ineed/app/widgets/inputs/outlined_text_field_form_widget.dart';
import 'package:flutter/material.dart';

class EmailOutlinedTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onSaved;
  final String placeholder;
  final String? errorText;
  final String? Function(String? value)? validator;
  final FocusNode focusNode;
  final void Function(String?)? onSubmitted;
  final TextInputAction textInputAction;
  final bool? loading;

  const EmailOutlinedTextFieldWidget(
      {Key? key,
      required this.controller,
      this.onSaved,
      required this.placeholder,
      this.errorText,
      required this.validator,
      required this.focusNode,
      required this.onSubmitted,
      required this.textInputAction,
      this.loading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedTextFieldFormWidget(
      keyboardType: TextInputType.emailAddress,
      prefixIcon: Icons.email,
      validator: validator,
      textError: errorText,
      controller: controller,
      hint: placeholder,
      focusNode: focusNode,
      onSubmitted: onSubmitted,
      inputAction: textInputAction,
    );
  }
}
