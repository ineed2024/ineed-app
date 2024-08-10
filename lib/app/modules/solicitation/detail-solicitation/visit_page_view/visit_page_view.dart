import 'package:Ineed/app/constants/evaluation_type.dart';
import 'package:Ineed/app/constants/route_name.dart';
import 'package:Ineed/app/constants/solicitation_status.dart';
import 'package:Ineed/app/modules/evaluation/evaluation_page.dart';
import 'package:Ineed/app/modules/solicitation/detail-solicitation/components/status_widget.dart';
import 'package:Ineed/app/modules/solicitation/detail-solicitation/visit_page_view/visit_page_view_controller.dart';
import 'package:Ineed/app/utils/ui_helper.dart';
import 'package:Ineed/app/widgets/buttons/contained_button_widget.dart';
import 'package:Ineed/app/widgets/category_services/category_services.dart';
import 'package:Ineed/app/widgets/custom_alert_dialog/custom_alert_dialog.dart';
import 'package:Ineed/app/widgets/text/two_text_horizontal_with_space_between.dart';
import 'package:Ineed/domain/entities/visit/visit_entity.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:Ineed/app/constants/solicitation_button_action_type.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../domain/card/card_entity.dart';
import '../../../../../domain/configurations/configuration_entity.dart';
import '../../../../../domain/entities/solicitation/solicitation_entity.dart';

class VisitPageView extends StatefulWidget {
  final SolicitationEntity solicitation;
  final VisitEntity? visit;
  final Function? reloadPage;
  final ConfigurationEntity? configuration;
  final List<CardEntity>? cards;

  const VisitPageView({
    required this.solicitation,
    this.reloadPage,
    this.visit,
    this.configuration,
    this.cards,
  });

  @override
  _VisitPageViewState createState() => _VisitPageViewState();
}

class _VisitPageViewState extends State<VisitPageView> {
  final controller = VisitPageViewController();

  EdgeInsets paddingScreen =
      EdgeInsets.only(top: 10.0, bottom: 10.0, left: 16.0, right: 16.0);
  EdgeInsets paddingCard =
      const EdgeInsets.symmetric(vertical: 14, horizontal: 10);

  @override
  void initState() {
    controller.initSolicitationButtonAction(widget.solicitation, widget.visit);
    super.initState();
  }

  get _buildInfoVisit => SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
            SizedBox(
              height: 12,
            ),
            Container(
              width: 80,
              height: 80,
              child: CircleAvatar(
                radius: 18,
                child: ClipOval(
                  child: Image.asset('assets/images/placeholder_user.jpg'),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              widget.visit != null
                  ? controller.visitController!.collaborator!.first.name!
                  : '',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 12,
            ),
            CategoryServices(
              titleCategory:
                  widget.solicitation!.services!.first.categoryEntity!.title!,
              crossAxisAlignment: CrossAxisAlignment.center,
              list: widget.solicitation.services!,
            ),
            SizedBox(
              height: 12,
            ),
            Observer(
              builder: (_) => StatusWidget(
                valueStatus: controller.status!.valueOf.toUpperCase(),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Icon(FlutterIcons.location_on_mdi),
                            Icon(Icons.location_pin),
                            Expanded(
                                child: Text(widget.solicitation.address ?? ''))
                          ],
                        ),
                      ),
                      TwoTextHorizontalSpaceBetween(
                          paddingHorizontal: false,
                          textLeft: 'Horário',
                          textRight: (widget.visit != null
                              ? UIHelper.formatDateTime(
                                  controller.visitController!.visitDate!)
                              : '')),
                      TwoTextHorizontalSpaceBetween(
                          paddingHorizontal: false,
                          textLeft: 'Confirmado',
                          textRight: (widget.visit != null
                              ? controller.visitController!.paidOut!
                                  ? 'Sim'
                                  : 'Não'
                              : '')),
                      if (widget.visit != null && widget.solicitation.urgent!)
                        TwoTextHorizontalSpaceBetween(
                            paddingHorizontal: false,
                            textLeft: 'Urgente',
                            textRight:
                                'Adicional ${UIHelper.moneyFormat(controller.visitController!.value!)}')
                    ],
                  ),
                ),
              ),
            )
          ]));

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: _buildInfoVisit,
        ),
        Container(
          color: Colors.transparent,
          padding: const EdgeInsets.all(16),
          child: Observer(
              builder: (_) => controller.solicitationButton != null &&
                      controller.solicitationButton!.visibility!
                  ? ContainedButtonWidget(
                      loading: controller.solicitationButton!.loading!,
                      text: controller.solicitationButton!.type!.valueOf,
                      onPressed: onActionButton)
                  : SizedBox.shrink()),
        )
      ],
    );
  }

  void onActionButton() {
    switch (controller.solicitationButton!.type!) {
      case SolicitationButtonActionType.confirmVisit:
        flowConfirmVisit();
        break;
      case SolicitationButtonActionType.rateVisit:
        flowRateVisit();
        break;
      default:
        return null;
    }
  }

  flowRateVisit() async {
    final result = await Modular.to.pushNamed(RouteName.evaluation,
        arguments: EvaluationPageArgs(
            option: EvaluationOptions.visit,
            image: widget.solicitation.services![0].categoryEntity!.image!,
            idObject: widget.visit!.id!,
            title: widget.solicitation.services![0].title!));
    if (result != null) _showSnackBar('Avaliação registrada com sucesso');
    widget.reloadPage!();
  }

  flowConfirmVisit() {
    String message = 'Tem certeza que deseja confirmar a visita?';
    if (widget.visit!.value! > 0) {
      message =
          '$message Será lançado uma taxa de urgência no valor de ${UIHelper.moneyFormat(widget.visit!.value!)} no seu cartão de crédito.';
    }
    CustomAlertDialog.question(context,
        title: 'Confirmar visita',
        message: message,
        onActionNegativeButton: () {}, onActionPositiveButton: () async {
      final result = await controller.onActionConfirmVisit(
          widget.solicitation, widget.visit!);
      if (result.status == Status.success) {
        widget.reloadPage!();
        _showSnackBar('Visita confirmada com sucesso');
      } else {
        // error
        CustomAlertDialog.info(
            context, 'Confirmar visita', result.error!.message!);
      }
    });
  }

  _showSnackBar(String message) {
    UIHelper.showInSnackBar(message, context);
    // BuildContext con = context;
    // final snackBar = SnackBar(content: Text(message));
    // Scaffold.of(con).showSnackBar(snackBar);
  }
}
