import 'package:Ineed/data/helpers/error_mapper.dart';
import 'package:Ineed/data/mappers/extra-tax/confirm_extra_tax_mapper.dart';
import 'package:Ineed/data/remote/custom_dio.dart';
import 'package:Ineed/domain/entities/extra_tax/confirm_extra_tax_entity.dart';
import 'package:Ineed/data/mappers/extra-tax/extra_tax_mapper.dart';
import 'package:Ineed/domain/entities/extra_tax/extra_tax_entity.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:dio/dio.dart';

class ExtraTaxRemoteDataSource {
  CustomDio _dio;
  ExtraTaxRemoteDataSource(this._dio);
  //Future<Resource<SolicitationEntity>>
  Future<ResourceData<ExtraTaxEntity>> confirmExtraTax(
      ConfirmExtraTaxEntity params) async {
    var values = params.toMap();
    try {
      final result = await _dio.patch('taxa_extra', data: values);
      return ResourceData<ExtraTaxEntity>(
          status: Status.success, data: ExtraTaxEntity().fromMap(result));
    } on DioError catch (e) {
      return ResourceData(
          status: Status.failed,
          data: null,
          message: "Erro ao confirmar taxa extra",
          error: ErrorMapper.from(e));
    }
  }
}
