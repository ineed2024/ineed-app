import 'dart:convert';

import 'package:Ineed/domain/entities/extra_tax/confirm_extra_tax_entity.dart';

extension ConfirmExtraTaxMapper on ConfirmExtraTaxEntity {
  ConfirmExtraTaxEntity copyWith({
    int? id,
    int? installments,
    int? idCard,
  }) {
    return ConfirmExtraTaxEntity(
      id: id ?? this.id,
      installments: installments ?? this.installments,
      idCard: idCard ?? this.idCard,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'requisicao': {
        'parcela': installments,
        'cartaoId': idCard,
      },
    };
  }

  String toJson() => json.encode(toMap());
}
