import 'package:Ineed/app/constants/route_name.dart';
import 'package:Ineed/app/styles/app_color_scheme.dart';
import 'package:Ineed/app/utils/validators.dart';
import 'package:Ineed/app/widgets/custom_alert_dialog/custom_alert_dialog.dart';
import 'package:Ineed/domain/entities/auth/auth_entity.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/buttons/contained_button_widget.dart';
import '../../../widgets/buttons/flat_button_widget.dart';
import '../../../widgets/buttons/icon_button.dart';
import '../../../widgets/icons/icons_utils.dart';
import '../components/email_outlined_text_field_widget.dart';
import '../components/password_outlined_text_field_widget.dart';
import 'sign_in_controller.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  final controller = SignInController();

  @override
  void initState() {
    controller.init();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  Future<void> onActionSignUp() async {
    final result = await Modular.to.pushNamed(RouteName.register);
    if (result is AuthEntity) {
      _emailController.text = result.email;
      _passwordController.text = result.password;
      _onActionSignIn();
    }
  }

  Future<void> onActionForgotPassword() =>
      Modular.to.pushNamed(RouteName.forgotPassword);

  Future<void> _onActionSignIn() async {
    // if (_formKey.currentState!.validate()) return;
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      final login = await controller.loginWithEmail(
        _emailController.text,
        _passwordController.text,
      );

      if (login.status == Status.failed) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          CustomAlertDialog.error(
              context, login.error?.message ?? 'Erro ao efetuar login');
        });
      } else
        Modular.to.pushReplacementNamed(RouteName.dashboard);
    }
  }

  Future<void> loginThirdParty(Future Function() login) async {}

  // Future<void> loginThirdParty(
  //     Future<Resource<UserEntity>> Function() login) async {
  //   final loginResult = await login();

  //   if (loginResult.status == Status.failed) {
  //     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //       CustomAlertDialog.error(context, loginResult.error.message);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final flexHeader = 25;
    final flexContent = 68;
    final flexFooter = 12;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: LayoutBuilder(builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: <Widget>[
                    Expanded(
                        flex: flexHeader,
                        child: ClipPath(
                          clipper: ShapeBorderClipper(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20)))),
                          child: Container(
                              color: AppColorScheme.primaryColor,
                              alignment: Alignment.center,
                              child: Image.asset(
                                IconsUtils.logo_white,
                                height: 56,
                              )),
                        )),
                    Expanded(
                        flex: flexContent,
                        child: Container(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 24, horizontal: 24),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Text(
                                  "Bem vindo",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                Text("Faça o login para começar",
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
                                const Spacer(flex: 1),
                                EmailOutlinedTextFieldWidget(
                                  placeholder: "Digite seu email",
                                  controller: _emailController,
                                  validator: Validators.email,
                                  textInputAction: TextInputAction.next,
                                  focusNode: _emailFocus,
                                  onSubmitted: (value) {
                                    Focus.of(context)
                                        .requestFocus(_passwordFocus);
                                  },
                                ),
                                SizedBox(
                                  height: 36.h,
                                ),
                                PasswordOutlinedTextFieldWidget(
                                  placeholder: "Digite sua senha",
                                  controller: _passwordController,
                                  validator: Validators.password,
                                  textInputAction: TextInputAction.done,
                                  onSubmitted: (value) {
                                    _onActionSignIn();
                                    FocusScope.of(context).unfocus();
                                  },
                                ),
                                const Spacer(flex: 1),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: FlatButtonWidget(
                                          text: "Cadastre-se",
                                          onPressed: onActionSignUp),
                                    ),
                                    SizedBox(
                                      width: 36.w,
                                    ),
                                    Expanded(
                                      child: Observer(builder: (_) {
                                        return ContainedButtonWidget(
                                            loading: controller
                                                    .loadingEmail.status ==
                                                Status.loading,
                                            text: "Entrar",
                                            onPressed: _onActionSignIn);
                                      }),
                                    ),
                                  ],
                                ),
                                const Spacer(flex: 1),
                                FlatButtonWidget(
                                    text: "Esqueci minha senha",
                                    onPressed: onActionForgotPassword),
                              ],
                            ),
                          ),
                        ))),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
