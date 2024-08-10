import 'package:Ineed/app/constants/card_type.dart';

class CreateCardEntity {
  final String customerName;
  String cardNumber;
  final String holder;
  final String expirationDate;
  String? brand;
  final String securityCode;
  final bool isCvvFocused = false;
  final int typeCardId = CardType.credit.valueOf();

  CreateCardEntity(
      {required this.customerName,
      required this.cardNumber,
      required this.holder,
      required this.expirationDate,
      this.brand,
      required this.securityCode});

  @override
  String toString() {
    return 'ConfigurationEntity()';
  }

/*
   brand: 'visa',
          number: '4485785674290087',
          cvv: '123',
          expirationMonth: '05',
          expirationYear: '2029',
          reuse: false


          
*/
  toMap() {
    return {
      'expiration_year': expirationDate.substring(3, 7),
      'expiration_month': expirationDate.substring(0, 2),
      'number': cardNumber,
      'holder': holder,
      'brand': brand,
      'cvv': securityCode,
      'reuse': false,
    };
  }

  toMap2() {
    return {
      "NumberMask": "sample string 1",
      "CardToken": "sample string 2",
      "UserId": 3,
      "Inativo": false
    };
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CreateCardEntity && o.customerName == customerName;
  }

  @override
  int get hashCode {
    return customerName.hashCode;
  }
}
