import 'package:Ineed/di/di.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../domain/entities/auth/auth_entity.dart';
import '../../../../domain/entities/auth/authentication_entity.dart';
import '../../../../domain/usecases/auth/login_user_email_use_case.dart';

part 'sign_in_controller.g.dart';

@Injectable()
class SignInController = _SignInControllerBase with _$SignInController;

abstract class _SignInControllerBase with Store {
  final _loginEmail = getIt.get<LoginUserEmailUseCase>();

  @observable
  late ResourceData<AuthenticationEntity> loadingEmail =
      ResourceData(status: Status.initial);

  @observable
  bool loadingGoogle = false;
  @observable
  bool loadingApple = false;
  @observable
  bool statusLogin = false;

  init() async {
    // final _statusLogin = await _enableLogin.call();
    // statusLogin = _statusLogin.data;
  }

  @action
  Future<ResourceData<AuthenticationEntity>> loginWithEmail(
      String email, String password) async {
    loadingEmail = ResourceData(status: Status.loading);
    loadingEmail =
        await _loginEmail(AuthEntity(email: email, password: password));
    return loadingEmail;
  }

  // @action
  // Future<void> loginWithGoogle() async {
  //   loadingGoogle = true;
  //   Future.delayed(Duration(seconds: 3000));
  //   loadingGoogle = false;
  // }

  // @action
  // Future<ResourceData<AuthenticationEntity>> loginWithFacebook(
  //     String token) async {
  //   loadingFacebook = true;
  //   return await _facebook.call(AuthFbEntity(accessToken: token));
  // }

  // @action
  // Future<void> loginWithApple() async {
  //   loadingApple = true;
  //   Future.delayed(Duration(seconds: 3000));
  //   loadingApple = false;
  // }
}
