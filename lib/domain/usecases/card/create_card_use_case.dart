import 'package:Ineed/domain/repositories/card/card_repository.dart';
import 'package:Ineed/domain/usecases/base/base_future_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:injectable/injectable.dart';

import '../../card/card_entity.dart';
import '../../card/create_card_entity.dart';

@injectable
class CreateCardUseCase
    extends BaseFutureUseCase<CreateCardEntity, ResourceData<CardEntity>> {
  CardRepository _cardRepository;
  CreateCardUseCase(this._cardRepository);

  @override
  Future<ResourceData<CardEntity>> call([CreateCardEntity? params]) async {
    var card = params;
    card!.cardNumber = card.cardNumber.replaceAll(' ', '');
    return await _cardRepository.createCard(params!);
  }
}
