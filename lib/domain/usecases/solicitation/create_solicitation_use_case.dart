import 'package:Ineed/domain/repositories/solicitation/solicitation_repository.dart';
import 'package:Ineed/domain/usecases/base/base_future_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:injectable/injectable.dart';

import '../../entities/solicitation/create_solicitation_entity.dart';
import '../../entities/solicitation/solicitation_entity.dart';

@injectable
class CreateSolicitationUseCase extends BaseFutureUseCase<
    CreateSolicitationEntity, ResourceData<SolicitationEntity>> {
  SolicitationRepository _solicitationRepository;

  CreateSolicitationUseCase(this._solicitationRepository);

  @override
  Future<ResourceData<SolicitationEntity>> call(
      [CreateSolicitationEntity? params]) async {
    return await _solicitationRepository.createSolicitation(params!);
  }
}
