import 'package:Ineed/app/constants/evaluation_type.dart';
import 'package:Ineed/app/constants/route_name.dart';
import 'package:Ineed/app/constants/solicitation_button_action_type.dart';
import 'package:Ineed/app/constants/solicitation_status.dart';
import 'package:Ineed/app/modules/evaluation/evaluation_page.dart';
import 'package:Ineed/di/di.dart';
import 'package:Ineed/domain/entities/visit/confirm_visit_entity.dart';
import 'package:Ineed/domain/entities/visit/confirm_visit_with_credit_card_entity.dart';
import 'package:Ineed/domain/entities/visit/visit_entity.dart';
import 'package:Ineed/domain/usecases/visit/confirm_visit_use_case.dart';
import 'package:Ineed/domain/usecases/visit/confirm_visit_with_credit_card_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../../domain/entities/solicitation/solicitation_button_action_entity.dart';
import '../../../../../domain/entities/solicitation/solicitation_entity.dart';

part 'visit_page_view_controller.g.dart';

@Injectable()
class VisitPageViewController = _VisitPageViewControllerBase
    with _$VisitPageViewController;

abstract class _VisitPageViewControllerBase with Store {
  final _confirmVisitWithCreditCardUseCase =
      getIt.get<ConfirmVisitWithCreditCardUseCase>();

  final _confirmVisitUseCase = getIt.get<ConfirmVisitUseCase>();

  @observable
  SolicitationButtonActionEntity? solicitationButton;

  @observable
  SolicitationStatus? status;

  @observable
  VisitEntity? visitController;

  @action
  initSolicitationButtonAction(
      SolicitationEntity solicitation, VisitEntity? visit) {
    if (visit != null) {
      if (!visit.paidOut!) {
        status = SolicitationStatus.pendingConfirmation;
        solicitationButton = SolicitationButtonActionEntity(
          visibility: true,
          type: SolicitationButtonActionType.confirmVisit,
        );
      }

      if (visit.paidOut! && visit.value! > 0 && visit.request != null) {
        // TODO: tem coisa pra fazer aqui
      }

      if (visit.paidOut! && !visit.completed!) {
        status = SolicitationStatus.waitingVisit;
        solicitationButton = SolicitationButtonActionEntity(visibility: false);
      }

      if (visit.paidOut! && visit.completed! && visit.evaluation == null) {
        status = SolicitationStatus.waitingEvaluation;
        solicitationButton = SolicitationButtonActionEntity(
            visibility: true, type: SolicitationButtonActionType.rateVisit);
      }

      if (visit.paidOut! && visit.completed! && visit.evaluation != null) {
        status = SolicitationStatus.finished;
        solicitationButton = SolicitationButtonActionEntity(visibility: false);
      }
    } else
      status = SolicitationStatus.pending;

    visitController = visit;
  }

  @action
  Future<ResourceData> onActionConfirmVisit(
      SolicitationEntity solicitation, VisitEntity visit) {
    // PAGAMENTO VIA CARTAO
    if (visit.value! > 0) {
      return confirmVisitWithCreditCard(solicitation, visit);
    } else {
      // VISITA GRATIS
      return confirmVisitFree(solicitation, visit);
    }
  }

  Future<ResourceData> confirmVisitWithCreditCard(
      SolicitationEntity solicitationEntity, VisitEntity visit) async {
    // verificar se visit.urgentValue eh > 0 e se tem cartao de credito
    // se nao tiver cartao de credito deve mostrar um alert
    // if (visit.value! > 0 ) {
    //   print('visita urgente e não tem cartão');
    //   return ResourceData(
    //       status: Status.failed,
    //       message:
    //           'Você precisa adicionar um cartão para confirmar essa visita. Na tela principal clique nos 3 pontinhos em seguida selecione cartões e adicionar cartão.');
    // } else {
    solicitationButton = solicitationButton?..loading = true;
    final result = await _confirmVisitWithCreditCardUseCase.call(
        ConfirmVisitWithCreditCardEntity(
            paidOut: true, value: visit.value, visitId: visit.id));
    solicitationButton = solicitationButton!..loading = false;
    return result;
    // }
  }

  confirmVisitWithPaymentSlip(
      SolicitationEntity solicitation, VisitEntity visit) {
    // loading informando que ta gerando boleto
    // gerar boleto
    // Caso de Gerar boleto tem que pegar a sessao do pagseguro
    // /pagseguro/session que result em um data
    // deve-se pegar o code (session id)
    // usar a hash para /visita/confirmar
    // passando {id: visit.id, metodoPagamento: 2, senderHash}
    // senderHash = {session-id: hasj}
  }

  Future<ResourceData> confirmVisitFree(
      SolicitationEntity solicitation, VisitEntity visit) async {
    solicitationButton = solicitationButton!.copyWith(loading: true);
    // loading
    // recuperar o visit.value.toFixed(2) e fazer requisicao de confirmar visita
    // PATCH /visita?id=visitaId
    // body {pago: true, valor: visit.value.toFixed(2) * 100, cartaoId: null }
    solicitationButton = solicitationButton!..loading = true;
    final result = await _confirmVisitUseCase.call(ConfirmVisitEntity(
        cardId: null,
        paidOut: true,
        value: visit.value! * 100,
        visitId: visit.id));
    solicitationButton = solicitationButton!..loading = false;
    print(result.toString());
    return result;
  }

  @action
  reloadPage(SolicitationEntity solicitation, VisitEntity? visit) {
    initSolicitationButtonAction(solicitation, visit);
  }
}
