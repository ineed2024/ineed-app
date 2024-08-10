import 'package:flutter/foundation.dart';

@immutable
class ConfirmExtraTaxEntity {
  final int? id;
  final int? installments;
  final int? idCard;

  ConfirmExtraTaxEntity({
    this.id,
    this.installments,
    this.idCard,
  });

  @override
  String toString() {
    return 'ConfirmExtraTaxEntity(id: $id, installments: $installments, idCard: $idCard)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ConfirmExtraTaxEntity && o.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
