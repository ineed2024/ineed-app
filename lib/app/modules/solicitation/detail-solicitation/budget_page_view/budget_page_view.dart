import 'package:Ineed/app/constants/route_name.dart';
import 'package:Ineed/app/constants/solicitation_button_action_type.dart';
import 'package:Ineed/app/modules/solicitation/detail-solicitation/budget_page_view/budget_page_view_controller.dart';
import 'package:Ineed/app/modules/solicitation/detail-solicitation/components/status_widget.dart';
import 'package:Ineed/app/modules/user/cards/list-cards/list_cards_page.dart';
import 'package:Ineed/app/styles/app_color_scheme.dart';
import 'package:Ineed/app/utils/ui_helper.dart';
import 'package:Ineed/app/widgets/buttons/contained_button_widget.dart';
import 'package:Ineed/app/widgets/custom_alert_dialog/custom_alert_dialog.dart';
import 'package:Ineed/domain/entities/budget/budget_entity.dart';
import 'package:Ineed/domain/entities/dropdown/dropdown_item.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:Ineed/app/constants/solicitation_status.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../domain/card/card_entity.dart';
import '../../../../../domain/configurations/configuration_entity.dart';
import '../../../../../domain/entities/solicitation/solicitation_entity.dart';
import '../../../../constants/evaluation_type.dart';
import '../../../../constants/payment_options.dart';
import '../../../../constants/transactions_status.dart';
import '../../../../widgets/category_services/category_services.dart';
import '../../../../widgets/text/text_and_dropdown_horizontal.dart';
import '../../../../widgets/text/two_text_horizontal_with_space_between.dart';
import '../../../../widgets/text/two_text_vertical_with_space_between.dart';
import '../../../evaluation/evaluation_page.dart';

class BudgetPageView extends StatefulWidget {
  final BudgetEntity? budget;
  final SolicitationEntity? solicitation;
  final ConfigurationEntity? configuration;
  final List<CardEntity>? cards;
  final Function? reloadPage;
  const BudgetPageView({
    Key? key,
    this.budget,
    this.solicitation,
    this.configuration,
    this.cards,
    this.reloadPage,
  }) : super(key: key);

  @override
  _BudgetPageViewState createState() => _BudgetPageViewState();
}

class _BudgetPageViewState extends State<BudgetPageView> {
  final controller = BudgetPageViewController();

  final List<DropdownItem> paymentOptions = [
    DropdownItem(value: 1, description: PaymentOptions.creditCard.nameOf()),
    DropdownItem(value: 2, description: PaymentOptions.ticket.nameOf())
  ];

  final List<String> statusTransaction = [
    TransactionsStatus.available.nameOf(),
    TransactionsStatus.canceled.nameOf(),
    TransactionsStatus.debit.nameOf(),
    TransactionsStatus.in_analysis.nameOf(),
    TransactionsStatus.in_dispute.nameOf(),
    TransactionsStatus.pay.nameOf(),
    TransactionsStatus.retention.nameOf(),
    TransactionsStatus.returned.nameOf(),
  ];

  BudgetEntity? budget;

  bool? creditCardPaymentOption;

  EdgeInsets paddingScreen =
      EdgeInsets.only(top: 10.0, bottom: 10.0, left: 16.0, right: 16.0);
  EdgeInsets paddingCard =
      const EdgeInsets.symmetric(vertical: 14, horizontal: 10);

