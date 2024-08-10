import 'package:Ineed/domain/utils/resource_data.dart';

import '../../entities/solicitation/create_solicitation_entity.dart';
import '../../entities/solicitation/detail_solicitation_entity.dart';
import '../../entities/solicitation/solicitation_entity.dart';

abstract class SolicitationRepository {
  Future<ResourceData<List<SolicitationEntity>>> getSolicitations();
  Future<ResourceData<SolicitationEntity>> createSolicitation(
      CreateSolicitationEntity params);
  Future<ResourceData<DetailSolicitationEntity>> detailSolicitation(int id);
  // Future<ResourceData> deleteSolicitation(int id);
}
