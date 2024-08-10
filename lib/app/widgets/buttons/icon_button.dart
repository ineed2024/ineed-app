import 'package:Ineed/app/widgets/progress/circuclar_progress_custom.dart';
import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final String icon;
  final Function() onPressed;
  final bool loading;
  IconButtonWidget(
      {required this.icon, required this.onPressed, this.loading: false});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      child: loading
          ? CircularProgressCustom()
          : IconButton(
              icon: Image.asset(
                icon,
                height: 50,
              ),
              onPressed: loading ? null : onPressed,
            ),
    );
  }
}
