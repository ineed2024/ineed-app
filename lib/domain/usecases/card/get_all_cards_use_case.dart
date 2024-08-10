import 'package:Ineed/domain/repositories/card/card_repository.dart';
import 'package:Ineed/domain/usecases/base/base_future_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:injectable/injectable.dart';

import '../../card/card_entity.dart';

@injectable
class GetAllCardUseCase
    extends BaseFutureUseCase<void, ResourceData<List<CardEntity>>> {
  CardRepository _cardRepository;
  GetAllCardUseCase(this._cardRepository);

  @override
  Future<ResourceData<List<CardEntity>>> call([void params]) async {
    return await _cardRepository.getAllCards();
  }
}
