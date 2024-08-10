import 'package:Ineed/domain/entities/visit/confirm_visit_entity.dart';
import 'package:Ineed/domain/entities/visit/visit_entity.dart';
import 'package:Ineed/domain/repositories/visit/visit_repository.dart';
import 'package:Ineed/domain/usecases/base/base_future_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:injectable/injectable.dart';

@injectable
class ConfirmVisitUseCase
    extends BaseFutureUseCase<ConfirmVisitEntity, ResourceData<VisitEntity>> {
  VisitRepository _visitRepository;
  ConfirmVisitUseCase(this._visitRepository);
  @override
  Future<ResourceData<VisitEntity>> call([ConfirmVisitEntity? params]) async {
    return await _visitRepository.confirmVisit(params!);
  }
}
