import 'package:Ineed/domain/repositories/card/card_repository.dart';
import 'package:Ineed/domain/usecases/base/base_future_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:injectable/injectable.dart';

import '../../card/card_entity.dart';

@injectable
class GetCardUseCase extends BaseFutureUseCase<int, ResourceData<CardEntity>> {
  CardRepository _cardRepository;
  GetCardUseCase(this._cardRepository);
  @override
  Future<ResourceData<CardEntity>> call([int? params]) async {
    return await _cardRepository.getCard(params!);
  }
}
