import 'package:Ineed/domain/repositories/card/card_repository.dart';
import 'package:Ineed/domain/utils/resource_data.dart';

import '../../../domain/card/card_entity.dart';
import '../../../domain/card/create_card_entity.dart';
import '../../data_source/card/card_remote_data_source.dart';

class CardRepositoryImpl implements CardRepository {
  CardRemoteDataSource _cardRemoteDataSource;

  CardRepositoryImpl(this._cardRemoteDataSource);

  @override
  Future<ResourceData<CardEntity>> createCard(CreateCardEntity card) async {
    final resource = await _cardRemoteDataSource.createCard(card);
    return resource;
  }

  @override
  Future<ResourceData<List<CardEntity>>> getAllCards() async {
    final resource = await _cardRemoteDataSource.getCards();
    return resource;
  }

  @override
  Future<ResourceData> deleteCard(int idCard) async {
    final resource = await _cardRemoteDataSource.deleteCard(idCard);
    return resource;
  }

  @override
  Future<ResourceData<CardEntity>> getCard(int idCard) async {
    final resource = await _cardRemoteDataSource.getCard(idCard);
    return resource;
  }
}
