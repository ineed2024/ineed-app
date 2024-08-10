import 'package:Ineed/domain/entities/discount/discount_entity.dart';
import 'package:Ineed/domain/entities/discount/discount_user_entity.dart';
import 'package:Ineed/domain/repositories/discount/discount_repository.dart';
import 'package:Ineed/domain/utils/resource_data.dart';

import '../../data_source/discount/discount_remote_data_source.dart';

class DiscountRepositoryImpl implements DiscountRepository {
  DiscountRemoteDataSource _discountRemoteDataSource;

  DiscountRepositoryImpl(this._discountRemoteDataSource);

  @override
  Future<ResourceData<List<DiscountEntity>>> getDiscount() async {
    final resource = await _discountRemoteDataSource.getDiscount();
    return resource;
  }

  @override
  Future<ResourceData<DiscountUserEntity>> activateDiscount(String code) async {
    final resource = await _discountRemoteDataSource.activateDiscount(code);
    return resource;
  }
}
