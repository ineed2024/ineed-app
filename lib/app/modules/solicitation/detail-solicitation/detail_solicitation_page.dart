import 'package:Ineed/app/modules/solicitation/detail-solicitation/budget_page_view/budget_page_view.dart';
import 'package:Ineed/app/modules/solicitation/detail-solicitation/visit_page_view/visit_page_view.dart';
import 'package:Ineed/app/styles/app_color_scheme.dart';
import 'package:Ineed/app/widgets/custom_alert_dialog/custom_alert_dialog.dart';
import 'package:Ineed/app/widgets/progress/circuclar_progress_custom.dart';
import 'package:Ineed/domain/entities/navigator/result_data_navigator_entity.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'detail_solicitation_controller.dart';

class DetailSolicitationPage extends StatefulWidget {
  final int solicitationId;
  const DetailSolicitationPage({Key? key, required this.solicitationId})
      : assert(solicitationId != null),
        super(key: key);

  @override
  _DetailSolicitationPageState createState() => _DetailSolicitationPageState();
}

class _DetailSolicitationPageState extends State<DetailSolicitationPage>
    with SingleTickerProviderStateMixin {
  // final contoller = DetailSolicitationController();

  final controller = DetailSolicitationController();
  //use 'controller' variable to access controller

  late TabController _tabController;

  int _currentIndex = 0;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(vsync: this, length: 2, initialIndex: _currentIndex);
    controller.getDetailSolicitation(widget.solicitationId);
  }

  _onActionButtonCancelSolicitation() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      CustomAlertDialog.question(context,
          title: 'Excluir solicitação?',
          message:
              'Tem certeza que deseja excluir a solicitação? Esta ação não pode ser desfeita',
          onActionNegativeButton: () {}, onActionPositiveButton: () async {
        // final result =
        //     await controller.deleteSolicitation(widget.solicitationId);
        // if (result.status == Status.failed) {
        //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        //     CustomAlertDialog.error(context, result.error.message);
        //   });
        // } else {
        //   Modular.to.pop(ResultDataNavigatorEntity(
        //       message: result.message, updateView: true));
        // }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Detalhe da solicitação"),
          actions: [
            Observer(
                builder: (_) => controller.resourceDeleteSolicitation?.status ==
                        Status.loading
                    ? Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: CircularProgressCustom(
                            color: AppColorScheme.white,
                          ),
                        ),
                      )
                    : IconButton(
                        icon: Icon(Icons.delete_outline),
                        onPressed: _onActionButtonCancelSolicitation,
                      ))
          ],
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Visita',
              ),
              Tab(
                text: 'Orçamento',
              )
            ],
          ),
        ),
        body: Observer(
          builder: (_) => controller.resourceSolicitation.status ==
                  Status.loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    VisitPageView(
                        cards: controller.cardsEntity.data!,
                        configuration: controller.configurationEntity.data,
                        solicitation:
                            controller.resourceSolicitation.data!.solicitation!,
                        visit: controller.resourceSolicitation.data!.visit,
                        reloadPage: () => reloadPage()),
                    // Text('Orçamento'),
                    BudgetPageView(
                      cards: controller.cardsEntity.data!,
                      configuration: controller.configurationEntity.data,
                      solicitation:
                          controller.resourceSolicitation.data!.solicitation,
                      budget: controller.resourceSolicitation.data!.budget,
                      reloadPage: () => reloadPage(),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  reloadPage() {
    controller.getDetailSolicitation(widget.solicitationId);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
