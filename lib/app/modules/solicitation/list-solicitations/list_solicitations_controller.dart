import 'package:Ineed/di/di.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../domain/entities/solicitation/solicitation_entity.dart';
import '../../../../domain/usecases/solicitation/list_solicitations_use_case.dart';

part 'list_solicitations_controller.g.dart';

@Injectable()
class ListSolicitationsController = _ListSolicitationsControllerBase
    with _$ListSolicitationsController;

abstract class _ListSolicitationsControllerBase with Store {
  final listSolicitationsUseCase = getIt.get<ListSolicitationsUseCase>();

  @observable
  ResourceData<List<SolicitationEntity>> resourceSolicitation =
      ResourceData(status: Status.initial);

  @action
  getAllSolicitations() async {
    resourceSolicitation = ResourceData(status: Status.loading);
    resourceSolicitation = await listSolicitationsUseCase();
  }
}
