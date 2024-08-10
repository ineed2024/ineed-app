import 'package:Ineed/domain/entities/budget/rating_budget_entity.dart';
import 'package:Ineed/domain/repositories/budget/budget_repository.dart';
import 'package:Ineed/domain/usecases/base/base_future_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:injectable/injectable.dart';

@injectable
class RatingBudgetUseCase
    extends BaseFutureUseCase<RatingBudgetEntity, ResourceData> {
  BudgetRepository _budgetRepository;
  RatingBudgetUseCase(this._budgetRepository);
  @override
  Future<ResourceData> call([RatingBudgetEntity? params]) {
    return _budgetRepository.ratingBudget(params!);
  }
}
