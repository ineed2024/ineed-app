import 'package:Ineed/app/constants/route_name.dart';
import 'package:Ineed/app/modules/solicitation/list-solicitations/list_solicitations_controller.dart';
import 'package:Ineed/app/utils/ui_helper.dart';
import 'package:Ineed/app/widgets/page_error/page_error.dart';
import 'package:Ineed/app/widgets/progress/circuclar_progress_custom.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../domain/entities/navigator/result_data_navigator_entity.dart';
import '../components/item_solicitation_list.dart';

class ListSolicitationsPage extends StatefulWidget {
  const ListSolicitationsPage({Key? key}) : super(key: key);

  @override
  _ListSolicitationsPageState createState() => _ListSolicitationsPageState();
}

class _ListSolicitationsPageState extends State<ListSolicitationsPage> {
  final controller = ListSolicitationsController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    controller.getAllSolicitations();
    super.initState();
  }

  _onActionItemSolicitation(BuildContext context, int index) async {
    if (!controller.resourceSolicitation.data![index].active!)
      UIHelper.showInSnackBar(
          'Solicitações canceladas não podem ser editadas', context);
    else {
      final navigator = await Modular.to.pushNamed(RouteName.solicitationDetail,
              arguments: controller.resourceSolicitation.data![index].id)
          as ResultDataNavigatorEntity;
      if (navigator != null) {
        if (navigator.updateView!) controller.getAllSolicitations();
        if (navigator.message != null) _showSnackBar(navigator.message!);
      }
    }
  }

  _showSnackBar(String message) => UIHelper.showInSnackBar(message, context);
  // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //   _scaffoldKey.currentState.showSnackBar(SnackBar(
  //     content: Text(message),
  //   ));
  // });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Solicitações"),
      ),
      body: Center(
        child: Container(
          child: Observer(builder: (_) {
            switch (controller.resourceSolicitation.status) {
              case Status.success:
                return controller.resourceSolicitation.data!.isEmpty
                    ? Center(child: Text("Nenhuma solicitação encontrada"))
                    : ListView.separated(
                        itemCount: controller.resourceSolicitation.data!.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          final solicitation =
                              controller.resourceSolicitation.data![index];
                          return ItemSolicitationList(
                            solicitation: solicitation,
                            onTap: () =>
                                _onActionItemSolicitation(context, index),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(
                          height: 16.h,
                          color: Colors.transparent,
                        ),
                      );
              case Status.failed:
                return PageError(
                  messageError: controller.resourceSolicitation.error?.message,
                  onPressed: controller.getAllSolicitations,
                );
                break;
              default:
                return CircularProgressCustom();
            }
          }),
        ),
      ),
    );
  }
}
