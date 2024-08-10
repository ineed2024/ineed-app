import 'package:Ineed/app/widgets/inputs/outlined_text_field_form_widget.dart';
import 'package:flutter/material.dart';

class PasswordOutlinedTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String)? onSaved;
  final String placeholder;
  final String? errorText;
  final String? Function(String? value) validator;
  final FocusNode? focusNode;
  final void Function(String?)? onSubmitted;
  final TextInputAction textInputAction;
  final bool? loading;

  const PasswordOutlinedTextFieldWidget(
      {Key? key,
      required this.controller,
      this.onSaved,
      required this.placeholder,
      required this.validator,
      this.errorText,
      this.focusNode,
      this.onSubmitted,
      required this.textInputAction,
      this.loading})
      : super(key: key);

  @override
  _PasswordOutlinedTextFieldWidgetState createState() =>
      _PasswordOutlinedTextFieldWidgetState();
}

class _PasswordOutlinedTextFieldWidgetState
    extends State<PasswordOutlinedTextFieldWidget> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return OutlinedTextFieldFormWidget(
      prefixIcon: Icons.lock,
      textError: widget.errorText,
      validator: widget.validator,
      controller: widget.controller,
      obscure: obscure,
      hint: widget.placeholder,
      leftIcon: obscure ? Icons.remove_red_eye : Icons.remove_red_eye_sharp,
      onPressLeftIcon: () {
        setState(() {
          obscure = !obscure;
        });
      },
      focusNode: widget.focusNode,
      onSubmitted: widget.onSubmitted,
      inputAction: widget.textInputAction,
    );
  }
}
