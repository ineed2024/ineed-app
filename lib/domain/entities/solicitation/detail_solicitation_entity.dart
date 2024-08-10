import 'package:Ineed/domain/entities/budget/budget_entity.dart';
import 'package:Ineed/domain/entities/visit/visit_entity.dart';
import 'package:flutter/foundation.dart';

import 'solicitation_entity.dart';

@immutable
class DetailSolicitationEntity {
  final SolicitationEntity? solicitation;
  final VisitEntity? visit;
  final BudgetEntity? budget;

  DetailSolicitationEntity({this.solicitation, this.visit, this.budget});

  @override
  String toString() {
    return 'DetailSolicitationEntity(solicitation: $solicitation, visit: $visit, orcamento: $budget)';
  }

  DetailSolicitationEntity copyWith(
      {SolicitationEntity? solicitation,
      VisitEntity? visit,
      BudgetEntity? budget}) {
    return DetailSolicitationEntity(
      solicitation: solicitation ?? this.solicitation,
      visit: visit ?? this.visit,
      budget: budget ?? this.budget,
    );
  }
}
