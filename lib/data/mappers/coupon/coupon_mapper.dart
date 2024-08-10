import 'dart:convert';

import 'package:Ineed/domain/entities/coupon/coupon_entity.dart';

extension CouponMapper on CouponEntity {
  CouponEntity copyWith({
    int? id,
    String? code,
  }) {
    return CouponEntity(
      id: id ?? this.id,
      code: code ?? this.code,
    );
  }

  CouponEntity fromMap(Map<String, dynamic> map) {
    Map<String, dynamic> mapConfiguration;
    if (map["cupom"] != null)
      mapConfiguration = map["cupom"];
    else
      mapConfiguration = map;
    return CouponEntity(
      id: mapConfiguration['id'],
      code: mapConfiguration['codigo'],
    );
  }

  CouponEntity fromJson(String source) => fromMap(json.decode(source));
}
