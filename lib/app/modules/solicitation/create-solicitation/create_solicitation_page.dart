import 'dart:io';

import 'package:Ineed/app/constants/route_name.dart';
import 'package:Ineed/app/styles/app_color_scheme.dart';
import 'package:Ineed/app/utils/ui_helper.dart';
import 'package:Ineed/app/utils/validators.dart';
import 'package:Ineed/app/widgets/buttons/contained_button_widget.dart';
import 'package:Ineed/app/widgets/custom_alert_dialog/custom_alert_dialog.dart';
import 'package:Ineed/app/widgets/inputs/underline_text_field_widget.dart';
import 'package:Ineed/app/widgets/progress/circuclar_progress_custom.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:time_picker_widget/time_picker_widget.dart';
import '../../../../domain/entities/dropdown/dropdown_item.dart';
import '../../../../domain/entities/service/category_entity.dart';
import '../../../../domain/entities/service/service_entity.dart';
import '../../../widgets/inputs/dropdown_button_field.widget.dart';
import 'create_solicitation_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateSolicitationPage extends StatefulWidget {
  final CategoryEntity category;
  final List<ServiceEntity> listServices;
  const CreateSolicitationPage(
      {Key? key, required this.category, required this.listServices})
      : super(key: key);

  @override
  _CreateSolicitationPageState createState() => _CreateSolicitationPageState();
}

class _CreateSolicitationPageState extends State<CreateSolicitationPage> {
  //use 'controller' variable to access controller

  final controller = CreateSolicitationController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();

  final _observationController = TextEditingController();
  final _cpfController = TextEditingController();
  final _cellphoneController = TextEditingController();

