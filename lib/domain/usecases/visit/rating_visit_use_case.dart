import 'package:Ineed/domain/entities/visit/avaliation_visit.dart';
import 'package:Ineed/domain/entities/visit/rating_visit_entity.dart';
import 'package:Ineed/domain/repositories/visit/visit_repository.dart';
import 'package:Ineed/domain/usecases/base/base_future_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:injectable/injectable.dart';

@injectable
class RatingVisitUseCase extends BaseFutureUseCase<RatingVisitEntity,
    ResourceData<AvaliationVisitEntity>> {
  VisitRepository _ratingVisitRepository;
  RatingVisitUseCase(this._ratingVisitRepository);
  @override
  Future<ResourceData<AvaliationVisitEntity>> call(
      [RatingVisitEntity? entity]) {
    return _ratingVisitRepository.ratingVisit(entity!);
  }
}
