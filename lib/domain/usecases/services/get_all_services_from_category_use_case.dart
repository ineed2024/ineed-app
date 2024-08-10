import 'package:Ineed/domain/repositories/services/service_repository.dart';
import 'package:Ineed/domain/usecases/base/base_future_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:injectable/injectable.dart';

import '../../entities/service/service_entity.dart';

@injectable
class GetAllServicesFromCategoryUseCase
    extends BaseFutureUseCase<int, ResourceData<List<ServiceEntity>>> {
  ServiceRepository _serviceRepository;

  GetAllServicesFromCategoryUseCase(this._serviceRepository);

  @override
  Future<ResourceData<List<ServiceEntity>>> call([int? params]) async {
    return await _serviceRepository.getAllServiceFromCategory(params!);
  }
}
