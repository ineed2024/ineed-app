import 'package:Ineed/di/di.dart';
import 'package:Ineed/domain/usecases/card/get_all_cards_use_case.dart';
import 'package:Ineed/domain/usecases/configuration/get_configuration_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../domain/card/card_entity.dart';
import '../../../../domain/configurations/configuration_entity.dart';
import '../../../../domain/entities/solicitation/detail_solicitation_entity.dart';
import '../../../../domain/usecases/solicitation/detail_solicitation_use_case.dart';
import '../../../../domain/utils/status.dart';

part 'detail_solicitation_controller.g.dart';

@Injectable()
class DetailSolicitationController = _DetailSolicitationControllerBase
    with _$DetailSolicitationController;

abstract class _DetailSolicitationControllerBase with Store {
  final detailSolicitationUseCase = getIt.get<DetailSolicitationUseCase>();
  // final deleteSolicitationUseCase = getIt.get<DeleteSolicitationUseCase>();
  final cardsUserCase = getIt.get<GetAllCardUseCase>();
  final configurationUseCase = getIt.get<GetConfigurationUseCase>();

  @observable
  ResourceData<DetailSolicitationEntity> resourceSolicitation =
      ResourceData(status: Status.loading);

  @observable
  ResourceData resourceDeleteSolicitation =
      ResourceData(status: Status.loading);

  ResourceData<ConfigurationEntity> configurationEntity =
      ResourceData(status: Status.loading);
  ResourceData<List<CardEntity>> cardsEntity =
      ResourceData(status: Status.loading);

  @action
  // Future<ResourceData> deleteSolicitation(int idSolicitation) async {
  //   resourceDeleteSolicitation = ResourceData.loading();
  //   return resourceDeleteSolicitation =
  //       await deleteSolicitationUseCase.call(idSolicitation);
  // }

  @action
  getDetailSolicitation(int solicitationId) async {
    resourceSolicitation = ResourceData(status: Status.loading);
    configurationEntity = await configurationUseCase.call();
    cardsEntity = await cardsUserCase.call();
    resourceSolicitation = await detailSolicitationUseCase.call(solicitationId);
  }
}
