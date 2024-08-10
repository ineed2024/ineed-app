import 'package:Ineed/app/constants/route_name.dart';
import 'package:Ineed/app/modules/evaluation/evaluation_controller.dart';
import 'package:Ineed/app/modules/evaluation/evaluation_page.dart';

import 'package:flutter_modular/flutter_modular.dart';

class EvaluationModule extends Module {
  @override
  List<Bind> get binds => [Bind((i) => EvaluationController())];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => EvaluationPage(args: args.data)),
      ];
}
