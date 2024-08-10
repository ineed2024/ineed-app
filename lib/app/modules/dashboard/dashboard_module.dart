import 'package:Ineed/app/modules/dashboard/choose-service/choose_service_page.dart';
import 'package:Ineed/app/modules/dashboard/dashboard_page.dart';
import 'package:Ineed/app/modules/dashboard/menu/menu_page.dart';

import 'package:flutter_modular/flutter_modular.dart';

class DashboardModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, __) => DashboardPage(),
        ),
        ChildRoute(
          '/menu',
          child: (_, __) => MenuPage(),
        ),
        ChildRoute(
          '/choose-service',
          child: (_, args) => ChooseServicePage(categoryEntity: args.data),
        ),
      ];
}
