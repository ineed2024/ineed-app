import 'dart:convert';

import '../../../domain/configurations/configuration_entity.dart';

extension ConfigurationMapper on ConfigurationEntity {
  ConfigurationEntity copyWith({
    int? id,
    int? maxParcels,
    double? urgentVisitsRate,
    int? maxBudget,
    int? standardDiscount,
    int? useRemainingCoupon,
    int? daysUseCouponValidity,
    int? maxCupomDiscountUsers,
  }) {
    return ConfigurationEntity(
        id: this.id,
        maxParcels: this.maxParcels,
        urgentVisitsRate: this.urgentVisitsRate,
        maxBudget: this.maxBudget,
        standardDiscount: this.standardDiscount,
        useRemainingCoupon: this.useRemainingCoupon,
        daysUseCouponValidity: this.daysUseCouponValidity,
        maxCupomDiscountUsers: this.maxCupomDiscountUsers);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'maximoParcelas': maxParcels,
      'taxaVisitasUrgentes': urgentVisitsRate,
      'maximoOrcamentos': maxBudget,
      'descontoPadrao': standardDiscount,
      'usoRestanteCupom': useRemainingCoupon,
      'diasValidadeCupom': daysUseCouponValidity,
      'maximoCupomDescontoDeUsuarios': maxCupomDiscountUsers,
    };
  }

  ConfigurationEntity fromMap(Map<String, dynamic> map) {
    Map<String, dynamic> mapConfiguration;
    if (map["configuracao"] != null)
      mapConfiguration = map["configuracao"];
    else
      mapConfiguration = map;
    return ConfigurationEntity(
      id: mapConfiguration['id'],
      maxParcels: mapConfiguration['maximoParcelas'],
      urgentVisitsRate: mapConfiguration['taxaVisitasUrgentes'].toDouble(),
      maxBudget: mapConfiguration['maximoOrcamentos'],
      standardDiscount: mapConfiguration['descontoPadrao'],
      useRemainingCoupon: mapConfiguration['usoRestanteCupom'],
      daysUseCouponValidity: mapConfiguration['diasValidadeCupom'],
      maxCupomDiscountUsers: mapConfiguration['maximoCupomDescontoDeUsuarios'],
    );
  }

  String toJson() => json.encode(toMap());

  ConfigurationEntity fromJson(String source) => fromMap(json.decode(source));
}
