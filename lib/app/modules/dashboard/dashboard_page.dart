import 'package:Ineed/app/constants/route_name.dart';
import 'package:Ineed/app/modules/dashboard/components/category_item_grid_view.dart';
import 'package:Ineed/app/modules/dashboard/components/header.dart';
import 'package:Ineed/app/modules/dashboard/dashboard_controller.dart';
import 'package:Ineed/app/styles/app_text_theme.dart';
import 'package:Ineed/app/widgets/appbar/custom_app_bar.dart';
import 'package:Ineed/app/widgets/page_error/page_error.dart';
import 'package:Ineed/app/widgets/progress/circuclar_progress_custom.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../../domain/entities/service/category_entity.dart';

class DashboardPage extends StatefulWidget {
  final String title;
  const DashboardPage({Key? key, this.title = "Dashboard"}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final controller = DashboardController();

  @override
  void initState() {
    controller.testsUseCases();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.init();
    return Scaffold(
        appBar: AppBarCustom(
          context,
          elevation: 0,
          leading: IconButton(
              // icon: Icon(FlutterIcons.whatsapp_mco),
              icon: Icon(Icons.phone),
              onPressed: () async {
                final link = WhatsAppUnilink(
                  phoneNumber: '5585996779697',
                  text: "",
                );
                await launch('$link');
              }),
          actions: [
            IconButton(
                // icon: Icon(FlutterIcons.dots_horizontal_circle_outline_mco),
                icon: Icon(Icons.menu),
                onPressed: () => Modular.to.pushNamed(
                      RouteName.menu,
                    ))
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Column(
                children: [
                  Observer(
                      builder: (_) => Header(
                            hasSolititation: controller.hasSolicitationOpen,
                            totalSolicitation: controller.totalSolicitationOpen,
                            onPressedButton: _onActionGoToSolicitationList,
                          )),
                  Container(
                      padding: const EdgeInsets.only(
                          top: 16, bottom: 16, left: 16, right: 16),
                      child: Column(children: [
                        SizedBox(
                          height: 26.h,
                        ),
                        Text("Qual serviço deseja solicitar?",
                            style: AppTextTheme.titleDashboardPage),
                        SizedBox(
                          height: 46.h,
                        ),
                        // SearchOutlinedTextFieldFormWidget(
                        //   keyboardType: TextInputType.text,
                        //   inputAction: TextInputAction.search,
                        // ),
                        // SizedBox(
                        //   height: 16.h,
                        // ),
                        // Text("Faça uma busca em mais de 100 serviços",
                        //     style: AppTextTheme.infoSerachDashboardPage),
                        // SizedBox(
                        //   height: 46.h,
                        // ),
                        Observer(builder: (_) {
                          switch (controller.categories.status) {
                            case Status.success:
                              return controller.categories.data!.isNotEmpty
                                  ? GridView.count(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      crossAxisCount: 4,
                                      mainAxisSpacing: 5,
                                      childAspectRatio: 100.w / 110.h,
                                      children: List.generate(
                                          controller.categories.data!.length,
                                          (index) {
                                        return CategoryItemGridView(
                                            categoryEntity: controller
                                                .categories.data![index],
                                            onPressed: () =>
                                                _onActionGoToChooseService(
                                                    controller.categories
                                                        .data![index]));
                                      }),
                                    )
                                  : Text("Nenhuma categoria encontrada");
                            case Status.failed:
                              return PageError(
                                messageError:
                                    controller.categories.error?.message,
                                onPressed: controller.getAllCategories,
                              );
                            default:
                              return Center(child: CircularProgressCustom());
                          }
                        })
                      ]))
                ],
              ),
            ),
          ),
        ));
  }

  _onActionGoToSolicitationList() async {
    await Modular.to.pushNamed(RouteName.solicitationList);
    controller.checkSolicitations();
  }

  _onActionGoToChooseService(CategoryEntity category) async {
    await Modular.to.pushNamed(RouteName.chooseService, arguments: category);
    controller.checkSolicitations();
  }
}
