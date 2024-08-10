import 'package:Ineed/di/di.dart';
import 'package:Ineed/domain/entities/auth/forgot_password_entity.dart';
import 'package:Ineed/domain/usecases/auth/forgot_password_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'forgot_password_controller.g.dart';

@Injectable()
class ForgotPasswordController = _ForgotPasswordControllerBase
    with _$ForgotPasswordController;

abstract class _ForgotPasswordControllerBase with Store {
  final _forgotPasswordUseCase = getIt.get<ForgotPasswordUseCase>();

  @observable
  ResourceData loadingForgotPassword = ResourceData(status: Status.initial);

  @action
  Future<ResourceData> forgotPassword(String email) async {
    loadingForgotPassword = ResourceData(status: Status.loading);
    loadingForgotPassword =
        await _forgotPasswordUseCase(ForgotPasswordEntity(email: email));
    return loadingForgotPassword;
  }
}
