import 'package:Ineed/app/constants/route_name.dart';
import 'package:Ineed/app/styles/app_color_scheme.dart';
import 'package:Ineed/app/utils/ui_helper.dart';
import 'package:Ineed/app/widgets/appbar/custom_app_bar.dart';
import 'package:Ineed/app/widgets/custom_alert_dialog/custom_alert_dialog.dart';
import 'package:Ineed/app/widgets/progress/circuclar_progress_custom.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:Ineed/app/modules/dashboard/menu/menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

enum FieldEnum { email, phonenumber, cpfCnpj }

class MenuPage extends StatefulWidget {
  final String title;
  const MenuPage({Key? key, this.title = "Menu"}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  //use 'controller' variable to access controller,

  final controller = MenuAppController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _onActionEmail() async {
    final result = await Modular.to
        .pushNamed(RouteName.userUpdateField, arguments: 'email');
    if (result != null) {
      _showSnackBar('Email atualizado com sucesso');
    }
  }

  _onActionCpfCnpj() async {
    final result = await Modular.to
        .pushNamed(RouteName.userUpdateField, arguments: 'cpfCnpj');
    if (result != null) {
      _showSnackBar('CPF/CNPJ atualizado com sucesso');
    }
  }

  _onActionUpdatePassword() => Modular.to.pushNamed(RouteName.updatePassword);

  _onActionPhonenumber() async {
    final result = await Modular.to
        .pushNamed(RouteName.userUpdateField, arguments: 'phone');
    if (result != null) {
      _showSnackBar('Celular atualizado com sucesso');
    }
  }

  _showSnackBar(String message) =>
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        UIHelper.showInSnackBar(message, context);
        // _scaffoldKey.currentState!.showSnackBar(SnackBar(
        //   content: Text(message),
        // ));
      });

  _onActionCards() async {
    Modular.to.pushNamed(RouteName.cards);
  }

  _onActionAddress() async {
    final result = await Modular.to.pushNamed(RouteName.userAddress);
    if (result != null) {}
  }

  _onActionSolicitations() => Modular.to.pushNamed(RouteName.solicitationList);

  _onActionLogout() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      CustomAlertDialog.question(context,
          title: 'Sair',
          message: 'Tem certeza que deseja sair?',
          onActionNegativeButton: () {}, onActionPositiveButton: () async {
        final result = await controller.logout();
        if (result.status == Status.success) {
          Modular.to.popAndPushNamed(RouteName.login);
        }
      });
    });
  }

  final Uri _url = Uri.parse('https://ineed2024.github.io/');

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  _onActionCoupon() => Modular.to.pushNamed(RouteName.coupon);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarCustom(
        context,
        elevation: 0,
        title: Text("Menu"),
      ),
      body: SafeArea(
          child: Center(
        child: Container(
          child: Observer(
            builder: (_) => controller.resourceData.status == Status.loading
                ? CircularProgressCustom()
                : Column(
                    children: [
                      Expanded(
                        child: ListView(children: [
                          buildListTileBlack(Icons.password, 'Alterar Senha',
                              _onActionUpdatePassword),
                          buildListTileBlack(
                              Icons.person, 'CPF/CNPJ', _onActionCpfCnpj),
                          buildListTileBlack(
                              Icons.phone, 'Telefone', _onActionPhonenumber),
                          buildListTileBlack(Icons.location_city, 'Endereço',
                              _onActionAddress),
                          buildListTileBlack(
                              Icons.card_giftcard, 'Cartões', _onActionCards),
                          buildListTileBlack(Icons.file_open, 'Solicitações',
                              _onActionSolicitations),
                          buildListTileBlack(
                              Icons.money, 'Cupom', _onActionCoupon),
                        ]),
                      ),
                      ListTile(
                        onTap: () => _launchUrl(_url),
                        leading: Icon(Icons.view_list,
                            color: AppColorScheme.feedbackWarningDark2),
                        title: Text('Politica de Privacidade',
                            style: TextStyle(
                                fontSize: 30.w,
                                fontWeight: FontWeight.w600,
                                color: AppColorScheme.feedbackWarningDark2)),
                      ),
                      ListTile(
                        onTap: _onActionLogout,
                        leading: Icon(Icons.logout_rounded,
                            // FlutterIcons.logout_mco,
                            color: AppColorScheme.feedbackDangerDark),
                        title: Text('Sair',
                            style: TextStyle(
                                fontSize: 30.w,
                                fontWeight: FontWeight.w600,
                                color: AppColorScheme.feedbackDangerDark)),
                      )
                    ],
                  ),
          ),
        ),
      )),
    );
  }

  ListTile buildListTileBlack(icon, label, onTap) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: AppColorScheme.black),
      title: Text(label,
          style: TextStyle(fontSize: 30.w, fontWeight: FontWeight.w600)),
      trailing: Icon(Icons.chevron_right, color: AppColorScheme.black),
    );
  }
}
