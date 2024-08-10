import 'package:flutter/foundation.dart';

@immutable
class ConfigurationEntity {
  final int? id;
  final int? maxParcels;
  final double? urgentVisitsRate;
  final int? maxBudget;
  final int? standardDiscount;
  final int? useRemainingCoupon;
  final int? daysUseCouponValidity;
  //final int maximoCupomDescontoDeUsuarios;
  final int? maxCupomDiscountUsers;

  ConfigurationEntity({
    this.id,
    this.maxParcels,
    this.urgentVisitsRate,
    this.maxBudget,
    this.standardDiscount,
    this.useRemainingCoupon,
    this.daysUseCouponValidity,
    this.maxCupomDiscountUsers,
  });

  @override
  String toString() {
    return 'ConfigurationEntity(id: $id, maxParcels: $maxParcels, urgentVisitsRate: $urgentVisitsRate, maxBudget: $maxBudget, standardDiscount: $standardDiscount, useRemainingCoupon: $useRemainingCoupon, daysUseCouponValidity: $daysUseCouponValidity, maxCupomDiscountUsers: $maxCupomDiscountUsers)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ConfigurationEntity && o.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
