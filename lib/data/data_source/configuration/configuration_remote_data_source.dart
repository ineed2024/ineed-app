import 'package:Ineed/data/helpers/error_mapper.dart';
import 'package:Ineed/data/remote/custom_dio.dart';
import 'package:Ineed/data/mappers/configuration/configuration_mapper.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:dio/dio.dart';

import '../../../domain/configurations/configuration_entity.dart';

class ConfigurationRemoteDataSource {
  CustomDio _dio;
  ConfigurationRemoteDataSource(this._dio);
  Future<ResourceData<ConfigurationEntity>> getConfiguration() async {
    try {
      final result = await _dio.get('configuracao');
      return ResourceData<ConfigurationEntity>(
          status: Status.success, data: ConfigurationEntity().fromMap(result));
    } on DioError catch (e) {
      return ResourceData(
          status: Status.failed,
          data: null,
          message: "Erro ao buscar as configurações",
          error: ErrorMapper.from(e));
    }
  }

  Future<ResourceData<bool>> enableLoginSocial() async {
    try {
      final result = await _dio.get('habilita/facebook');
      return ResourceData<bool>(
          status: Status.success, data: result['habilitado']);
    } on DioError catch (e) {
      return ResourceData(
          status: Status.failed,
          data: null,
          message: "Erro ao buscar as configurações de login",
          error: ErrorMapper.from(e));
    }
  }
}
