import 'package:Ineed/domain/repositories/services/service_repository.dart';
import 'package:Ineed/domain/utils/resource_data.dart';

import '../../../domain/entities/service/service_entity.dart';
import '../../data_source/service/service_remote_data_source.dart';

class ServiceRepositoryImpl implements ServiceRepository {
  ServiceRemoteDataSource _serviceRemoteDataSource;

  ServiceRepositoryImpl(this._serviceRemoteDataSource);

  @override
  Future<ResourceData<List<ServiceEntity>>> getAllServiceFromCategory(
      int categoryId) async {
    return await _serviceRemoteDataSource
        .getAllServicesFromCategory(categoryId);
  }
}
