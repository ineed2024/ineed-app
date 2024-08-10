import 'package:Ineed/app/modules/login/register/register_controller.dart';
import 'package:Ineed/app/utils/validators.dart';
import 'package:Ineed/app/widgets/buttons/contained_button_widget.dart';
import 'package:Ineed/app/widgets/custom_alert_dialog/custom_alert_dialog.dart';
import 'package:Ineed/app/widgets/inputs/underline_text_field_widget.dart';
import 'package:Ineed/domain/entities/auth/auth_entity.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/appbar/custom_app_bar.dart';
import '../components/email_underline_text_field_widget.dart';
import '../components/password_underline_text_field_widget.dart';

class RegisterPage extends StatefulWidget {
  final String title;
  const RegisterPage({Key? key, this.title = "Login"}) : super(key: key);

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final controller = RegisterController();

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  void _onActionRegister() async {
    if (!_formKey.currentState!.validate()) return;
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      final registerAccount = await controller.registerAccount(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
      );

      if (registerAccount.status == Status.failed) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          CustomAlertDialog.error(context, registerAccount.error!.message!);
        });
      }
      Modular.to.pop(AuthEntity(
          email: _emailController.text, password: _passwordController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCustom(
          context,
          textTitle: "Criar conta",
        ),
        body: SafeArea(
            child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              UnderlineTextFieldWidget(
                                  labelText: "Nome completo",
                                  controller: _nameController,
                                  validator: (value) =>
                                      Validators.fullName(value!),
                                  leftIcon: Icons.abc,
                                  keyboardType: TextInputType.name,
                                  inputAction: TextInputAction.next,
                                  focusNode: _nameFocus,
                                  onSubmitted: (value) {
                                    Focus.of(context).requestFocus(_emailFocus);
                                  }),
                              SizedBox(
                                height: 16.w,
                              ),
                              EmailUnderlineTextFieldWidget(
                                  labelText: "E-mail",
                                  controller: _emailController,
                                  validator: (value) => Validators.email(value),
                                  keyboardType: TextInputType.name,
                                  inputAction: TextInputAction.next,
                                  focusNode: _emailFocus,
                                  onSubmitted: (value) {
                                    Focus.of(context)
                                        .requestFocus(_passwordFocus);
                                  }),
                              SizedBox(
                                height: 16.w,
                              ),
                              PasswordUnderlineTextFieldWidget(
                                  labelText: "Senha",
                                  controller: _passwordController,
                                  validator: Validators.password,
                                  keyboardType: TextInputType.text,
                                  inputAction: TextInputAction.next,
                                  focusNode: _passwordFocus,
                                  onSubmitted: (value) {
                                    Focus.of(context)
                                        .requestFocus(_confirmPasswordFocus);
                                  }),
                              SizedBox(
                                height: 16.w,
                              ),
                              PasswordUnderlineTextFieldWidget(
                                labelText: "Confirme a senha",
                                controller: _confirmPasswordController,
                                keyboardType: TextInputType.text,
                                inputAction: TextInputAction.done,
                                focusNode: _confirmPasswordFocus,
                                validator: (value) {
                                  if (_passwordController.text.isEmpty) {
                                    return null;
                                  }
                                  return Validators.repeatPassword(
                                      _passwordController.text, value);
                                },
                                onSubmitted: (value) {
                                  _onActionRegister();
                                  FocusScope.of(context).unfocus();
                                },
                              ),
                              SizedBox(
                                height: 26.w,
                              ),
                              Observer(builder: (_) {
                                return ContainedButtonWidget(
                                    text: "Cadastrar",
                                    loading:
                                        controller.loadingRegister?.status ==
                                            Status.loading,
                                    onPressed: _onActionRegister);
                              })
                            ])),
                  ),
                ))));
  }
}
