import 'dart:async';

import 'package:Ineed/data/local/shared_preferences.dart';
import 'package:Ineed/di/di.dart';
import 'package:flutter/material.dart';

import '../../constants/route_name.dart';
import '../../styles/app_images.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  bool loading = true;

  @override
  void initState() {
    isUserLogged();
    super.initState();
  }

  Future<void> isUserLogged() async {
    final sharedPreferences = getIt.get<SharedPreferencesManager>();

    Timer(const Duration(seconds: 1), () async {
      String? token =
          await sharedPreferences.getString(SharedPreferencesManager.token);
      if (token != null && token.isNotEmpty) {
        Navigator.popAndPushNamed(context, RouteName.dashboard);
      } else {
        Navigator.popAndPushNamed(context, RouteName.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final flexHeader = 25;
    final flexContent = 68;
    final flexFooter = 12;
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraint) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
                child: Container(
              color: Colors.white,
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * .6,
                  width: MediaQuery.of(context).size.width * .6,
                  child: Image.asset(AppImages.logo),
                ),
              ),
            )),
          ),
        );
      }),
    );
  }
}
