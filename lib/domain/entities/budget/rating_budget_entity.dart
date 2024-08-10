import 'package:flutter/foundation.dart';

@immutable
class RatingBudgetEntity {
  final int? idBudget;
  final int? rating;

  RatingBudgetEntity({
    this.idBudget,
    this.rating,
  });

  @override
  String toString() {
    return 'RatingBudgetEntity(idBudget: $idBudget, rating: $rating)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RatingBudgetEntity && o.idBudget == idBudget;
  }

  @override
  int get hashCode {
    return idBudget.hashCode;
  }
}
