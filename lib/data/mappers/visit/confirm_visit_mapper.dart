import 'dart:convert';

import 'package:Ineed/domain/entities/visit/confirm_visit_entity.dart';

extension ConfirmVisitMapper on ConfirmVisitEntity {
  ConfirmVisitEntity copyWith({bool? paidOut, double? value, int? cardId}) {
    return ConfirmVisitEntity(
        paidOut: paidOut ?? this.paidOut,
        value: value ?? this.value,
        cardId: cardId ?? this.cardId,
        visitId: visitId ?? this.visitId);
  }

  Map<String, dynamic> toMap() {
    return {
      'pago': paidOut,
      'valor': value,
      'cartaoId': cardId,
    };
  }

  String toJson() => json.encode(toMap());
}
