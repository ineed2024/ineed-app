import 'package:Ineed/domain/entities/visit/confirm_visit_with_credit_card_entity.dart';
import 'package:Ineed/domain/entities/visit/visit_entity.dart';
import 'package:Ineed/domain/repositories/visit/visit_repository.dart';
import 'package:Ineed/domain/usecases/base/base_future_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:injectable/injectable.dart';

@injectable
class ConfirmVisitWithCreditCardUseCase extends BaseFutureUseCase<
    ConfirmVisitWithCreditCardEntity, ResourceData<VisitEntity>> {
  VisitRepository _visitRepository;
  ConfirmVisitWithCreditCardUseCase(this._visitRepository);
  @override
  Future<ResourceData<VisitEntity>> call(
      [ConfirmVisitWithCreditCardEntity? params]) {
    return _visitRepository.confirmVisitWithCreditCard(params!);
  }
}
