import 'package:Ineed/domain/entities/coupon/coupon_entity.dart';
import 'package:Ineed/domain/repositories/coupon/coupon_repository.dart';
import 'package:Ineed/domain/usecases/base/base_future_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCouponUseCase
    extends BaseFutureUseCase<void, ResourceData<CouponEntity>> {
  CouponRepository _couponRepository;
  GetCouponUseCase(this._couponRepository);
  @override
  Future<ResourceData<CouponEntity>> call([void params]) async {
    return await _couponRepository.getCoupon();
  }
}
