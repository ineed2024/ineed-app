import 'package:Ineed/app/widgets/inputs/underline_text_field_widget.dart';
import 'package:flutter/material.dart';

class EmailUnderlineTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onSaved;
  final String? placeholder;
  final String? labelText;
  final String? errorText;
  final String? Function(String? value)? validator;
  final FocusNode focusNode;
  final void Function(String?)? onSubmitted;
  final TextInputAction? textInputAction;
  final bool? loading;

  const EmailUnderlineTextFieldWidget(
      {Key? key,
      required this.controller,
      this.onSaved,
      this.placeholder,
      this.labelText,
      this.errorText,
      this.validator,
      required this.focusNode,
      this.onSubmitted,
      this.textInputAction,
      this.loading,
      keyboardType,
      TextInputAction? inputAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UnderlineTextFieldWidget(
      leftIcon: Icons.abc,
      validator: validator,
      textError: errorText,
      controller: controller,
      hint: placeholder,
      labelText: labelText,
      focusNode: focusNode,
      onSubmitted: onSubmitted,
      keyboardType: TextInputType.emailAddress,
      inputAction: textInputAction,
    );
  }
}
