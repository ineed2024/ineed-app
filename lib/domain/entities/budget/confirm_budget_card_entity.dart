import 'package:flutter/foundation.dart';

@immutable
class ConfirmBudgetCardEntity {
  final int? budgetId;
  final String? cardId;
  final int? installments;
  final double? value;

  ConfirmBudgetCardEntity(
      {this.budgetId, this.cardId, this.installments, this.value});

  @override
  String toString() {
    return 'ConfirmEstimateCreditCardEntity(estimateId: $budgetId, cardId: $cardId, installments: $installments, value: $value)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ConfirmBudgetCardEntity && o.budgetId == budgetId;
  }

  @override
  int get hashCode {
    return budgetId.hashCode;
  }
}
