import 'package:Ineed/app/constants/solicitation_button_action_type.dart';
import 'package:Ineed/app/constants/solicitation_status.dart';
import 'package:Ineed/di/di.dart';
import 'package:Ineed/domain/entities/budget/budget_entity.dart';
import 'package:Ineed/domain/entities/budget/confirm_budget_card_entity.dart';
import 'package:Ineed/domain/entities/extra_tax/confirm_extra_tax_entity.dart';
import 'package:Ineed/domain/entities/extra_tax/extra_tax_entity.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../../domain/card/card_entity.dart';
import '../../../../../domain/configurations/configuration_entity.dart';
import '../../../../../domain/entities/solicitation/solicitation_button_action_entity.dart';
import '../../../../../domain/entities/solicitation/solicitation_entity.dart';
import '../../../../../domain/extra_tax/confirm_extra_tax_use_case.dart';
import '../../../../../domain/usecases/budget/confirm_budget_card_use_case.dart';

part 'budget_page_view_controller.g.dart';

@Injectable()
class BudgetPageViewController = _BudgetPageViewControllerBase
    with _$BudgetPageViewController;

abstract class _BudgetPageViewControllerBase with Store {
  final confirmBudgetUseCase = getIt.get<ConfirmBudgetCardUseCase>();
  final confirmExtraTaxUseCase = getIt.get<ConfirmExtraTaxUseCase>();

  @observable
  late SolicitationButtonActionEntity solicitationButton;

  @observable
  late SolicitationStatus status;

  ConfigurationEntity? configuration;
  List<CardEntity>? cards;

  @observable
  int? installment;

  @observable
  CardEntity? cardChoosedBudget;

  @observable
  CardEntity? cardChoosedExtraTax;

  SolicitationEntity? solicitationEntity;
  BudgetEntity? budgetEntity;

  @action
  setCardChoosedExtraTax(newCard) {
    cardChoosedExtraTax = newCard;
    validFormExtraTax();
  }

  @action
  setCardChoosedBudget(newCard) {
    cardChoosedBudget = newCard;
    validFormBudget();
  }

  @action
  initSolicitationButtonAction(
      SolicitationEntity solicitation, BudgetEntity? budget) {
    solicitationEntity = solicitation;
    budgetEntity = budget;
    if (cards!.isNotEmpty) {
      cardChoosedBudget = cards![0];
      cardChoosedExtraTax = cards![0];
    }
    if (budget != null) {
      if (!budget.paidOut!) {
        status = SolicitationStatus.pendingConfirmation;
        solicitationButton = SolicitationButtonActionEntity(
            visibility: true, type: SolicitationButtonActionType.confirmBudget);
      }

      if (!budget.paidOut! && budget.transaction != null) {
        solicitationButton = SolicitationButtonActionEntity(visibility: false);
      }

      if (budget.paidOut! && !budget.completed!) {
        status = SolicitationStatus.waitingBudget;
        solicitationButton = SolicitationButtonActionEntity(visibility: false);
      }

      if (budget.paidOut! &&
          !budget.completed! &&
          budget.extraTax != null &&
          budget.extraTax!.length > 0 &&
          !budget.extraTax![0].paidOut!) {
        status = SolicitationStatus.extraTaxConfirmation;
        solicitationButton = SolicitationButtonActionEntity(
            visibility: true,
            type: SolicitationButtonActionType.showExtraTax,
            enabled: cardChoosedExtraTax != null);
      }

      if (budget.paidOut! && budget.completed! && budget.evaluation == null) {
        status = SolicitationStatus.waitingEvaluation;
        solicitationButton = SolicitationButtonActionEntity(
            visibility: true,
            type: SolicitationButtonActionType.rateBudget,
            enabled: true);
      }

      if (budget.paidOut! && budget.completed! && budget.evaluation != null) {
        status = SolicitationStatus.finished;
        solicitationButton = SolicitationButtonActionEntity(
            visibility: false,
            type: SolicitationButtonActionType.rateBudget,
            enabled: true);
      }
    } else
      status = SolicitationStatus.pending;
  }

  @action
  Future<ResourceData<BudgetEntity>> onActionConfirmBudget(
      SolicitationEntity solicitation, BudgetEntity budget) async {
    solicitationButton = solicitationButton.copyWith(loading: true);
    final result = await confirmBudgetUseCase.call(ConfirmBudgetCardEntity(
        budgetId: budget.id,
        cardId: cardChoosedBudget!.id.toString(),
        installments: installment,
        value: budget.valueLabor! + budget.valueMaterial!));
    solicitationButton = solicitationButton.copyWith(loading: false);
    return result;
  }

  @action
  Future<ResourceData<ExtraTaxEntity>> onActionConfirmExtraTax(
      SolicitationEntity solicitation, BudgetEntity budget) async {
    solicitationButton = solicitationButton.copyWith(loading: true);
    final result = await confirmExtraTaxUseCase.call(ConfirmExtraTaxEntity(
        id: budget.extraTax![0].id,
        idCard: cardChoosedExtraTax!.id,
        installments: 1));
    solicitationButton = solicitationButton.copyWith(loading: false);
    return result;
  }

  @action
  setInstallment(int newInstallment) {
    installment = newInstallment;
    validFormBudget();
  }

  @action
  validFormBudget() {
    if (cardChoosedBudget != null &&
        installment != null &&
        solicitationButton.type == SolicitationButtonActionType.confirmBudget) {
      solicitationButton = solicitationButton.copyWith(enabled: true);
    }
  }

  @action
  validFormExtraTax() {
    if (cardChoosedExtraTax != null &&
        solicitationButton.type == SolicitationButtonActionType.showExtraTax) {
      solicitationButton = solicitationButton.copyWith(enabled: true);
    }
  }
}
