import 'package:Ineed/app/constants/route_name.dart';
import 'package:Ineed/app/styles/app_color_scheme.dart';
import 'package:Ineed/app/widgets/buttons/contained_button_widget.dart';
import 'package:Ineed/app/widgets/icons/icons_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Header extends StatelessWidget {
  final bool hasSolititation;
  final int totalSolicitation;
  final Function() onPressedButton;

  Header(
      {required this.hasSolititation,
      required this.totalSolicitation,
      required this.onPressedButton});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Align(
        alignment: Alignment.topCenter,
        child: Material(
            color: AppColorScheme.primaryColor,
            elevation: 6,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  height: hasSolititation ? 115 : 76,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 16),
                        child: Image.asset(
                          IconsUtils.logo_white,
                          height: 40,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
      if (hasSolititation)
        Align(alignment: Alignment.topCenter, child: _buildInfoSolicitations())
    ]);
  }

  _buildInfoSolicitations() => Padding(
        padding: const EdgeInsets.only(top: 56),
        child: Column(
          children: [
            Text(
              "Você tem solicitações \n em aberto",
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColorScheme.white),
            ),
            FloatingActionButton(
              backgroundColor: AppColorScheme.neutralDefault2,
              shape: CircleBorder(
                  side: BorderSide(
                      width: 4, color: AppColorScheme.primaryswatch)),
              mini: true,
              onPressed: () {},
              child: Text(
                "$totalSolicitation",
                style: TextStyle(fontSize: 26.h),
              ),
            ),
            ContainedButtonWidget(
                text: "Visualizar", onPressed: onPressedButton)
          ],
        ),
      );
}
