import 'package:Ineed/data/helpers/error_mapper.dart';
import 'package:Ineed/data/remote/custom_dio.dart';
import 'package:Ineed/domain/entities/budget/budget_entity.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:dio/dio.dart';

import '../../../domain/entities/solicitation/create_solicitation_entity.dart';
import '../../../domain/entities/solicitation/detail_solicitation_entity.dart';
import '../../../domain/entities/solicitation/solicitation_entity.dart';
import '../../../data/mappers/solicitation/solicitation_mapper.dart';
import '../../mappers/solicitation/detail_solicitation_mapper.dart';
import '../../mappers/solicitation/create_solicitation_mapper.dart';

class SolicitationRemoteDataSource {
  CustomDio _dio;
  SolicitationRemoteDataSource(this._dio);

  Future<ResourceData<List<SolicitationEntity>>> getAllSolicitations() async {
    try {
      final result =
          // await _dio.get('listarSolicitacao?filtrarPor=&filtroValor=');
          await _dio.get('listarSolicitacao');

      return ResourceData<List<SolicitationEntity>>(
          status: Status.success,
          data: SolicitationEntity().fromMapList(result["solicit"] ?? []));
    } on DioError catch (e) {
      return ResourceData(
          status: Status.failed,
          data: null,
          message: "Erro ao listar as solicitações",
          error: ErrorMapper.from(e));
    }
  }

  Future<ResourceData<SolicitationEntity>> createSolicitation(
      CreateSolicitationEntity params) async {
    try {
      print(params);
      var formData = params.toFormData();

      final response = await _dio.post(
        'solicitacaoComImagems',
        data: formData,
        contentType: 'multipart/form-data',
      );
      print('Fim request: ${DateTime.now()}');
      return ResourceData(
          status: Status.success,
          message: response["message"],
          data: SolicitationEntity().fromMap(response["solicitacao"]));
    } on DioError catch (e) {
      return ResourceData(
          status: Status.failed,
          data: null,
          message: "Erro ao criar uma solicitação",
          error: ErrorMapper.from(e));
    }
  }

  Future<ResourceData<DetailSolicitationEntity>> detailSolicitation(
      int id) async {
    try {
      final result = await _dio.get('listarSolicitacao?Id=$id');
      return ResourceData<DetailSolicitationEntity>(
          status: Status.success,
          data: DetailSolicitationEntity().fromMap(result));
    } on DioError catch (e) {
      return ResourceData(
          status: Status.failed,
          data: null,
          message: "Erro ao listar o detalhe da solicitação",
          error: ErrorMapper.from(e));
    }
  }

  Future<ResourceData> deleteSolicitation(int id) async {
    try {
      final result = await _dio.delete('solicitacao?Id=$id');
      return ResourceData(
          status: Status.success, data: null, message: result["message"]);
    } on DioError catch (e) {
      return ResourceData(
          status: Status.failed,
          data: null,
          message: "Erro ao excluir a solicitação",
          error: ErrorMapper.from(e));
    }
  }
}
