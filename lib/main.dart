import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Ineed/app/app_module.dart';

import 'app/app_widget.dart';
import 'di/di.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initilizerInjection();

  return runApp(
    ScreenUtilInit(
        designSize: const Size(750, 1334),
        builder: (context, child) {
          return ModularApp(
            module: AppModule(),
            child: const AppWidget(),
          );
        }),
  );
}
