import 'package:Ineed/domain/entities/discount/discount_entity.dart';
import 'package:Ineed/domain/entities/discount/discount_user_entity.dart';

import 'package:Ineed/domain/utils/resource_data.dart';

abstract class DiscountRepository {
  Future<ResourceData<List<DiscountEntity>>> getDiscount();
  Future<ResourceData<DiscountUserEntity>> activateDiscount(String code);
}
