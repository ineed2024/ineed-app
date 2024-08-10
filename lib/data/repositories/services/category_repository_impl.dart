import 'package:Ineed/domain/repositories/services/category_repository.dart';
import 'package:Ineed/domain/utils/resource_data.dart';

import '../../../domain/entities/service/category_entity.dart';
import '../../data_source/service/category_remote_data_source.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRemoteDataSource _categoryRemoteDataSource;

  CategoryRepositoryImpl(this._categoryRemoteDataSource);

  @override
  Future<ResourceData<List<CategoryEntity>>> getAllCategories() async {
    return await _categoryRemoteDataSource.getAllCategories();
  }
}
