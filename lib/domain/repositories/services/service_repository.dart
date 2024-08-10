import 'package:Ineed/domain/utils/resource_data.dart';

import '../../entities/service/service_entity.dart';

abstract class ServiceRepository {
  Future<ResourceData<List<ServiceEntity>>> getAllServiceFromCategory(
      int categoryId);
}
