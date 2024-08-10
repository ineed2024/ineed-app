import 'package:Ineed/domain/repositories/configuration/configuration_repository.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:Ineed/domain/utils/status.dart';

import '../../../domain/configurations/configuration_entity.dart';
import '../../data_source/configuration/configuration_local_data_source.dart';
import '../../data_source/configuration/configuration_remote_data_source.dart';

class ConfigurationRepositoryImpl implements ConfigurationRepository {
  ConfigurationLocalDataSource _configLocalDataSource;
  ConfigurationRemoteDataSource _configurationRemoteDataSource;

  ConfigurationRepositoryImpl(
      this._configurationRemoteDataSource, this._configLocalDataSource);

  @override
  Future<ResourceData<ConfigurationEntity>> getConfiguration() async {
    final resource = await _configurationRemoteDataSource.getConfiguration();

    if (resource.status == Status.success)
      _configLocalDataSource.saveConfig(resource.data!);
    return resource;
  }

  @override
  Future<ResourceData<bool>> enableLogin() async {
    final resource = await _configurationRemoteDataSource.enableLoginSocial();
    return resource;
  }
}
