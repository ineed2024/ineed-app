import 'package:Ineed/data/helpers/error_mapper.dart';
import 'package:Ineed/data/remote/custom_dio.dart';
import 'package:Ineed/domain/entities/discount/discount_entity.dart';
import 'package:Ineed/domain/entities/discount/discount_user_entity.dart';
import 'package:Ineed/data/mappers/discount/discount_mapper.dart';
import 'package:Ineed/data/mappers/discount/discount_user_mapper.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:dio/dio.dart';

class DiscountRemoteDataSource {
  CustomDio _dio;
  DiscountRemoteDataSource(this._dio);
  //Future<Resource<SolicitationEntity>>

  Future<ResourceData<List<DiscountEntity>>> getDiscount() async {
    try {
      final result = await _dio.get('desconto');
      return ResourceData<List<DiscountEntity>>(
          status: Status.success,
          message: result['message'],
          data: DiscountEntity().fromMapList(result['descontos']));
    } on DioError catch (e) {
      return ResourceData(
          status: Status.failed,
          data: null,
          message: "Erro ao listar os descontos",
          error: ErrorMapper.from(e));
    }
  }

  Future<ResourceData<DiscountUserEntity>> activateDiscount(String code) async {
    try {
      final result = await _dio.post('desconto', data: {"codigo": code});
      return ResourceData<DiscountUserEntity>(
          status: Status.success,
          data: DiscountUserEntity().fromMap(result['desconto']));
    } on DioError catch (e) {
      return ResourceData(
          status: Status.failed,
          data: null,
          message: "Erro ao ativar o desconto",
          error: ErrorMapper.from(e));
    }
  }
}
