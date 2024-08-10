import 'package:Ineed/domain/repositories/services/category_repository.dart';
import 'package:Ineed/domain/usecases/base/base_future_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:injectable/injectable.dart';

import '../../entities/service/category_entity.dart';

@injectable
class GetAllCategoriesUseCase
    extends BaseFutureUseCase<void, ResourceData<List<CategoryEntity>>> {
  CategoryRepository _categoryRepository;

  GetAllCategoriesUseCase(this._categoryRepository);

  @override
  Future<ResourceData<List<CategoryEntity>>> call([void params]) async {
    return await _categoryRepository.getAllCategories();
  }
}
