import 'package:Ineed/app/utils/ui_helper.dart';
import 'package:Ineed/app/utils/validators.dart';
import 'package:Ineed/app/widgets/buttons/contained_button_widget.dart';
import 'package:Ineed/app/widgets/custom_alert_dialog/custom_alert_dialog.dart';
import 'package:Ineed/app/widgets/inputs/underline_text_field_widget.dart';
import 'package:Ineed/app/widgets/progress/circuclar_progress_custom.dart';
import 'package:Ineed/domain/entities/user/user_entity.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'update_field_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum FieldEnum { email, phonenumber, cpfCnpj }

class UpdateFieldPage extends StatefulWidget {
  final String type;
  const UpdateFieldPage({Key? key, required this.type}) : super(key: key);

  @override
  _UpdateFieldPageState createState() => _UpdateFieldPageState();
}

class _UpdateFieldPageState extends State<UpdateFieldPage> {
  final controller = UpdateFieldController();
  final _formKey = GlobalKey<FormState>();
  final _inputController = TextEditingController();

  @override
  void initState() {
    controller.getProfileUser();
    super.initState();
  }

  void _onActionUpdateField() async {
    if (_formKey.currentState!.validate()) {
      final result =
          await controller.updateField(widget.type, _inputController.text);
      if (result!.status == Status.success)
        Modular.to.pop(result);
      else {
        UIHelper.showInSnackBar(result.error!.message!, context);
      }
    }
  }

  void _onChangeForm() {
    controller.validateForm(_formKey.currentState!.validate());
  }

  String _getTitle() {
    switch (widget.type) {
      case 'email':
        return 'Atualizar email';
      case 'phone':
        return 'Atualizar telefone';
      case 'cpfCnpj':
        return 'Atualizar CPF/CNPJ';
      default:
        return '';
    }
  }

  String? _getValidator(String? value) {
    switch (widget.type) {
      case 'email':
        return Validators.email(value!);
      case 'phone':
        return Validators.phone(value);
      case 'cpfCnpj':
        return Validators.validadeDoc(value);
      default:
        return '';
    }
  }

  String _getHint() {
    switch (widget.type) {
      case 'email':
        return 'Ex: email@exemplo.com';
      case 'phone':
        return 'Ex: (00) 0 0000-0000';
      case 'cpfCnpj':
        return 'Ex: 000.000.000-00';
      default:
        return '';
    }
  }

  String _getLabel() {
    switch (widget.type) {
      case 'email':
        return 'Email';
      case 'phone':
        return 'Celular';
      case 'cpfCnpj':
        return 'CPF/CNPJ';
      default:
        return '';
    }
  }

  TextInputType _getKeyboardType() {
    switch (widget.type) {
      case 'email':
        return TextInputType.emailAddress;
      case 'phone':
        return TextInputType.number;
      case 'cpfCnpj':
        return TextInputType.number;
      default:
        return TextInputType.text;
    }
  }

  List<TextInputFormatter> _getInputFormatters() {
    switch (widget.type) {
      case 'email':
        return [];
      case 'phone':
        return [TextInputMask(mask: '(99) 9 9999-9999')];
      case 'cpfCnpj':
        return [
          TextInputMask(mask: ['999.999.999-99', '99.999.999/9999-99'])
        ];
      default:
        return [];
    }
  }

  _setInitialValueInput(UserEntity userEntity) {
    switch (widget.type) {
      case 'email':
        _inputController.text = userEntity.email ?? '';
        break;
      case 'phone':
        _inputController.text = userEntity.phonenumber ?? '';
        break;
      case 'cpfCnpj':
        _inputController.text = userEntity.cpfCnpj ?? '';
        break;
      default:
        _inputController.text = '';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle()),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Observer(builder: (_) {
          if (controller.resourceProfileUser.status == Status.loading)
            return Center(child: CircularProgressCustom());
          else {
            _setInitialValueInput(controller.resourceProfileUser.data!);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Form(
                  key: _formKey,
                  onChanged: _onChangeForm,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: UnderlineTextFieldWidget(
                    keyboardType: _getKeyboardType(),
                    controller: _inputController,
                    labelText: _getLabel(),
                    hint: _getHint(),
                    validator: _getValidator,
                    autofocus: true,
                    inputFormatters: _getInputFormatters(),
                  ),
                ),
                SizedBox(
                  height: 26.w,
                ),
                Observer(builder: (_) {
                  return ContainedButtonWidget(
                      text: "Salvar",
                      loading:
                          controller.resourceUser?.status == Status.loading,
                      onPressed:
                          controller.isFormValid ? _onActionUpdateField : null);
                })
              ],
            );
          }
        }),
      ),
    );
  }
}
