import 'package:Ineed/domain/entities/auth/authentication_entity.dart';
import 'package:Ineed/domain/utils/resource_data.dart';

import '../../configurations/configuration_entity.dart';

abstract class ConfigurationRepository {
  Future<ResourceData<ConfigurationEntity>> getConfiguration();
  Future<ResourceData<bool>> enableLogin();
}
