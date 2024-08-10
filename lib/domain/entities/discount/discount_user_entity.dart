import 'package:flutter/foundation.dart';

@immutable
class DiscountUserEntity {
  final int? id;
  final int? tax;
  final bool? activate;
  final int? userId;
  final int? couponId;

  DiscountUserEntity(
      {this.id, this.tax, this.activate, this.userId, this.couponId});

  @override
  String toString() {
    return 'DiscountEntity(id: $id, tax: $tax, activate: $activate, userId: $userId, couponId: $couponId)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DiscountUserEntity && o.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
