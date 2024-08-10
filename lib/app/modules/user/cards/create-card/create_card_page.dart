import 'package:Ineed/app/widgets/buttons/contained_button_widget.dart';
import 'package:Ineed/app/widgets/custom_alert_dialog/custom_alert_dialog.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../domain/card/create_card_entity.dart';
import '../../../../widgets/credit-card/credit_card_form.dart';
import '../../../../widgets/credit-card/credit_card_widget.dart';
import 'create_card_controller.dart';

class CreateCardPage extends StatefulWidget {
  const CreateCardPage({Key? key}) : super(key: key);

  @override
  _CreateCardPageState createState() => _CreateCardPageState();
}

class _CreateCardPageState extends State<CreateCardPage> {
  final controller = CreateCardController();
  _onActionAddCard() async {
    FocusScope.of(context).unfocus();
    final result = await controller.createCard();

    if (result.status == Status.failed) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        CustomAlertDialog.error(context, result.error!.message!);
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        CustomAlertDialog.success(
            context: context,
            title: 'Adicionar cartão',
            message: 'Seu cartão foi adicionado com sucesso!',
            onActionButton: () {
              Modular.to.pop(result.data);
            });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Cartões'),
      ),
      body: SafeArea(
        child: Observer(
          builder: (_) => IgnorePointer(
            ignoring: controller.resourceCard.status == Status.loading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Observer(
                        builder: (_) => CreditCardWidget(
                              cardNumber:
                                  controller.createCardEntity?.cardNumber ?? '',
                              expiryDate:
                                  controller.createCardEntity?.expirationDate ??
                                      '',
                              cardHolderName:
                                  controller.createCardEntity?.holder ?? '',
                              cvvCode:
                                  controller.createCardEntity?.securityCode ??
                                      '',
                              customerName:
                                  controller.createCardEntity?.securityCode ??
                                      '',
                              showBackView:
                                  controller.createCardEntity?.isCvvFocused ??
                                      false,
                            )),
                    CreditCardForm(
                      onCreditCardModelChange: (a) =>
                          onCreditCardModelChange(a),
                    )
                  ],
                ),
                Observer(
                    builder: (_) => Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 10, bottom: 10),
                          child: ContainedButtonWidget(
                              loading: controller.resourceCard.status ==
                                      Status.loading
                                  ? true
                                  : false,
                              text: 'Adicionar cartão',
                              onPressed: () => _onActionAddCard()),
                        ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  onCreditCardModelChange(CreateCardEntity cardEntity) {
    controller.setCreateCardEntity(cardEntity);
  }
}
