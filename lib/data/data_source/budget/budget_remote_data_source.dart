import 'package:Ineed/data/helpers/error_mapper.dart';
import 'package:Ineed/data/remote/custom_dio.dart';
import 'package:Ineed/domain/entities/budget/budget_entity.dart';
import 'package:Ineed/domain/entities/budget/confirm_budget_card_entity.dart';
// import 'package:Ineed/domain/entities/budget/rating_budget_entity.dart';
import 'package:Ineed/data/mappers/budget/confirm_estimate_card_mapper.dart';
import 'package:Ineed/data/mappers/budget/budget_mapper.dart';
import 'package:Ineed/data/mappers/budget/rating_budget_mapper.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:dio/dio.dart';

import '../../../domain/entities/budget/rating_budget_entity.dart';

class BudgetRemoteDataSource {
  CustomDio _dio;
  BudgetRemoteDataSource(this._dio);
  //Future<Resource<SolicitationEntity>>
  Future<ResourceData<BudgetEntity>> confirmBudgetCard(
      ConfirmBudgetCardEntity params) async {
    try {
      var values = params.toMap();
      print(values);

      final result =
          await _dio.patch('orcamento?id=${params.budgetId}', data: values);
      return ResourceData<BudgetEntity>(
          status: Status.success,
          data: BudgetEntity().fromMap(result["orcamento"]),
          message: result["message"]);
    } on DioError catch (e) {
      print('**********');
      print(ErrorMapper.from(e));
      return ResourceData(
          status: Status.failed,
          data: null,
          message: "Erro ao confirmar orçamento",
          error: ErrorMapper.from(e));
    }
  }

  Future<ResourceData> ratingBudget(RatingBudgetEntity params) async {
    try {
      var values = params.toMap();

      final result = await _dio
          .post('orcamento/avaliacao?id=${params.idBudget}', data: values);
      return ResourceData(
          status: Status.success, data: values, message: result["message"]);
    } on DioError catch (e) {
      return ResourceData(
          status: Status.failed,
          data: null,
          message: "Erro ao avaliar orçamento",
          error: ErrorMapper.from(e));
    }
  }
}
