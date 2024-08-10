import 'package:Ineed/domain/entities/user/user_entity.dart';
import 'package:flutter/foundation.dart';

import '../../card/card_entity.dart';

@immutable
class RequestEntity {
  final int? id;
  final int? cardId;
  final int? userId;
  final CardEntity? creditCard;
  final UserEntity? user;
  final String? merchantOrderId;
  final int? portion;
  final String? codePaymentCielo;
  final double? value;
  final String? codeTid;
  final String? codTid;
  final int? installment;

  RequestEntity(
      {this.user,
      this.id,
      this.merchantOrderId,
      this.portion,
      this.userId,
      this.cardId,
      this.value,
      this.codTid,
      this.installment,
      this.codePaymentCielo,
      this.creditCard,
      this.codeTid});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RequestEntity && o.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
