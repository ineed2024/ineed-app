import 'package:Ineed/domain/entities/budget/budget_entity.dart';
import 'package:Ineed/domain/entities/budget/confirm_budget_card_entity.dart';
import 'package:Ineed/domain/utils/resource_data.dart';

import '../../entities/budget/rating_budget_entity.dart';

abstract class BudgetRepository {
  Future<ResourceData<BudgetEntity>> confirmBudgetCard(
      ConfirmBudgetCardEntity entity);
  Future<ResourceData> ratingBudget(RatingBudgetEntity entity);
}
