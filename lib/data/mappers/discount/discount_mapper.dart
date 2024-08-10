import 'dart:convert';

import 'package:Ineed/domain/entities/discount/discount_entity.dart';

extension DiscountMapper on DiscountEntity {
  DiscountEntity copyWith({
    int? id,
    int? discount,
    int? couponId,
    bool? percentage,
    bool? activated,
  }) {
    return DiscountEntity(
        id: id ?? this.id,
        discount: discount ?? this.discount,
        couponId: couponId ?? this.couponId,
        percentage: percentage ?? this.percentage,
        activated: activated ?? this.activated);
  }

  List<DiscountEntity> fromMapList(List<dynamic> data) =>
      List.from(data).map((element) => fromMap(element)).toList();

  DiscountEntity fromMap(Map<String, dynamic> map) {
    Map<String, dynamic> mapDiscount;
    if (map["descontos"] != null)
      mapDiscount = map["descontos"];
    else
      mapDiscount = map;
    return DiscountEntity(
      id: mapDiscount['id'],
      discount: mapDiscount['desconto'],
      activated: mapDiscount['ativado'],
      couponId: mapDiscount['cupomId'],
      percentage: mapDiscount['percentual'],
    );
  }

  DiscountEntity fromJson(String source) => fromMap(json.decode(source));
}
