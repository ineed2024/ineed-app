import 'dart:convert';

import 'package:Ineed/domain/entities/visit/confirm_visit_with_credit_card_entity.dart';

extension ConfirmVisitWithCreditCardMapper on ConfirmVisitWithCreditCardEntity {
  ConfirmVisitWithCreditCardEntity copyWith(
      {int? visitId, int? value, String? creditCardId, bool? paidOut}) {
    return ConfirmVisitWithCreditCardEntity(
      visitId: visitId ?? this.visitId,
      value: this.value!.toDouble(),
      creditCardId: creditCardId ?? this.creditCardId,
      paidOut: paidOut ?? this.paidOut,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pago': paidOut,
      'valor': value,
      'cartaoId': creditCardId,
    };
  }

  String toJson() => json.encode(toMap());
}
