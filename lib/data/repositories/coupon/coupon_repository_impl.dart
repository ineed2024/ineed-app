import 'package:Ineed/domain/entities/coupon/coupon_entity.dart';
import 'package:Ineed/domain/repositories/coupon/coupon_repository.dart';
import 'package:Ineed/domain/utils/resource_data.dart';

import '../../data_source/coupon/coupon_remote_data_source.dart';

class CouponRepositoryImpl implements CouponRepository {
  CouponRemoteDataSource _couponRemoteDataSource;

  CouponRepositoryImpl(this._couponRemoteDataSource);

  @override
  Future<ResourceData<CouponEntity>> getCoupon() async {
    final resource = await _couponRemoteDataSource.getCoupon();
    return resource;
  }
}
