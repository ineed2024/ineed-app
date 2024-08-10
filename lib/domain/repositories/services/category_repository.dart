import 'package:Ineed/domain/utils/resource_data.dart';

import '../../entities/service/category_entity.dart';

abstract class CategoryRepository {
  Future<ResourceData<List<CategoryEntity>>> getAllCategories();
}
