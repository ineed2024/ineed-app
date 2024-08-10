import 'package:flutter_modular/flutter_modular.dart';

import 'create-card/create_card_page.dart';
import 'list-cards/list_cards_page.dart';

class CardsModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => ListCardsPage()),
        ChildRoute('/create', child: (_, args) => CreateCardPage()),
      ];
}
