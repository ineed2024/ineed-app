import 'dart:convert';

import '../../../domain/card/card_entity.dart';

extension CardMapper on CardEntity {
  CardEntity copyWith({
    int? id,
    String? cardNumber,
    String? securityCode,
    String? brand,
    String? cardToken,
    int? userId,
    int? typeCardId,
    bool? active,
    int? typeCard,
  }) {
    return CardEntity(
      id: id,
      cardNumber: cardNumber,
      securityCode: securityCode,
      brand: brand,
      cardToken: cardToken,
      userId: userId,
      typeCardId: typeCardId,
      active: active,
      typeCard: typeCard,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'number': cardNumber,
      'securityCode': securityCode,
      'brand': brand,
      'cardToken': cardToken,
      'userId': userId,
      'tipoCartaoId': typeCardId,
      'inativo': !active!,
      'tipoCartao': typeCard,
    };
  }

  List<CardEntity> fromMapList(List<dynamic> data) =>
      List.from(data).map((element) => fromMap(element)).toList();

  CardEntity fromMap(Map<String, dynamic> map) {
    Map<String, dynamic> mapCard;
    if (map["cartao"] != null)
      mapCard = map["cartao"];
    else
      mapCard = map;
    return CardEntity(
        id: mapCard['id'],
        cardNumber: mapCard['numberMask'],
        userId: mapCard['userId'],
        active: !mapCard['inativo']);
  }

  String toJson() => json.encode(toMap());

  CardEntity fromJson(String source) => fromMap(json.decode(source));
}
