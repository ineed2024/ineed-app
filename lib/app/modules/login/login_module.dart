import 'package:Ineed/app/modules/login/forgot_password/forgot_password_page.dart';
import 'package:Ineed/app/modules/login/sign-in/sign_in_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'register/register_page.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const SignInPage()),
    ChildRoute('/register', child: (_, args) => const RegisterPage()),
    ChildRoute('/forgot_password',
        child: (_, args) => const ForgotPasswordPage()),
  ];
}
