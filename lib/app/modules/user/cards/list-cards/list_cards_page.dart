import 'package:Ineed/app/constants/route_name.dart';
import 'package:Ineed/app/utils/ui_helper.dart';
import 'package:Ineed/app/widgets/buttons/contained_button_widget.dart';
import 'package:Ineed/app/widgets/custom_alert_dialog/custom_alert_dialog.dart';
import 'package:Ineed/app/widgets/page_error/page_error.dart';
import 'package:Ineed/app/widgets/progress/circuclar_progress_custom.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../components/item_card_list.dart';
import 'list_cards_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListCardsPageArgs {
  final bool onlyChooseCard;

  ListCardsPageArgs({this.onlyChooseCard = false});
}

class ListCardsPage extends StatefulWidget {
  const ListCardsPage({Key? key}) : super(key: key);

  @override
  _ListCardsPageState createState() => _ListCardsPageState();
}

class _ListCardsPageState extends State<ListCardsPage> {
  final controller = ListCardsController();
  //use 'controller' variable to access controller

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    controller.getCards();
    super.initState();
  }

  _onActionItemCard(BuildContext context, int index) async {
    await CustomAlertDialog.question(context,
        title: 'Excluir cartão',
        message:
            'Tem certeza que deseja excluir o cartão com final ${controller.resourceCards.data![index].cardNumber}?',
        onActionNegativeButton: () {}, onActionPositiveButton: () async {
      await controller.removeCard(index);
      UIHelper.showInSnackBar('Cartão excluído com sucesso', context);
    });
  }

  _onActionAddCard() async {
    final cardCreated = await Modular.to.pushNamed(RouteName.createCard);
    if (cardCreated != null) controller.getCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Cartões'),
      ),
      body: SafeArea(
          child: Center(
        child: Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Expanded(
              child: Observer(
                builder: (_) {
                  switch (controller.resourceCards.status) {
                    case Status.success:
                      return controller.resourceCards.data!.isEmpty
                          ? Center(child: Text("Nenhum cartão encontrado"))
                          : ListView.separated(
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                final card =
                                    controller.resourceCards.data![index];
                                return ItemCardList(
                                  invisibleTrailing: false,
                                  card: card,
                                  onTap: (card) {
                                    Modular.to.pop(card);
                                  },
                                  onActionDelete: () =>
                                      _onActionItemCard(context, index),
                                );
                              },
                              itemCount: controller.resourceCards.data!.length,
                              separatorBuilder: (context, index) => Divider(
                                    height: 16.h,
                                    color: Colors.transparent,
                                  ));
                      break;
                    case Status.failed:
                      return PageError(
                        messageError: controller.resourceCards.error?.message,
                        onPressed: controller.getCards,
                      );
                      break;
                    default:
                      return Center(
                        child: CircularProgressCustom(),
                      );
                  }
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  top: 5, bottom: 10, left: 16, right: 16),
              child: ContainedButtonWidget(
                text: 'Adicionar cartão',
                onPressed: _onActionAddCard,
              ),
            )
          ]),
        ),
      )),
    );
  }
}
