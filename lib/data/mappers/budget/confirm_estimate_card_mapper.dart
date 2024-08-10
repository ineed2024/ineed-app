import 'dart:convert';

import 'package:Ineed/domain/entities/budget/confirm_budget_card_entity.dart';

extension ConfirmEstimateCardMapper on ConfirmBudgetCardEntity {
  ConfirmBudgetCardEntity copyWith(
      {int? estimateId, String? cardId, int? installments, double? value}) {
    return ConfirmBudgetCardEntity(
      budgetId: estimateId ?? this.budgetId,
      cardId: cardId ?? this.cardId,
      installments: installments ?? this.installments,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pago': true,
      'parcela': installments,
      'valor': value,
      'cartaoId': cardId,
    };
  }

  String toJson() => json.encode(toMap());
}
