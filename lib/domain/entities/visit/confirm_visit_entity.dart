import 'package:flutter/foundation.dart';

@immutable
class ConfirmVisitEntity {
  final int? visitId;
  final bool? paidOut;
  final double? value;
  final int? cardId;

  ConfirmVisitEntity({this.paidOut, this.value, this.cardId, this.visitId});

  @override
  String toString() {
    return 'ConfigurationEntity(paidOut: $paidOut, value: $value, cardId: $cardId, visitId: $visitId)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ConfirmVisitEntity && o.paidOut == paidOut;
  }

  @override
  int get hashCode {
    return paidOut.hashCode;
  }
}
