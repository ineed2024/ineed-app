import 'package:Ineed/domain/repositories/configuration/configuration_repository.dart';
import 'package:Ineed/domain/usecases/base/base_future_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:injectable/injectable.dart';

import '../../configurations/configuration_entity.dart';

@injectable
class GetConfigurationUseCase
    extends BaseFutureUseCase<void, ResourceData<ConfigurationEntity>> {
  ConfigurationRepository _configurationRepository;
  GetConfigurationUseCase(this._configurationRepository);
  @override
  Future<ResourceData<ConfigurationEntity>> call([void params]) async {
    return await _configurationRepository.getConfiguration();
  }
}
