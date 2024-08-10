import 'package:Ineed/domain/utils/status.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Ineed/domain/usecases/auth/update_password_use_case.dart';
import 'package:Ineed/domain/entities/auth/update_password_entity.dart';
import 'package:Ineed/di/di.dart';
import 'package:Ineed/domain/utils/resource_data.dart';

part 'update_password_controller.g.dart';

@Injectable()
class UpdatePasswordController = _UpdatePasswordControllerBase
    with _$UpdatePasswordController;

abstract class _UpdatePasswordControllerBase with Store {
  final updateAddressUseCase = getIt.get<UpdatePasswordUseCase>();

  @observable
  bool enableButton = false;

  @observable
  ResourceData resource = ResourceData(status: Status.initial);

  Future<ResourceData> onUpdatePassword(
      String passwordOld, String passwordNew) async {
    return resource = await updateAddressUseCase(UpdatePasswordEntity(
        passwordNew: passwordNew, passwordOld: passwordOld));
  }

  void setEnableButton(bool value) {
    enableButton = value;
  }
}
