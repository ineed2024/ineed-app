import 'package:Ineed/di/di.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../domain/card/card_entity.dart';
import '../../../../../domain/usecases/card/delete_card_use_case.dart';
import '../../../../../domain/usecases/card/get_all_cards_use_case.dart';

part 'list_cards_controller.g.dart';

@Injectable()
class ListCardsController = _ListCardsControllerBase with _$ListCardsController;

abstract class _ListCardsControllerBase with Store {
  final _cardsUseCase = getIt.get<GetAllCardUseCase>();
  final _deleteCardUseCase = getIt.get<DeleteCardUseCase>();

  @observable
  ResourceData<List<CardEntity>> resourceCards =
      ResourceData(status: Status.initial);

  @action
  Future<void> getCards() async {
    resourceCards = ResourceData(status: Status.loading);
    resourceCards = await _cardsUseCase();
  }

  @action
  Future<void> removeCard(int index) async {
    resourceCards =
        ResourceData(status: Status.loading, data: resourceCards.data);
    final resource = await _deleteCardUseCase(resourceCards.data![index].id);
    resourceCards = ResourceData(
        status: resource.status,
        data: resourceCards.data!..removeAt(index),
        message: resource.message,
        error: resource.error);
  }
}
