import 'dart:convert';

import 'package:Ineed/domain/entities/budget/rating_budget_entity.dart';

extension RatingBudgetMapper on RatingBudgetEntity {
  RatingBudgetEntity copyWith({
    int? idBudget,
    int? rating,
  }) {
    return RatingBudgetEntity(
      idBudget: idBudget ?? this.idBudget,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nota': rating,
    };
  }

  String toJson() => json.encode(toMap());
}
