import 'package:Ineed/domain/entities/budget/confirm_budget_card_entity.dart';
import 'package:Ineed/domain/entities/budget/budget_entity.dart';
import 'package:Ineed/domain/repositories/budget/budget_repository.dart';
import 'package:Ineed/domain/usecases/base/base_future_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:injectable/injectable.dart';

@injectable
class ConfirmBudgetCardUseCase extends BaseFutureUseCase<
    ConfirmBudgetCardEntity, ResourceData<BudgetEntity>> {
  BudgetRepository _budgetRepository;
  ConfirmBudgetCardUseCase(this._budgetRepository);
  @override
  Future<ResourceData<BudgetEntity>> call(
      [ConfirmBudgetCardEntity? params]) async {
    return await _budgetRepository.confirmBudgetCard(params!);
  }
}
