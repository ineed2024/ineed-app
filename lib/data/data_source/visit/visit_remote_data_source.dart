import 'package:Ineed/data/helpers/error_mapper.dart';
import 'package:Ineed/data/remote/custom_dio.dart';
import 'package:Ineed/domain/entities/visit/avaliation_visit.dart';
import 'package:Ineed/domain/entities/visit/confirm_visit_entity.dart';
import 'package:Ineed/domain/entities/visit/confirm_visit_with_credit_card_entity.dart';
import 'package:Ineed/domain/entities/visit/rating_visit_entity.dart';
import 'package:Ineed/domain/entities/visit/visit_entity.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:Ineed/data/mappers/visit/avaliation_visit_mapper.dart';
import 'package:Ineed/data/mappers/visit/rating_visit_mapper.dart';
import 'package:Ineed/data/mappers/visit/confirm_visit_with_credit_card_mapper.dart';
import 'package:Ineed/data/mappers/visit/confirm_visit_mapper.dart';
import 'package:Ineed/data/mappers/visit/visit_mapper.dart';
import 'package:dio/dio.dart';

class VisitRemoteDataSource {
  CustomDio _dio;
  VisitRemoteDataSource(this._dio);

  Future<ResourceData<VisitEntity>> confirmVisit(
      ConfirmVisitEntity entity) async {
    try {
      final result =
          await _dio.patch('visita?id=${entity.visitId}', data: entity.toMap());
      return ResourceData(
          status: Status.success,
          data: VisitEntity().fromMap(result["visita"]),
          message: result["message"]);
    } on DioError catch (e) {
      return ResourceData(
          status: Status.failed,
          data: null,
          message: "Erro ao confirmar a visita",
          error: ErrorMapper.from(e));
    }
  }

  Future<ResourceData<AvaliationVisitEntity>> ratingVisit(
      RatingVisitEntity entity) async {
    try {
      final result = await _dio.patch('visita/avaliacao?id=${entity.id}',
          data: entity.toMap());
      return ResourceData(
          status: Status.success,
          data: AvaliationVisitEntity().fromMap(result),
          message: result["message"]);
    } on DioError catch (e) {
      return ResourceData(
          status: Status.failed,
          data: null,
          message: "Erro ao avaliar visita",
          error: ErrorMapper.from(e));
    }
  }

  Future<ResourceData<VisitEntity>> confirmVisitWithCreditCard(
      ConfirmVisitWithCreditCardEntity entity) async {
    try {
      final result = await _dio.patch('/visita?id=${entity.visitId}',
          data: entity.toMap());
      return ResourceData(
          status: Status.success,
          data: VisitEntity().fromMap(result["visita"]),
          message: result["message"]);
    } on DioError catch (e) {
      return ResourceData(
          status: Status.failed,
          data: null,
          message: "Erro confirmar visita",
          error: ErrorMapper.from(e));
    }
  }
}
