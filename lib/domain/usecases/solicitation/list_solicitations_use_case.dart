import 'package:Ineed/domain/repositories/solicitation/solicitation_repository.dart';
import 'package:Ineed/domain/usecases/base/base_future_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:injectable/injectable.dart';

import '../../entities/solicitation/solicitation_entity.dart';

@injectable
class ListSolicitationsUseCase
    extends BaseFutureUseCase<void, ResourceData<List<SolicitationEntity>>> {
  SolicitationRepository _solicitationRepository;

  ListSolicitationsUseCase(this._solicitationRepository);

  @override
  Future<ResourceData<List<SolicitationEntity>>> call([void params]) async {
    return await _solicitationRepository.getSolicitations();
  }
}
