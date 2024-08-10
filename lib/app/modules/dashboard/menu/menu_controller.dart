import 'package:Ineed/di/di.dart';
import 'package:Ineed/domain/usecases/auth/logout_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'menu_controller.g.dart';

@Injectable()
class MenuAppController = _MenuAppControllerBase with _$MenuAppController;

abstract class _MenuAppControllerBase with Store {
  final _logoutUseCase = getIt.get<LogoutUseCase>();

  @observable
  ResourceData resourceData = ResourceData(status: Status.initial);

  @action
  Future<ResourceData> logout() async {
    resourceData = ResourceData(status: Status.loading);
    resourceData = await _logoutUseCase.call();
    return resourceData;
  }
}
