import 'package:Ineed/data/helpers/error_mapper.dart';
import 'package:Ineed/data/remote/custom_dio.dart';
import 'package:Ineed/domain/entities/coupon/coupon_entity.dart';
import 'package:Ineed/data/mappers/coupon/coupon_mapper.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:dio/dio.dart';

class CouponRemoteDataSource {
  CustomDio _dio;
  CouponRemoteDataSource(this._dio);
  //Future<Resource<SolicitationEntity>>
  Future<ResourceData<CouponEntity>> getCoupon() async {
    try {
      final result = await _dio.get('cupom');
      return ResourceData<CouponEntity>(
          status: Status.success, data: CouponEntity().fromMap(result));
    } on DioError catch (e) {
      return ResourceData(
          status: Status.failed,
          data: null,
          message: "Erro ao listar os cupons",
          error: ErrorMapper.from(e));
    }
  }
}
