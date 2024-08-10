import 'package:Ineed/domain/repositories/solicitation/solicitation_repository.dart';
import 'package:Ineed/domain/utils/resource_data.dart';

import '../../../domain/entities/solicitation/create_solicitation_entity.dart';
import '../../../domain/entities/solicitation/detail_solicitation_entity.dart';
import '../../../domain/entities/solicitation/solicitation_entity.dart';
import '../../data_source/solicitation/solicitation_remote_data_source.dart';

class SolicitationRepositoryImpl implements SolicitationRepository {
  SolicitationRemoteDataSource _solitationRemoteDataSource;

  SolicitationRepositoryImpl(this._solitationRemoteDataSource);

  @override
  Future<ResourceData<List<SolicitationEntity>>> getSolicitations() async {
    return await _solitationRemoteDataSource.getAllSolicitations();
  }

  @override
  Future<ResourceData<SolicitationEntity>> createSolicitation(
      CreateSolicitationEntity entity) async {
    return await _solitationRemoteDataSource.createSolicitation(entity);
  }

  @override
  Future<ResourceData<DetailSolicitationEntity>> detailSolicitation(int id) {
    return _solitationRemoteDataSource.detailSolicitation(id);
  }

  // @override
  // Future<ResourceData> deleteSolicitation(int id) async {
  //   return await _solitationRemoteDataSource.deleteSolicitation(id);
  // }
}
