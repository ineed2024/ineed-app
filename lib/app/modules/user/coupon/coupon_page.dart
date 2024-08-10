import 'package:Ineed/app/styles/app_color_scheme.dart';
import 'package:Ineed/app/utils/ui_helper.dart';
import 'package:Ineed/app/widgets/buttons/contained_button_widget.dart';
import 'package:Ineed/app/widgets/inputs/upper_case_text_formatter.dart';
import 'package:Ineed/app/widgets/page_error/page_error.dart';
import 'package:Ineed/app/widgets/progress/circuclar_progress_custom.dart';
import 'package:Ineed/domain/entities/discount/discount_entity.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'coupon_controller.dart';

class CouponPage extends StatefulWidget {
  CouponPage({Key? key}) : super(key: key);

  @override
  _CouponPageState createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage> {
  final controller = CouponController();
  final _formKey = GlobalKey<FormState>();
  final _couponTextController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    controller.getCouponShare();
    controller.getAllCupons();
    super.initState();
  }

  void _onActionAddCoupon() async {
    final isAdd = await controller.addCoupon(_couponTextController.text);
    if (isAdd) {
      _showSnackBar('Curpom adicionado com sucesso');
      controller.getAllCupons();
    }
  }

  void _onActionActivateCoupon(DiscountEntity coupon) async {
    final isActivated = await controller.activateCupoun(coupon);
  }

  _showSnackBar(String message) => UIHelper.showInSnackBar(message, context);
  // _scaffoldKey.currentState.showSnackBar(SnackBar(
  //   content: Text(message),
  // ));

  void share(String code) async {
    // await FlutterShare.share(
    //     title: 'iNeed Service',
    //     text:
    //         'Utilize este código $code para ganhar desconto no aplicativo iNeed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Cupons'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Observer(
                builder: (_) => controller.resourceCouponShare?.status ==
                        Status.loading
                    ? SizedBox.shrink()
                    : Container(
                        width: double.maxFinite,
                        color: AppColorScheme.feedbackSuccessLight2,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                    'Compartilhe com seus amigos o cupom de desconto ${controller.resourceCouponShare.data!.code}'),
                              ),
                            ),
                            InkWell(
                                onTap: () => share(
                                    controller.resourceCouponShare.data!.code!),
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Text('Compartilhar'),
                                )),
                          ],
                        )),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Form(
                              key: _formKey,
                              child: Observer(
                                builder: (_) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                      inputFormatters: [
                                        UpperCaseTextFormatter()
                                      ],
                                      onChanged: (value) {
                                        controller
                                            .setEnableButton(value.isNotEmpty);
                                      },
                                      onFieldSubmitted: (value) {
                                        _onActionAddCoupon();
                                      },
                                      controller: _couponTextController,
                                      decoration: InputDecoration(
                                          labelText: 'Digite seu cupom'),
                                    ),
                                    if (controller.resourceAddCoupon?.status ==
                                        Status.failed)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                            controller.resourceAddCoupon.error!
                                                .message!,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: AppColorScheme
                                                    .feedbackDangerMedium)),
                                      )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Observer(
                          builder: (_) => ContainedButtonWidget(
                            onPressed: !controller.enableButton
                                ? null
                                : _onActionAddCoupon,
                            text: 'Adicionar',
                            loading: controller.resourceAddCoupon.status ==
                                Status.loading,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Seus cupons',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              // Flexible(
              //   fit: FlexFit.loose,
              //   child: Container(
              //     color: Colors.red,
              //     child: Text('deu certo'),
              //   ),
              // ),
              _buildListCoupon
            ],
          ),
        ));
  }

  get _buildListCoupon => Flexible(
        fit: FlexFit.loose,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Observer(builder: (_) {
            switch (controller.coupons.status) {
              case Status.success:
                return controller.coupons.data!.isEmpty
                    ? Center(
                        child: Text("Nenhum cupom encontrado"),
                      )
                    : ListView.separated(
                        primary: false,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.coupons.data!.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (ctx, index) => Card(
                          child: Container(
                            padding: EdgeInsets.all(12),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Text(
                                      'R\$ ${controller.coupons.data![index].discount} '),
                                ),
                                // Expanded(
                                //   child: Text(controller
                                //           .coupons.data[index].percentage
                                //       ? '${controller.coupons.data[index].discount}%'
                                //       : UIHelper.moneyFormat(controller
                                //           .coupons.data[index].discount
                                //           .toDouble())),
                                // ),
                                // InkWell(
                                //     onTap:
                                //         controller.coupons.data[index].activated
                                //             ? null
                                //             : () => _onActionActivateCoupon(
                                //                 controller.coupons.data[index]),
                                //     child: Padding(
                                //       padding: const EdgeInsets.all(12.0),
                                //       child: Text(
                                //         'Ativar',
                                //         style: TextStyle(
                                //             fontWeight: FontWeight.w600,
                                //             color: controller.coupons
                                //                     .data[index].activated
                                //                 ? AppColorScheme.neutralDefault2
                                //                 : AppColorScheme
                                //                     .feedbackSuccessDark2),
                                //       ),
                                //     ))
                              ],
                            ),
                          ),
                        ),
                        separatorBuilder: (context, index) => Divider(
                          height: 16.h,
                          color: Colors.transparent,
                        ),
                      );
              case Status.failed:
                return PageError(
                  messageError: controller.coupons.error?.message,
                  onPressed: controller.getAllCupons,
                );
              default:
                return Center(
                    child: Container(child: CircularProgressCustom()));
            }
          }),
        ),
      );
}
