import 'dart:convert';
import 'package:Ineed/domain/entities/extra_tax/extra_tax_entity.dart';

extension ExtraTaxMapper on ExtraTaxEntity {
  ExtraTaxEntity fromMap(Map<String, dynamic> map) {
    return ExtraTaxEntity(
      paidOut: map["pago"],
      value: map["valor"],
      id: map["id"],
      idBudget: map["orcamentoId"],
    );
  }

  ExtraTaxEntity fromJson(String source) => fromMap(json.decode(source));
}