  final picker = ImagePicker();

  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final spaceBetweenAreas = SizedBox(
      height: 16.h,
    );
    final spaceBottomOptions = SizedBox(
      height: 26.h,
    );
    final spaceWidthSelector = SizedBox(
      width: 26.w,
    );
    final spaceBottomTitle = SizedBox(
      height: 16.h,
    );
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Criar solicitação"),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          child: Center(
            child: Observer(
              builder: (_) => controller.resourceConfiguration?.status ==
                          Status.loading ||
                      controller.resourceUser?.status == Status.loading
                  ? CircularProgressCustom()
                  : SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        onChanged: onChangeForm,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            _buildHeader(),
                            spaceBetweenAreas,
                            Container(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    _buildAddress(spaceBottomTitle,
                                        spaceWidthSelector, spaceBottomOptions),
                                    spaceBetweenAreas,
                                    _buildDateAndTime(spaceBottomTitle,
                                        spaceWidthSelector, spaceBottomOptions),
                                    spaceBetweenAreas,
                                    _buildOptions(spaceWidthSelector),
                                    spaceBetweenAreas,
                                    _buildObservation(),
                                    spaceBetweenAreas,
                                    _buildContact(spaceBottomTitle,
                                        spaceWidthSelector, spaceBottomOptions),
                                    spaceBetweenAreas,
                                    _buildGridViewImages(
                                        spaceBottomOptions, context),
                                    spaceBetweenAreas,
                                    _buildButton(),
                                    spaceBetweenAreas,
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  _onActionCameraOptions(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  // leading: new Icon(FlutterIcons.camera_ant),
                  leading: new Icon(Icons.camera),
                  title: new Text('Tirar foto'),
                  onTap: () {
                    Navigator.pop(context);
                    getImage(ImageSource.camera);
                  },
                ),
                ListTile(
                    // leading: new Icon(FlutterIcons.image_album_mco),
                    leading: new Icon(Icons.album),
                    title: new Text('Galeria'),
                    onTap: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    }),
              ],
            ),
          );
        });
  }

  _onActionImage(int index) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    // leading: new Icon(FlutterIcons.delete_ant),
                    leading: new Icon(Icons.delete_outlined),
                    title: new Text('Excluir imagem'),
                    onTap: () {
                      Navigator.pop(context);
                      controller.removeImage(index);
                    }),
              ],
            ),
          );
        });
  }

  getImage(ImageSource src) async {
    final pickedFile = await picker.getImage(source: src, imageQuality: 60);
    if (pickedFile != null) {
      controller.addImage(File(pickedFile.path));
    }
  }

  // onActionChangeAddress() async {
  //   final result = await Modular.to.pushNamed(RouteName.userAddress);
  //   if (result != null) {
  //     controller.updateAddress(result);
  //   }
  // }

  onActionDate() async {
    DateTime? date = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDate: DateTime.now());
    final difference = date!.difference(DateTime.now()).inHours;
    if (difference <= 24)
      onActionChangeUrgent(true);
    else
      onActionChangeUrgent(false);
    controller.changeDate(date);
  }

  onActionStartTime() async {
    TimeOfDay initialTime;
    if (controller.date!.difference(DateTime.now()).inHours < 24) {
      // mesmo dia
      initialTime = TimeOfDay(hour: TimeOfDay.now().hour + 1, minute: 00);
    } else
      initialTime = TimeOfDay(hour: 0, minute: 0);
    TimeOfDay? startTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    // TimeOfDay? startTime = await showCustomTimePicker(

    //   context: context,
    //   initialTime: initialTime,
    //   selectableTimePredicate: _decideWhichTimeToEnableStartTime,
    //   onFailValidation: (context) => print('Unavailable selection.'),
    // );
    controller.changeStartTime(startTime!);
  }

  _showSnackBar(String message) =>
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        UIHelper.showInSnackBar(message, context);
        // _scaffoldKey.currentState.showSnackBar(SnackBar(
        //   content: Text(message),
        // ));
      });

  onActionEndTime() async {
    TimeOfDay? endTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: controller.startTime!.hour + 1, minute: 00),
    );
    // showCustomTimePicker(
    //   context: context,
    //   initialTime: TimeOfDay(hour: controller.startTime!.hour + 1, minute: 00),
    //   selectableTimePredicate: _decideWhichTimeToEnableEndTime,
    //   onFailValidation: (context) => print('Unavailable selection.'),
    // );
    controller.changeEndTime(endTime!);
  }

  bool _decideWhichTimeToEnableStartTime(TimeOfDay? time) {
    if (controller.date!.difference(DateTime.now()).inHours < 24) {
      if (time!.hour > DateTime.now().hour) {
        return true;
      }
      return false;
    }
    return true;
  }

  bool _decideWhichTimeToEnableEndTime(TimeOfDay? time) {
    if (time!.hour > controller.startTime!.hour) {
      return true;
    }
    return false;
  }

  onActionChangeUrgent(bool value) {
    // TODO: nao vamos mais fazer isso
    // verificar se o usuario tem cartao de credito cadastrado
    // se não tiver, levar para tela pra cadastrar
    // e incluir o id do cartao na solicitacao, eu acho.
    controller.urgent = value;

    if (value) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        CustomAlertDialog.info(
          context,
          'Atendimento urgente',
          'Visitas agendadas para um período inferior a 24 horas recebem uma taxa extra de urgência no valor de ${UIHelper.moneyFormat(controller.resourceConfiguration.data!.urgentVisitsRate!)} pagas na confirmação do agendamento.',
        );
      });
    }
  }

  onActionCustomerSuppliesMaterial(bool value) {
    controller.customerSuppliesMaterial = value;
    if (value) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        CustomAlertDialog.info(
          context,
          'Cliente fornecendo o material',
          'O iNeed não se responsabiliza por materiais fornecidos por terceiros',
        );
      });
    }
  }

  onChangeTypeAddress(int? typeAddress) {
    controller.changeTypeAddress(typeAddress!);
  }

  onChangeObservation(String value) {
    controller.changeObservation(value);
  }

  onChangeCpfOrCnpj(String value) {
    controller.changeCpfOrCnpj(value);
  }

  onChangePhonenumber(String value) {
    controller.onChangePhonenumber(value);
  }

  Observer _buildButton() => Observer(
        builder: (_) => ContainedButtonWidget(
            // onPressed: controller.isValid ? onActionCreateSolicitation : null,
            onPressed: () => onActionCreateSolicitation(),
            text: "Criar solicitação",
            loading: controller.resourceSolicitation.status == Status.loading),
      );

  onActionCreateSolicitation() async {
    if (controller.isValid) {
      final resource = await controller.createSolicitation(
          widget.category, widget.listServices);

      if (resource.status == Status.failed) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          CustomAlertDialog.error(context, resource.error!.message!);
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          CustomAlertDialog.success(
              context: context,
              title: 'Criar solicitação',
              message: resource.message!,
              onActionButton: () {
                Modular.to.popUntil(ModalRoute.withName(RouteName.dashboard));
                Modular.to.pushNamed(RouteName.solicitationDetail,
                    arguments: resource.data!.id);
              });
        });
      }
    } else {
      _checkInfor();
    }
  }

  _checkInfor() {
    controller.startTime == null
        ? _showSnackBar('Campo Horário Inicial precisa ser preenchido')
        : null;

    controller.endTime == null
        ? _showSnackBar('Campo Horario Final precisa ser preenchido')
        : null;

    controller.typeAddress == null
        ? _showSnackBar('Campo Tipo de Endereço precisa ser preenchido')
        : null;
  }

  onChangeForm() {
    controller.changeFormIsValid(_formKey.currentState!.validate());
  }

  Widget _buildGridViewImages(
      SizedBox spaceBottomOptions, BuildContext context) {
    return _buildArea(
      title: "Anexo",
      subtitle: "Envie imagens para ajudar na sua solicitação",
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Observer(
                builder: (_) => GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 50.w / 50.h,
                      children:
                          List.generate(controller.images.length + 1, (index) {
                        if (index == controller.images.length)
                          return IconButton(
                              onPressed: () => _onActionCameraOptions(context),
                              icon: Icon(
                                // FlutterIcons.add_a_photo_mdi,
                                Icons.photo_camera,
                                color: AppColorScheme.primaryColor,
                              ));
                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: InkWell(
                            onTap: () {
                              _onActionImage(index);
                            },
                            child: Image.file(
                              controller.images[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }),
                    )),
          ]),
    );
  }

  Widget _buildObservation() => _buildArea(
        child: UnderlineTextFieldWidget(
          contentPadding: false,
          controller: _observationController,
          onChanged: onChangeObservation,
          maxLines: 5,
          hint: "Deixe uma observação aqui",
        ),
      );

  _buildRowTwoWidgets(Widget left, Widget right) => Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Align(alignment: Alignment.centerLeft, child: left)),
            Expanded(
                flex: 1,
                child: Align(alignment: Alignment.centerRight, child: right))
          ],
        ),
      );

  Widget _buildOptions(SizedBox spaceWidthSelector) {
    return _buildArea(
      title: 'Localização',
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _buildRowTwoWidgets(
            Text(
              "Cliente fornecendo o material",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColorScheme.neutralMedium3),
            ),
            Observer(
                builder: (_) => Container(
                      child: Switch(
                          value: controller.customerSuppliesMaterial,
                          onChanged: onActionCustomerSuppliesMaterial),
                    ))),
        _buildRowTwoWidgets(
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Atendimento urgente",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColorScheme.neutralMedium3),
              ),
              Observer(
                  builder: (_) => controller.urgent
                      ? Text(
                          "Adicional de ${UIHelper.moneyFormat(controller.resourceConfiguration.data!.urgentVisitsRate!)}",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 22.w,
                              color: AppColorScheme.feedbackDangerDark))
                      : SizedBox.shrink()),
            ]),
            Observer(
              builder: (_) => Container(
                child: Switch(
                  value: controller.urgent,
                  onChanged: null,
                  activeTrackColor: AppColorScheme.primaryColor,
                ),
              ),
            )),
      ]),
    );
  }

  Widget _buildDateAndTime(SizedBox spaceBottomTitle,
      SizedBox spaceWidthSelector, SizedBox spaceBottomOptions) {
    return _buildArea(
      title: "Quero ser visitado em:",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: onActionDate,
              child: _buildRowTwoWidgets(
                  Text(
                    "Data",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColorScheme.neutralMedium3),
                  ),
                  Observer(
                    builder: (_) => Text(
                      controller.date == null
                          ? "Informe a data"
                          : UIHelper.formatDateFromDateTime(controller.date!),
                      textAlign: TextAlign.end,
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                  ))),
          Observer(
              builder: (_) => controller.date == null
                  ? SizedBox.shrink()
                  : spaceBottomOptions),
          Observer(
            builder: (_) => controller.date == null
                ? SizedBox.shrink()
                : InkWell(
                    onTap: onActionStartTime,
                    child: _buildRowTwoWidgets(
                        Observer(
                          builder: (_) => Text(
                            controller.startTime == null
                                ? "Informe o horário"
                                : UIHelper.formatTimeFromTimeOfDay(
                                    controller.startTime!),
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Text(
                          "Horário inicial",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: AppColorScheme.neutralMedium3),
                        )),
                  ),
          ),
          Observer(
              builder: (_) => controller.startTime == null
                  ? SizedBox.shrink()
                  : spaceBottomOptions),
          Observer(
            builder: (_) => controller.startTime == null
                ? SizedBox.shrink()
                : InkWell(
                    onTap: onActionEndTime,
                    child: _buildRowTwoWidgets(
                        Text(
                          "Horário final",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: AppColorScheme.neutralMedium3),
                        ),
                        Observer(
                          builder: (_) => Text(
                            controller.endTime == null
                                ? "Informe o horário"
                                : UIHelper.formatTimeFromTimeOfDay(
                                    controller.endTime!),
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ))),
          )
        ],
      ),
    );
  }

  Widget _buildAddress(SizedBox spaceBottomTitle, SizedBox spaceWidthSelector,
      SizedBox spaceBottomOptions) {
    return _buildArea(
      title: 'Localização',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => print(''),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Endereço",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColorScheme.neutralMedium3),
                  ),
                  spaceWidthSelector,
                  Observer(
                      builder: (_) => Flexible(
                            child: Text(
                              controller.address ?? 'Informe o endereço',
                              maxLines: 2,
                              textAlign: TextAlign.end,
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                          )),
                ],
              ),
            ),
          ),
          spaceBottomOptions,
          DropdownButtonFieldWidget(
            label: "Tipo de endereço",
            hint: "Selecione",
            list: [
              DropdownItem(value: 1, description: "Apartamento"),
              DropdownItem(value: 2, description: "Casa"),
              DropdownItem(value: 3, description: "Ponto comercial")
            ],
            onChanged: onChangeTypeAddress,
            contentPadding: false,
          )
        ],
      ),
    );
  }

  Widget _buildArea({required Widget child, String? title, String? subtitle}) =>
      Card(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Text(
                title,
                style: TextStyle(
                    fontSize: 32.w,
                    fontWeight: FontWeight.w600,
                    color: AppColorScheme.primaryColor),
              ),
            if (subtitle != null)
              Text(
                subtitle,
                style: TextStyle(
                    fontSize: 26.w,
                    fontWeight: FontWeight.w400,
                    color: AppColorScheme.black),
              ),
            SizedBox(
              height: 12.h,
            ),
            child
          ],
        ),
      ));

  Widget _buildContact(SizedBox spaceBottomTitle, SizedBox spaceWidthSelector,
      SizedBox spaceBottomOptions) {
    return _buildArea(
      title: 'Contato',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRowTwoWidgets(
              Text(
                "Celular",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColorScheme.neutralMedium3),
              ), Observer(builder: (_) {
            if (controller.isUserPhonenumber()) {
              _cellphoneController.text =
                  controller.resourceUser.status == Status.success
                      ? controller.resourceUser.data!.phonenumber!
                      : '';
            }
            return UnderlineTextFieldWidget(
              controller: _cellphoneController,
              maxLines: 1,
              contentPadding: false,
              inputFormatters: [TextInputMask(mask: '(99) 9 9999-9999')],
              enabled: !controller.isUserPhonenumber(),
              readOnly: controller.isUserPhonenumber(),
              initialValue: controller.isUserPhonenumber()
                  ? controller.resourceUser.data?.phonenumber
                  : '',
              onChanged: onChangePhonenumber,
              hint: "(00) 0 0000-000",
              keyboardType: TextInputType.number,
              validator: Validators.phone,
              textAlign: TextAlign.end,
            );
          })),
          _buildRowTwoWidgets(
            Text(
              "CPF/CNPJ",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColorScheme.neutralMedium3),
            ),
            Observer(
              builder: (_) {
                if (controller.isUserCPFOrCNPJ()) {
                  _cpfController.text =
                      controller.resourceUser.status == Status.success
                          ? controller.resourceUser.data!.cpfCnpj!
                          : '';
                }
                return UnderlineTextFieldWidget(
                  controller: _cpfController,
                  maxLines: 1,
                  enabled: !controller.isUserCPFOrCNPJ(),
                  contentPadding: false,
                  initialValue: controller.isUserCPFOrCNPJ()
                      ? controller.resourceUser.data!.cpfCnpj
                      : '',
                  readOnly: controller.isUserCPFOrCNPJ(),
                  onChanged: onChangeCpfOrCnpj,
                  inputFormatters: [
                    TextInputMask(
                        mask: ['999.999.999-99', '99.999.999/9999-99'])
                  ],
                  hint: "000.000.000-00",
                  keyboardType: TextInputType.number,
                  validator: Validators.validadeDoc,
                  textAlign: TextAlign.end,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Container _buildHeader() => Container(
        color: AppColorScheme.primaryColor50,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/icons-category/imagem/${widget.category.image}',
              height: 80,
              width: 80,
            ),
            SizedBox(
              width: 16.w,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.category.title!,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 36.w,
                        color: AppColorScheme.primaryColor,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      )),
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: widget.listServices.length,
                    itemBuilder: (context, index) => Container(
                      padding: const EdgeInsets.all(1),
                      child: Text(widget.listServices[index].title!,
                          style: TextStyle(fontSize: 20.w)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
}
