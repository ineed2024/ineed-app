import 'package:Ineed/domain/repositories/card/card_repository.dart';
import 'package:Ineed/domain/usecases/base/base_future_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteCardUseCase extends BaseFutureUseCase<int, ResourceData> {
  CardRepository _cardRepository;
  DeleteCardUseCase(this._cardRepository);
  @override
  Future<ResourceData> call([int? params]) async {
    return await _cardRepository.deleteCard(params!);
  }
}
