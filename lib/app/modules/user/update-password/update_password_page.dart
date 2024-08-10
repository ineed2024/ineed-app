import 'package:Ineed/app/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'update_password_controller.dart';
import 'package:Ineed/app/widgets/custom_alert_dialog/custom_alert_dialog.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:Ineed/app/widgets/buttons/contained_button_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:Ineed/app/widgets/inputs/underline_text_field_widget.dart';
import 'package:Ineed/app/utils/validators.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({Key? key}) : super(key: key);

  @override
  _UpdatePasswordPageState createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final controller = UpdatePasswordController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool obscureOne = true;
  bool obscureTwo = true;
  bool obscureThree = true;

  final _formKey = GlobalKey<FormState>();
  final _oldPassword = TextEditingController();
  final _newPassword = TextEditingController();
  final _confirmPassword = TextEditingController();

  final FocusNode _oldFocus = FocusNode();
  final FocusNode _newFocus = FocusNode();
  final FocusNode _confirmFocus = FocusNode();

  _showSnackBar(String message) =>
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        UIHelper.showInSnackBar(message, context);
      });

  _onActionUpdatePassword() async {
    if (!_formKey.currentState!.validate()) return;

    if (_formKey.currentState!.validate()) {
      final result = await controller.onUpdatePassword(
          _oldPassword.text, _newPassword.text);

      if (result.status == Status.failed) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          CustomAlertDialog.error(context, result.error!.message!);
        });
        return;
      }
      _showSnackBar(result.message!);
      Timer(Duration(seconds: 1), () {
        Modular.to.pop(result);
      });
    } else
      _showSnackBar('Existem campos a serem preenchidos');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Alterar Senha'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildform,
            Observer(builder: (_) {
              return Padding(
                padding: const EdgeInsets.only(
                    top: 26, right: 16, left: 16, bottom: 16),
                child: ContainedButtonWidget(
                    text: "Alterar Senha",
                    loading: controller.resource?.status == Status.loading,
                    onPressed: _onActionUpdatePassword),
              );
            }),
          ],
        ),
      ),
    );
  }

  get _buildform => Expanded(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  UnderlineTextFieldWidget(
                      controller: _oldPassword,
                      validator: Validators.password,
                      focusNode: _oldFocus,
                      labelText: "Senha Atual",
                      contentPadding: true,
                      inputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      obscure: obscureOne,
                      onPressLeftIcon: () {
                        setState(() {
                          obscureOne = !obscureOne;
                        });
                      },
                      rigthIcon: obscureOne
                          ? Icons.remove_red_eye
                          : Icons.remove_red_eye
                      // ? FlutterIcons.eye_outline_mco
                      // : FlutterIcons.eye_off_outline_mco,
                      ),
                  SizedBox(
                    height: 16.h,
                  ),
                  UnderlineTextFieldWidget(
                      controller: _newPassword,
                      validator: Validators.password,
                      focusNode: _newFocus,
                      labelText: "Nova Senha",
                      contentPadding: true,
                      inputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      obscure: obscureTwo,
                      onPressLeftIcon: () {
                        setState(() {
                          obscureTwo = !obscureTwo;
                        });
                      },
                      rigthIcon: obscureTwo
                          ? Icons.remove_red_eye
                          : Icons.remove_red_eye),
                  SizedBox(
                    height: 16.h,
                  ),
                  UnderlineTextFieldWidget(
                      controller: _confirmPassword,
                      validator: (value) {
                        if (_newPassword.text.isEmpty) {
                          return null;
                        }
                        return Validators.repeatPassword(
                            _newPassword.text, value);
                      },
                      focusNode: _confirmFocus,
                      labelText: "Confirme a Senha",
                      contentPadding: true,
                      inputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      obscure: obscureThree,
                      onPressLeftIcon: () {
                        setState(() {
                          obscureThree = !obscureThree;
                        });
                      },
                      rigthIcon: obscureThree
                          ? Icons.remove_red_eye
                          : Icons.remove_red_eye)
                ],
              ),
            ),
          ),
        ),
      );
}
