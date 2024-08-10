import 'package:Ineed/app/modules/login/components/email_underline_text_field_widget.dart';
import 'package:Ineed/app/utils/validators.dart';
import 'package:Ineed/app/widgets/appbar/custom_app_bar.dart';
import 'package:Ineed/app/widgets/buttons/contained_button_widget.dart';
import 'package:Ineed/app/widgets/custom_alert_dialog/custom_alert_dialog.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'forgot_password_controller.dart';

class ForgotPasswordPage extends StatefulWidget {
  final String title;
  const ForgotPasswordPage({Key? key, this.title = "Login"}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final controller = ForgotPasswordController();

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();

  void _onActionForgotPassword() async {
    if (!_formKey.currentState!.validate()) return;
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      final forgotPassword =
          await controller.forgotPassword(_emailController.text);
      if (forgotPassword.status == Status.failed) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          CustomAlertDialog.error(context,
              forgotPassword.error?.message ?? 'Erro ao reenviar a senha');
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          CustomAlertDialog.success(
              context: context,
              message: "Recuperação de senha",
              onActionButton: () {
                Navigator.pop(context);
              });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        context,
        textTitle: "Recuperar senha",
      ),
      body: SafeArea(
          child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  EmailUnderlineTextFieldWidget(
                      labelText: "E-mail",
                      controller: _emailController,
                      validator: Validators.email,
                      keyboardType: TextInputType.name,
                      inputAction: TextInputAction.next,
                      focusNode: _emailFocus,
                      onSubmitted: (value) {}),
                  Observer(builder: (_) {
                    return ContainedButtonWidget(
                        text: "Recuperar senha",
                        loading: controller.loadingForgotPassword?.status ==
                            Status.loading,
                        onPressed: _onActionForgotPassword);
                  })
                ],
              ),
            )),
      )),
    );
  }
}