  @override
  void initState() {
    budget = widget.budget;
    controller.configuration = widget.configuration;
    controller.cards = widget.cards;
    controller.initSolicitationButtonAction(
        widget.solicitation!, widget.budget);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: _buildInfoBudget,
        ),
        Container(
            color: Colors.transparent,
            padding: const EdgeInsets.all(16),
            child: Observer(
                builder: (_) => controller.solicitationButton.visibility!
                    ? ContainedButtonWidget(
                        loading: controller.solicitationButton.loading!,
                        text: controller.solicitationButton.type!.valueOf,
                        onPressed: !controller.solicitationButton.enabled!
                            ? null
                            : _onActionButton)
                    : SizedBox.shrink()))
      ],
    );
  }

  get _buildInfoBudget => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 12,
            ),
            CategoryServices(
              titleCategory:
                  widget.solicitation!.services!.first.categoryEntity!.title!,
              crossAxisAlignment: CrossAxisAlignment.center,
              list: widget.solicitation!.services!,
            ),
            SizedBox(
              height: 12,
            ),
            Observer(
              builder: (_) => StatusWidget(
                valueStatus: controller.status.valueOf.toUpperCase(),
              ),
            ),
            Padding(
                padding: paddingScreen,
                child: Card(
                  child: Padding(
                    padding: paddingCard,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TwoTextHorizontalSpaceBetween(
                          paddingHorizontal: false,
                          textLeft: 'Serviço',
                          textRight: widget.budget != null
                              ? UIHelper.moneyFormat(budget!.valueLabor!)
                              : null,
                        ),
                        TwoTextHorizontalSpaceBetween(
                          paddingHorizontal: false,
                          textLeft: 'Material fornecido',
                          textRight: widget.budget != null
                              ? UIHelper.moneyFormat(budget!.valueMaterial!)
                              : null,
                        ),
                        TwoTextHorizontalSpaceBetween(
                          paddingHorizontal: false,
                          textLeft: 'Possui cupom?',
                          textRight:
                              budget?.discount != null && budget!.discount! > 0
                                  ? 'Sim'
                                  : 'Não',
                        ),
                        if (budget != null && budget!.discount! > 0)
                          TwoTextHorizontalSpaceBetween(
                            paddingHorizontal: false,
                            textLeft: 'Desconto',
                            textRight: UIHelper.moneyFormat(budget!.discount!),
                          ),
                        TwoTextHorizontalSpaceBetween(
                          paddingHorizontal: false,
                          textLeft: 'Total',
                          textRight: widget.budget != null
                              ? UIHelper.moneyFormat(budget!.valueMaterial! +
                                  budget!.valueLabor! -
                                  budget!.discount!)
                              : null,
                        ),
                        if (budget?.note != null &&
                            budget!.note!.isNotEmpty &&
                            budget!.note!.length > 1)
                          TwoTextVerticalSpaceBetween(
                            paddingHorizontal: false,
                            textTitle: 'Observações',
                            textMessage: budget!.note!,
                          ),
                      ],
                    ),
                  ),
                )),
            if (_hasPayment) _buildInfoPayment,
            if (_hasExtraTax) _buildExtraTax
          ],
        ),
      );

  get _hasExtraTax => budget != null && budget!.extraTax!.isNotEmpty;

  get _buildInfoPayment => Padding(
        padding: paddingScreen,
        child: Card(
            child: Padding(
          padding: paddingCard,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Pagamento do orçamento',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 1,
                      width: double.maxFinite,
                      child: Container(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Observer(
                        builder: (_) => widget.cards!.isEmpty &&
                                controller.cardChoosedBudget == null
                            ? _buildButtonAddCard(true)
                            : _buildInfoCard(
                                widget.cards!.length > 1 && !budget!.paidOut!,
                                true)),
                  ]),
              SizedBox(
                height: 10,
              ),
              TextAndDropdownHorizontal(
                padding: false,
                text: 'Parcelas',
                list: List<DropdownItem>.generate(
                    controller.configuration!.maxParcels!,
                    (index) => DropdownItem(
                        value: index + 1,
                        description: '${(index + 1).toString()}x')),
                dropdownDisable: budget?.paidOut,
                onChanged: (value) {
                  controller.setInstallment(value!);
                },
                hintDropdown: budget != null && budget!.paidOut!
                    ? budget!.request?.installment.toString()
                    : 'Selecione',
                value: '${budget!.request?.installment.toString()}x',
              )
            ],
          ),
        )),
      );

  Widget _buildInfoCard(bool showButtonChangeCard, bool isCardBudget) => Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon(FlutterIcons.card_bulleted_mco),
          Icon(Icons.card_giftcard),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Crédito pelo app',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColorScheme.black),
                ),
                Text(
                    isCardBudget
                        ? '${controller.cardChoosedBudget!.cardNumber}'
                        : '${controller.cardChoosedExtraTax!.cardNumber}',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColorScheme.neutralMedium2))
              ],
            ),
          ),
          if (showButtonChangeCard) _buildButtonChangeCard(true),
        ],
      );

  get _buildExtraTax => Padding(
      padding: paddingScreen,
      child: Card(
        child: Padding(
          padding: paddingCard,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Taxa extra',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 1,
                  width: double.maxFinite,
                  child: Container(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TwoTextHorizontalSpaceBetween(
                    paddingHorizontal: false,
                    textLeft: 'Valor taxa adicional',
                    textRight: budget!.extraTax! != null &&
                            budget?.extraTax != null &&
                            budget!.extraTax!.length > 0
                        ? UIHelper.moneyFormat(budget!.extraTax![0].value!)
                        : '0,00'),
                SizedBox(
                  height: 20,
                ),
                Observer(
                    builder: (_) => widget.cards!.isEmpty &&
                            controller.cardChoosedExtraTax == null
                        ? _buildButtonAddCard(false)
                        : _buildInfoCard(
                            widget.cards!.length > 1 && !budget!.paidOut!,
                            false)),
              ]),
        ),
      ));

  _buildButtonAddCard(bool forBudget) => InkWell(
      onTap: () => _addCard(forBudget),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              // FlutterIcons.card_bulleted_mco,
              Icons.card_giftcard_rounded,
              color: AppColorScheme.primaryColor,
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                'Adicionar cartão',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 16,
                    color: AppColorScheme.primaryColor,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ));

  Widget _buildButtonChangeCard(bool forBudget) => InkWell(
      onTap: () => _changeCard(forBudget),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 5),
        child: Text(
          'Trocar',
          textAlign: TextAlign.end,
          style: TextStyle(
              fontSize: 16,
              color: AppColorScheme.primaryColor,
              fontWeight: FontWeight.w400),
        ),
      ));

  get _hasPayment =>
      budget?.completed == false &&
      budget?.valueLabor != null &&
      budget?.valueMaterial != null;

  void _onActionButton() {
    switch (controller.solicitationButton.type) {
      case SolicitationButtonActionType.confirmBudget:
        _flowConfirmBudget();
        break;
      case SolicitationButtonActionType.showExtraTax:
        _flowPaidExtraTax();
        break;
      case SolicitationButtonActionType.rateBudget:
        _flowRateBudget();
        break;
      default:
        return null;
    }
  }

  void _flowPaidExtraTax() {
    CustomAlertDialog.question(context,
        title: 'Taxa extra',
        message:
            'Ocorreu um emprevisto no seu serviço e foi necessário adicionar uma taxa extra no orçamento no valor de ${UIHelper.moneyFormat(budget!.extraTax![0].value!)}. Esse valor será cobrado no seu cartão que termina com ${controller.cardChoosedExtraTax!.cardNumber!}.',
        textButtonNegative: 'Cancelar',
        textButtonPositive: 'Pagar',
        onActionNegativeButton: () {}, onActionPositiveButton: () async {
      final result = await controller.onActionConfirmExtraTax(
          widget.solicitation!, budget!);
      if (result.status == Status.success) {
        widget.reloadPage!();
        _showSnackBar('Taxa extra confirmado com sucesso');
      } else {
        // error
        CustomAlertDialog.info(context, 'Taxa extra', result.error!.message!);
      }
    });
  }

  void _flowConfirmBudget() {
    CustomAlertDialog.question(context,
        title: 'Confirmar orçamento',
        message:
            'Será realizada uma compra de ${controller.installment}x de ${UIHelper.moneyFormat(((budget!.valueLabor! + budget!.valueMaterial!) - budget!.discount!) / controller.installment!)}. Deseja continuar?',
        onActionNegativeButton: () {}, onActionPositiveButton: () async {
      final result =
          await controller.onActionConfirmBudget(widget.solicitation!, budget!);
      if (result.status == Status.success) {
        widget.reloadPage!();
        _showSnackBar('Orçamento confirmado com sucesso');
      } else {
        // error
        CustomAlertDialog.info(
            context, 'Confirmar orçamento', result.error!.message!);
      }
    });
  }

  void _flowRateBudget() async {
    final result = await Modular.to.pushNamed(RouteName.evaluation,
        arguments: EvaluationPageArgs(
            option: EvaluationOptions.budget,
            image: widget.solicitation!.services![0].categoryEntity!.image!,
            idObject: widget.budget!.id!,
            title: widget.solicitation!.services![0].title!));
    if (result != null) _showSnackBar('Avaliação registrada com sucesso');
    widget.reloadPage!();
  }

  void _showSnackBar(String message) {
    UIHelper.showInSnackBar(message, context);
  }

  void _changeCard(bool forBudget) async {
    final card = await Modular.to.pushNamed(RouteName.cards,
        arguments: ListCardsPageArgs(onlyChooseCard: true));
    if (card != null) {
      if (forBudget)
        controller.setCardChoosedBudget(card);
      else
        controller.setCardChoosedExtraTax(card);
    }
  }

  void _addCard(bool forBudget) async {
    final card = await Modular.to.pushNamed(RouteName.createCard);
    if (card != null) {
      if (forBudget)
        controller.setCardChoosedBudget(card);
      else
        controller.setCardChoosedExtraTax(card);
    }
  }
}
