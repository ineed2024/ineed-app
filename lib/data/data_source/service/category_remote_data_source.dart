import 'package:Ineed/data/helpers/error_mapper.dart';
import 'package:Ineed/data/remote/custom_dio.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:dio/dio.dart';

import '../../../domain/entities/service/category_entity.dart';
import '../../../data/mappers/services/category_mapper.dart';

class CategoryRemoteDataSource {
  CustomDio _dio;
  CategoryRemoteDataSource(this._dio);

  Future<ResourceData<List<CategoryEntity>>> getAllCategories() async {
    try {
      final result = await _dio.get('categoria');
      return ResourceData<List<CategoryEntity>>(
          status: Status.success,
          data: CategoryEntity().fromMapList(result["categoria"]));
    } on DioError catch (e) {
      return ResourceData(
          status: Status.failed,
          data: null,
          message: "Erro ao listar as categorias",
          error: ErrorMapper.from(e));
    }
  }
}
