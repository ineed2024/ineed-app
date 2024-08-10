import 'package:Ineed/domain/entities/coupon/coupon_entity.dart';

import 'package:Ineed/domain/utils/resource_data.dart';

abstract class CouponRepository {
  Future<ResourceData<CouponEntity>> getCoupon();
}
