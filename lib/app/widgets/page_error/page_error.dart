import 'package:Ineed/app/styles/app_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageError extends StatelessWidget {
  final String? messageError;
  final Function()? onPressed;
  const PageError({super.key, this.messageError, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding:
            const EdgeInsets.only(top: 16, left: 32, right: 21, bottom: 16),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(messageError != null ? messageError! : 'Erro na requisição',
                  textAlign: TextAlign.center),
              SizedBox(
                height: 16.h,
              ),
              TextButton(
                  onPressed: onPressed,
                  child: const Text(
                    'Tentar novamente',
                    style: TextStyle(color: AppColorScheme.primaryColor),
                  ))
              // ElevatedButton(
              //     onPressed: () => onPressed(),
              //     child: Text('Tentar Novemante '))
            ]),
      ),
    );
  }
}
