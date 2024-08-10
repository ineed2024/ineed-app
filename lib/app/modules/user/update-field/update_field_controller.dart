import 'package:Ineed/app/modules/user/update-field/update_field_page.dart';
import 'package:Ineed/di/di.dart';
import 'package:Ineed/domain/entities/user/user_entity.dart';
import 'package:Ineed/domain/usecases/user/profile_user_use_case.dart';
import 'package:Ineed/domain/usecases/user/update_cpf_user_use_case.dart';
import 'package:Ineed/domain/usecases/user/update_phone_user_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'update_field_controller.g.dart';

@Injectable()
class UpdateFieldController = _UpdateFieldControllerBase
    with _$UpdateFieldController;

abstract class _UpdateFieldControllerBase with Store {
  final updateCpfUseCase = getIt.get<UpdateCpfUseCase>();
  final updatePhonenumberUseCase = getIt.get<UpdatePhoneUseCase>();
  final profileUserUseCase = getIt.get<ProfileUserUseCase>();

  @observable
  ResourceData<UserEntity> resourceUser = ResourceData(status: Status.initial);

  @observable
  ResourceData<UserEntity> resourceProfileUser =
      ResourceData(status: Status.initial);

  @observable
  bool isFormValid = false;

  @action
  Future<void> getProfileUser() async {
    resourceProfileUser = ResourceData(status: Status.loading);
    resourceProfileUser = await profileUserUseCase();
  }

  @action
  void validateForm(bool newValue) {
    isFormValid = newValue;
  }

  @action
  Future<ResourceData<UserEntity>?> updateField(
      String type, String value) async {
    resourceUser = ResourceData(status: Status.loading);
    switch (type) {
      case 'email':
        resourceUser = await Future.delayed(Duration(seconds: 3))
            .then((value) => ResourceData(status: Status.success));
        return resourceUser;
      case 'phone':
        resourceUser = await updatePhonenumberUseCase(value);
        return resourceUser;
      case 'cpfCnpj':
        resourceUser = await updateCpfUseCase(value);
        return resourceUser;
      default:
        return null;
    }
  }
}
