import 'package:Ineed/app/modules/solicitation/list-solicitations/list_solicitations_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../constants/route_name.dart';
import 'create-solicitation/create_solicitation_page.dart';
import 'detail-solicitation/detail_solicitation_page.dart';

class SolicitationModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/solicitation-list',
      child: (_, __) => ListSolicitationsPage(),
    ),
    ChildRoute(
      '/solicitation-create',
      child: (_, args) => CreateSolicitationPage(
        category: args.data['category'],
        listServices: args.data['listServices'],
      ),
    ),
    ChildRoute(
      '/solicitation-create',
      child: (_, args) => CreateSolicitationPage(
        category: args.data['category'],
        listServices: args.data['listServices'],
      ),
    ),
    ChildRoute('/solicitation-detail',
        child: (_, args) => DetailSolicitationPage(
              solicitationId: args.data,
            )),
  ];
}
