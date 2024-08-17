import 'package:Ineed/app/constants/evaluation_type.dart';
import 'package:Ineed/app/modules/evaluation/evaluation_controller.dart';
import 'package:Ineed/app/styles/app_color_scheme.dart';
import 'package:Ineed/app/widgets/buttons/contained_button_widget.dart';
import 'package:Ineed/app/widgets/custom_alert_dialog/custom_alert_dialog.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EvaluationPageArgs {
  final EvaluationOptions option;
  final String image;
  final int idObject;
  final String title;

  EvaluationPageArgs(
      {required this.option,
      required this.image,
      required this.idObject,
      required this.title})
      : assert(option != null, image != null);
}

class EvaluationPage extends StatefulWidget {
  final EvaluationPageArgs args;

  const EvaluationPage({required this.args}) : assert(args != null);
  @override
  _EvaluationPageState createState() => _EvaluationPageState();
}

class _EvaluationPageState
    extends ModularState<EvaluationPage, EvaluationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.args.option.titleToolbar()),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                        'assets/images/icons-category/imagem/${widget.args.image}',
                        height: 300.h,
                        width: 300.w,
                        alignment: Alignment.center,
                        fit: BoxFit.cover),
                    Text(
                      widget.args.title,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Text(
                      widget.args.option.messageEvalution(),
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: RatingBar.builder(
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(Icons.star,
                            color: AppColorScheme.primaryColor),
                        onRatingUpdate: (rating) {
                          controller.setRating(rating);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              _buildButton()
            ],
          ),
        ),
      ),
    );
  }

  Observer _buildButton() => Observer(
        builder: (_) => ContainedButtonWidget(
            onPressed: controller.rating > 0 ? onActionEvaluation : null,
            text: "Avaliar",
            loading: controller.resourceEvaluation.status == Status.loading),
      );

  onActionEvaluation() async {
    final status =
        await controller.evaluation(widget.args.option, widget.args.idObject);
    if (status == Status.success) {
      Modular.to.pop(true);
    } else {
      CustomAlertDialog.info(context, 'Avaliação',
          'Não foi possível avaliar, tente novamente mais tarde.', null);
    }
  }
}
