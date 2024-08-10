import 'package:Ineed/di/di.dart';
import 'package:Ineed/domain/entities/auth/auth_entity.dart';
import 'package:Ineed/domain/entities/auth/authentication_entity.dart';
import 'package:Ineed/domain/entities/auth/sign_in_entity.dart';
import 'package:Ineed/domain/usecases/auth/login_user_email_use_case.dart';
import 'package:Ineed/domain/usecases/auth/sign_in.use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../domain/entities/user/user_entity.dart';

part 'register_controller.g.dart';

@Injectable()
class RegisterController = _RegisterControllerBase with _$RegisterController;

abstract class _RegisterControllerBase with Store {
  final _signInUseCase = getIt.get<SignInUseCase>();
  final _loginEmail = getIt.get<LoginUserEmailUseCase>();

  @observable
  ResourceData<UserEntity> loadingRegister =
      ResourceData(status: Status.initial);

  @observable
  ResourceData<AuthenticationEntity> loadingEmail =
      ResourceData(status: Status.initial);

  @action
  Future<ResourceData<AuthenticationEntity>> signin(
      String email, String password) async {
    loadingEmail = ResourceData(status: Status.loading);
    loadingEmail =
        await _loginEmail(AuthEntity(email: email, password: password));
    return loadingEmail;
  }

  @action
  Future<ResourceData<UserEntity>> registerAccount(
      String name, String email, String password) async {
    loadingRegister = ResourceData(status: Status.loading);
    loadingRegister = await _signInUseCase(
        SignInEntity(name: name, email: email, password: password));
    return loadingRegister;
  }
}
