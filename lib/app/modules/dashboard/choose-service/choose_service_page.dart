import 'package:Ineed/app/constants/route_name.dart';
import 'package:Ineed/app/modules/dashboard/choose-service/choose_service_controller.dart';
import 'package:Ineed/app/modules/dashboard/choose-service/components/header.dart';
import 'package:Ineed/app/widgets/appbar/custom_app_bar.dart';
import 'package:Ineed/app/widgets/buttons/contained_button_widget.dart';
import 'package:Ineed/app/widgets/page_error/page_error.dart';
import 'package:Ineed/app/widgets/progress/circuclar_progress_custom.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../domain/entities/service/category_entity.dart';
import '../../../../domain/entities/service/service_entity.dart';

class ChooseServicePage extends StatefulWidget {
  final CategoryEntity categoryEntity;
  const ChooseServicePage({
    Key? key,
    required this.categoryEntity,
  }) : super(key: key);

  @override
  _ChooseServicePageState createState() => _ChooseServicePageState();
}

class _ChooseServicePageState extends State<ChooseServicePage> {
  final controller = ChooseServiceController();

  @override
  void initState() {
    controller.getAllServicesFromCategory(widget.categoryEntity.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        context,
        elevation: 0,
      ),
      body: Column(
        children: [
          Header(categoryEntity: widget.categoryEntity),
          Expanded(
            child: Container(
              child: Observer(builder: (_) {
                switch (controller.resourceServices.status) {
                  case Status.success:
                    return controller.resourceServices.data!.isEmpty
                        ? Text("Nenhum serviço encontrado")
                        : Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: ListView.separated(
                                    itemCount: controller
                                        .resourceServices.data!.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      return Material(
                                        elevation: 4,
                                        child: CheckboxListTile(
                                            title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      controller
                                                          .resourceServices
                                                          .data![index]
                                                          .data
                                                          .title,
                                                      style: TextStyle(
                                                          fontSize: 30.w,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                  Text(
                                                      controller
                                                          .resourceServices
                                                          .data![index]
                                                          .data
                                                          .description,
                                                      style: TextStyle(
                                                          fontSize: 24.w,
                                                          fontWeight:
                                                              FontWeight.w400))
                                                ]),
                                            value: controller.resourceServices
                                                .data![index].isSelected,
                                            onChanged: (newValue) => {
                                                  controller.onSelectedListItem(
                                                      newValue!, index),
                                                  setState(() {}),
                                                }),
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        Divider(
                                      height: 16.h,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: Observer(
                                        builder: (_) => ContainedButtonWidget(
                                              text: "Continuar",
                                              onPressed: controller
                                                          .statusButton ==
                                                      Status.success
                                                  ? () =>
                                                      _onActionGoToCreateSolicitation()
                                                  : null,
                                            )))
                              ],
                            ),
                          );
                  case Status.failed:
                    return PageError(
                        messageError:
                            controller.resourceServices.error?.message,
                        onPressed: () => controller.getAllServicesFromCategory(
                            widget.categoryEntity.id!));
                  default:
                    return Center(child: CircularProgressCustom());
                }
              }),
            ),
          )
        ],
      ),
    );
  }

  _onActionGoToCreateSolicitation() async {
    List<ServiceEntity> listServices = [];
    // listServices = controller.resourceServices.data!
    //     .where((element) =>
    //         {if (element.isSelected) listServices.add(element.data)})
    //     .toList();
    //  controller.resourceServices.data!
    //     .map((e) => {if (e.isSelected) listServices.add(e.data)});

    for (var element in controller.resourceServices.data!) {
      if (element.isSelected) {
        listServices.add(element.data);
      }
    }

    Modular.to.pushNamed(RouteName.solicitationCreate, arguments: {
      'category': widget.categoryEntity,
      'listServices': listServices
    });
  }
}
