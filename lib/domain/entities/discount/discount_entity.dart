import 'package:flutter/foundation.dart';

@immutable
class DiscountEntity {
  final int? id;
  final int? discount;
  final int? couponId;
  final bool? percentage;
  final bool? activated;

  DiscountEntity(
      {this.id, this.discount, this.couponId, this.percentage, this.activated});

  @override
  String toString() {
    return 'DiscountEntity(id: $id, discount: $discount, couponId: $couponId, percentage: $percentage, activated: $activated)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DiscountEntity && o.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
