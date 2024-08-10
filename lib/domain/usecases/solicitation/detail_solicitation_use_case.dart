import 'package:Ineed/domain/repositories/solicitation/solicitation_repository.dart';
import 'package:Ineed/domain/usecases/base/base_future_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:injectable/injectable.dart';

import '../../entities/solicitation/detail_solicitation_entity.dart';

@injectable
class DetailSolicitationUseCase
    extends BaseFutureUseCase<int, ResourceData<DetailSolicitationEntity>> {
  SolicitationRepository _solicitationRepository;
  DetailSolicitationUseCase(this._solicitationRepository);
  @override
  Future<ResourceData<DetailSolicitationEntity>> call([int? params]) {
    return _solicitationRepository.detailSolicitation(params!).then((value) {
      var data;
      if (value.data != null) {
        data = DetailSolicitationEntity().copyWith(
            visit: value.data?.visit,
            solicitation: value.data!.solicitation,
            budget: value.data?.budget);
      }
      return ResourceData(
          status: value.status,
          data: data,
          error: value.error,
          message: value.message);
    });
  }
}
