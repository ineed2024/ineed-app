import 'package:Ineed/app/utils/validators.dart';
import 'package:Ineed/app/widgets/appbar/custom_app_bar.dart';
import 'package:Ineed/app/widgets/buttons/contained_button_widget.dart';
import 'package:Ineed/app/widgets/custom_alert_dialog/custom_alert_dialog.dart';
import 'package:Ineed/app/widgets/inputs/dropdown_button_field.widget.dart';
import 'package:Ineed/app/widgets/inputs/underline_text_field_widget.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'address_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final controller = AddressController();
  // Function onValidationSpepAddress;

  final _formKey = GlobalKey<FormState>();
  final _cepController = TextEditingController();
  final _addressController = TextEditingController();
  final _numberController = TextEditingController();
  final _complementController = TextEditingController();

  final FocusNode _cepFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _numberFocus = FocusNode();
  final FocusNode _complementFocus = FocusNode();
  final FocusNode _stateFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();

  _onActionUpdateAddress() async {
    if (_formKey.currentState!.validate()) {
      final result = await controller.onUpdateAddress(
          _cepController.text,
          _addressController.text,
          _numberController.text,
          _complementController.text,
          controller.uf!,
          controller.city!);
      if (result.status == Status.failed) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          CustomAlertDialog.error(context, result.error!.message!);
        });
        return;
      }
      Modular.to.pop(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        context,
        textTitle: "Endereço",
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildForm,
            Observer(builder: (_) {
              return Padding(
                padding: const EdgeInsets.only(
                    top: 26, right: 16, left: 16, bottom: 16),
                child: ContainedButtonWidget(
                    text: "Atualizar endereço",
                    loading: controller.resourceUser?.status == Status.loading,
                    onPressed: _onActionUpdateAddress),
              );
            }),
          ],
        ),
      ),
    );
  }

  get _buildForm => Expanded(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  UnderlineTextFieldWidget(
                    controller: _cepController,
                    validator: Validators.empty,
                    focusNode: _cepFocus,
                    labelText: "CEP",
                    hint: "00.000-000",
                    contentPadding: true,
                    inputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    onChanged: (value) async {
                      String newValue = value;
                      if (newValue.isNotEmpty && newValue.length == 8) {
                        final result =
                            await controller.consultAddressFromCEP(newValue);
                        if (result.status == Status.success &&
                            result.data != null) {
                          _addressController.text = result.data!.address!;
                          controller.setCity(result.data!.city!);
                          controller.setState(result.data!.uf!);
                          _numberFocus.requestFocus();
                        }
                      }
                    },
                    onSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_addressFocus);
                    },
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  UnderlineTextFieldWidget(
                    controller: _addressController,
                    validator: Validators.empty,
                    labelText: "Endereço",
                    hint: "Ex: Rua da Esperança",
                    contentPadding: true,
                    inputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    onSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_numberFocus);
                    },
                    maxLines: 1,
                    focusNode: _addressFocus,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: UnderlineTextFieldWidget(
                            validator: Validators.empty,
                            controller: _numberController,
                            focusNode: _numberFocus,
                            labelText: "Número",
                            hint: "Ex: 56 A",
                            contentPadding: true,
                            inputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            onSubmitted: (value) {
                              FocusScope.of(context)
                                  .requestFocus(_complementFocus);
                            },
                            maxLines: 1,
                          ),
                        ),
                        SizedBox(
                          width: 26.h,
                        ),
                        Expanded(
                          child: UnderlineTextFieldWidget(
                            controller: _complementController,
                            labelText: "Complemento",
                            hint: "Ex: Ap 567",
                            contentPadding: true,
                            focusNode: _complementFocus,
                            inputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            onSubmitted: (value) {
                              FocusScope.of(context).requestFocus(_stateFocus);
                            },
                            maxLines: 1,
                          ),
                        ),
                      ]),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Observer(
                          builder: (_) => DropdownButtonFieldWidget(
                            label: "Estado",
                            value: controller.uf != null
                                ? controller.listState
                                    .where((element) =>
                                        element.description == controller.uf)
                                    .first
                                    .value
                                : null,
                            hint: controller.uf == null
                                ? 'Selecione'
                                : controller.uf!,
                            list: controller.listState,
                            focusNode: _stateFocus,
                            onChanged: (value) {
                              final valueFromList = controller.listState
                                  .firstWhere(
                                      (element) => element.value == value);
                              if (valueFromList != null)
                                controller.setState(valueFromList.description);
                              FocusScope.of(context).requestFocus(_cityFocus);
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 26.w,
                      ),
                      Expanded(
                        child: Observer(
                            builder: (_) => DropdownButtonFieldWidget(
                                  hint: controller.city == null
                                      ? 'Selecione'
                                      : controller.city!,
                                  label: "Cidade",
                                  value: controller.city != null
                                      ? controller.listCity
                                          .where((element) =>
                                              element.description ==
                                              controller.city)
                                          .first
                                          .value
                                      : null,
                                  list: controller.listCity,
                                  focusNode: _cityFocus,
                                  onChanged: (value) {
                                    final valueFromList = controller.listCity
                                        .firstWhere((element) =>
                                            element.value == value);
                                    if (valueFromList != null)
                                      controller
                                          .setCity(valueFromList.description);
                                    FocusScope.of(context).unfocus();
                                  },
                                )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
