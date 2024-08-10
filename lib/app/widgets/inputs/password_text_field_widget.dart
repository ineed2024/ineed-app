import '../inputs/outlined_text_field_light_form_widget.dart';
import 'package:flutter/material.dart';

class PasswordTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String)? onSaved;
  final String placeholder;
  final String? errorText;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final void Function(String)? onSubmitted;
  final TextInputAction? textInputAction;
  final bool? loading;

  const PasswordTextFieldWidget({
    super.key,
    required this.controller,
    this.onSaved,
    required this.placeholder,
    required this.validator,
    this.errorText,
    this.focusNode,
    this.onSubmitted,
    this.textInputAction,
    this.loading,
  });

  @override
  State<PasswordTextFieldWidget> createState() =>
      _PasswordTextFieldWidgetState();
}

class _PasswordTextFieldWidgetState extends State<PasswordTextFieldWidget> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return OutlinedTextFieldLightFormWidget(
      prefixIcon: Icons.lock_outline,
      textError: widget.errorText,
      validator: widget.validator,
      controller: widget.controller,
      obscure: obscure,
      hint: widget.placeholder,
      leftIcon:
          obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
      onPressLeftIcon: () {
        setState(() {
          obscure = !obscure;
        });
      },
      focusNode: widget.focusNode,
      onSubmitted: widget.onSubmitted,
      inputAction: widget.textInputAction,
      labelText: '',
    );
  }
}
