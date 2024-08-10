import 'package:Ineed/data/helpers/error_mapper.dart';
import 'package:Ineed/data/remote/custom_dio.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:Ineed/data/mappers/services/service_mapper.dart';
import 'package:dio/dio.dart';

import '../../../domain/entities/service/service_entity.dart';

class ServiceRemoteDataSource {
  CustomDio _dio;
  ServiceRemoteDataSource(this._dio);

  Future<ResourceData<List<ServiceEntity>>> getAllServicesFromCategory(
      int categoryId) async {
    try {
      final result = await _dio.get('servico?id=$categoryId');
      return ResourceData<List<ServiceEntity>>(
          status: Status.success,
          data: ServiceEntity().fromMapList(result["servico"]));
    } on DioError catch (e) {
      return ResourceData(
          status: Status.failed,
          data: null,
          message: "Erro ao listar os serrvicos",
          error: ErrorMapper.from(e));
    }
  }
}
