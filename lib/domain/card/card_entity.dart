import 'package:flutter/foundation.dart';

@immutable
class CardEntity {
  int? id;
  String? cardNumber;
  String? securityCode;
  String? brand;
  String? cardToken;
  int? userId;
  int? typeCardId;
  bool? active;
  int? typeCard;
  String? holderName;
  String? expiryDate;
  bool? isCvvFocused;

  CardEntity(
      {this.id,
      this.cardNumber,
      this.securityCode,
      this.brand,
      this.cardToken,
      this.userId,
      this.typeCardId,
      this.active,
      this.typeCard,
      this.holderName,
      this.expiryDate,
      this.isCvvFocused: false});

  @override
  String toString() {
    // brand: 'visa',
    // number: '4485785674290087',
    // cvv: '123',
    // expirationMonth: '05',
    // expirationYear: '2029',
    // reuse: false
    return 'CardEntity(expiration_month: 08,expiration_year: 2030,number: $cardNumber, cvv: $securityCode, brand: $brand, reuse: false';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CardEntity && o.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
