import 'package:Ineed/app/constants/evaluation_type.dart';
import 'package:Ineed/di/di.dart';
import 'package:Ineed/domain/entities/auth/auth_entity.dart';
import 'package:Ineed/domain/entities/auth/authentication_entity.dart';
import 'package:Ineed/domain/entities/budget/rating_budget_entity.dart';
import 'package:Ineed/domain/usecases/auth/login_user_email_use_case.dart';
import 'package:Ineed/domain/usecases/budget/rating_budget_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/entities/visit/rating_visit_entity.dart';
import '../../../domain/usecases/visit/rating_visit_use_case.dart';

part 'evaluation_controller.g.dart';

@Injectable()
class EvaluationController = _EvaluationControllerBase
    with _$EvaluationController;

abstract class _EvaluationControllerBase with Store {
  final _visitRatingUseCase = getIt.get<RatingVisitUseCase>();
  final _budgetRatingUseCase = getIt.get<RatingBudgetUseCase>();

  @observable
  ResourceData resourceEvaluation = ResourceData(status: Status.initial);

  @observable
  int rating = 0;

  @action
  setRating(double newRating) {
    rating = newRating.toInt();
  }

  @action
  Future<Status> evaluation(EvaluationOptions option, int idObject) async {
    resourceEvaluation = ResourceData.loading();
    switch (option) {
      case EvaluationOptions.budget:
        final result = await _budgetRatingUseCase
            .call(RatingBudgetEntity(idBudget: idObject, rating: rating));
        resourceEvaluation = ResourceData.success();
        return result.status;
      case EvaluationOptions.visit:
        final result = await _visitRatingUseCase
            .call(RatingVisitEntity(id: idObject, rating: rating));
        resourceEvaluation = ResourceData.success();
        return result.status;
      default:
        return Status.failed;
    }
  }
}
