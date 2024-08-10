import 'package:Ineed/app/widgets/inputs/underline_text_field_widget.dart';
import 'package:flutter/material.dart';

class PasswordUnderlineTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String)? onSaved;
  final String? placeholder;
  final String? labelText;
  final String? errorText;
  final String? Function(String? value) validator;
  final FocusNode? focusNode;
  final void Function(String?)? onSubmitted;
  final TextInputAction? textInputAction;
  final bool? loading;

  const PasswordUnderlineTextFieldWidget(
      {Key? key,
      required this.controller,
      this.onSaved,
      this.labelText,
      this.placeholder,
      required this.validator,
      this.errorText,
      this.focusNode,
      this.onSubmitted,
      this.textInputAction,
      this.loading,
      TextInputType? keyboardType,
      TextInputAction? inputAction})
      : super(key: key);

  @override
  _PasswordUnderlineTextFieldWidgetState createState() =>
      _PasswordUnderlineTextFieldWidgetState();
}

class _PasswordUnderlineTextFieldWidgetState
    extends State<PasswordUnderlineTextFieldWidget> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return UnderlineTextFieldWidget(
      leftIcon: Icons.abc,
      textError: widget.errorText,
      validator: widget.validator,
      controller: widget.controller,
      obscure: obscure,
      labelText: widget.labelText,
      hint: widget.placeholder,
      rigthIcon: obscure ? Icons.abc : Icons.abc_outlined,
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
