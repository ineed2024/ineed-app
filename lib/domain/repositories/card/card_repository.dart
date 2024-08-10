import 'package:Ineed/domain/utils/resource_data.dart';

import '../../card/card_entity.dart';
import '../../card/create_card_entity.dart';

abstract class CardRepository {
  Future<ResourceData<CardEntity>> createCard(CreateCardEntity card);
  Future<ResourceData<List<CardEntity>>> getAllCards();
  Future<ResourceData<CardEntity>> getCard(int idCard);
  Future<ResourceData> deleteCard(int idCard);
}
