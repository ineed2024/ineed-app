import 'package:Ineed/di/di.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../domain/coupon/get_coupon_use_case.dart';
import '../../../../domain/discount/activate_discount_use_case.dart';
import '../../../../domain/discount/get_discount_use_case.dart';
import '../../../../domain/entities/coupon/coupon_entity.dart';
import '../../../../domain/entities/discount/discount_entity.dart';
import '../../../../domain/entities/discount/discount_user_entity.dart';

part 'coupon_controller.g.dart';

@Injectable()
class CouponController = _CouponControllerBase with _$CouponController;

abstract class _CouponControllerBase with Store {
  final _getCouponUseCase = getIt.get<GetDiscountUseCase>();
  final _addCouponUseCasee = getIt.get<ActivateDiscountUseCase>();
  final _getCouponShareUseCase = getIt.get<GetCouponUseCase>();

  @observable
  ResourceData<List<DiscountEntity>> coupons =
      ResourceData(status: Status.initial);

  @observable
  ResourceData<DiscountUserEntity> resourceAddCoupon =
      ResourceData(status: Status.initial);

  @observable
  ResourceData<CouponEntity> resourceCouponShare =
      ResourceData(status: Status.initial);

  @observable
  bool enableButton = false;

  void setEnableButton(bool value) {
    enableButton = value;
  }

  void getAllCupons() async {
    coupons = ResourceData(status: Status.loading);
    coupons = await _getCouponUseCase();
  }

  void getCouponShare() async {
    resourceCouponShare = ResourceData(status: Status.loading);
    resourceCouponShare = await _getCouponShareUseCase.call();
  }

  Future<bool> addCoupon(String value) async {
    resourceAddCoupon = ResourceData(status: Status.loading);
    resourceAddCoupon = await _addCouponUseCasee.call(value);
    return resourceAddCoupon.status == Status.success;
  }

  Future<bool?> activateCupoun(DiscountEntity coupon) async {}
}
