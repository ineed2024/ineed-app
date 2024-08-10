import 'package:Ineed/domain/entities/budget/budget_entity.dart';
import 'package:Ineed/domain/entities/budget/confirm_budget_card_entity.dart';
import 'package:Ineed/domain/entities/budget/rating_budget_entity.dart';
import 'package:Ineed/domain/repositories/budget/budget_repository.dart';
import 'package:Ineed/domain/utils/resource_data.dart';

import '../../data_source/budget/budget_remote_data_source.dart';

class BudgetRepositoryImpl implements BudgetRepository {
  BudgetRemoteDataSource _budgetRemoteDataSource;

  BudgetRepositoryImpl(this._budgetRemoteDataSource);

  @override
  Future<ResourceData<BudgetEntity>> confirmBudgetCard(
      ConfirmBudgetCardEntity entity) async {
    final resource = await _budgetRemoteDataSource.confirmBudgetCard(entity);
    return resource;
  }

  @override
  Future<ResourceData> ratingBudget(RatingBudgetEntity entity) async {
    final resource = await _budgetRemoteDataSource.ratingBudget(entity);
    return resource;
  }
}
