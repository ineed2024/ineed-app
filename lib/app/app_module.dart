import 'package:Ineed/app/modules/dashboard/dashboard_module.dart';
import 'package:Ineed/app/modules/evaluation/evaluation_module.dart';
import 'package:Ineed/app/modules/solicitation/solicitation_module.dart';
import 'package:Ineed/app/modules/splash/splash_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Ineed/app/constants/route_name.dart';

import 'modules/login/login_module.dart';
import 'modules/user/user_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(RouteName.splash, module: SplashModule()),
        ModuleRoute(RouteName.login, module: LoginModule()),
        ModuleRoute(RouteName.dashboard, module: DashboardModule()),
        ModuleRoute(RouteName.solicitation, module: SolicitationModule()),
        ModuleRoute(RouteName.evaluation, module: EvaluationModule()),
        ModuleRoute(RouteName.user, module: UserModule()),
      ];
}
