import '../../../domain/card/create_card_entity.dart';

extension CreateCardMapper on CreateCardEntity {
  Map<String, dynamic> toMap() {
    return {
      'customerName': customerName,
      'CardNumber': cardNumber,
      'Holder': holder,
      'expirationDate': expirationDate,
      'Brand': brand,
      'SecurityCode': securityCode,
      'tipoCartaoId': typeCardId,
    };
  }
}
