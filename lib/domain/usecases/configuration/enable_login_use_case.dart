import 'package:Ineed/domain/repositories/configuration/configuration_repository.dart';
import 'package:Ineed/domain/usecases/base/base_future_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:injectable/injectable.dart';

@injectable
class EnableLoginUseCase extends BaseFutureUseCase<void, ResourceData<bool>> {
  ConfigurationRepository _configurationRepository;
  EnableLoginUseCase(this._configurationRepository);
  @override
  Future<ResourceData<bool>> call([void params]) async {
    return await _configurationRepository.enableLogin();
  }
}
