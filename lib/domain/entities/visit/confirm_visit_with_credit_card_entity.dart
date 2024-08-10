import 'package:flutter/foundation.dart';

@immutable
class ConfirmVisitWithCreditCardEntity {
  final int? visitId;
  final double? value;
  final String? creditCardId;
  final bool? paidOut;

  ConfirmVisitWithCreditCardEntity(
      {this.visitId, this.value, this.creditCardId, this.paidOut});

  @override
  String toString() {
    return 'ConfirmVisitWithCreditCardEntity(visitId: $visitId,value: $value,creditCardId: $creditCardId)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ConfirmVisitWithCreditCardEntity && o.visitId == visitId;
  }

  @override
  int get hashCode {
    return visitId.hashCode;
  }
}
