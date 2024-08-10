import 'dart:convert';

import 'package:Ineed/domain/entities/discount/discount_user_entity.dart';

extension DiscountUserMapper on DiscountUserEntity {
  DiscountUserEntity copyWith({
    int? id,
    int? tax,
    bool? activate,
    int? userId,
    int? couponId,
  }) {
    return DiscountUserEntity(
        id: id ?? this.id,
        tax: tax ?? this.tax,
        activate: activate ?? this.activate,
        userId: userId ?? this.userId,
        couponId: couponId ?? this.couponId);
  }

  DiscountUserEntity fromMap(Map<String, dynamic> map) {
    Map<String, dynamic> mapDiscount;
    if (map["desconto"] != null)
      mapDiscount = map["desconto"];
    else
      mapDiscount = map;
    return DiscountUserEntity(
      id: mapDiscount['id'],
      tax: mapDiscount['taxa'],
      activate: mapDiscount['ativado'],
      userId: mapDiscount['userId'],
      couponId: mapDiscount['cupomId'],
    );
  }

  DiscountUserEntity fromJson(String source) => fromMap(json.decode(source));
}
