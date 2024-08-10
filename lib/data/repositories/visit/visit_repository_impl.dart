import 'package:Ineed/domain/entities/visit/avaliation_visit.dart';
import 'package:Ineed/domain/entities/visit/confirm_visit_entity.dart';
import 'package:Ineed/domain/entities/visit/confirm_visit_with_credit_card_entity.dart';
import 'package:Ineed/domain/entities/visit/rating_visit_entity.dart';
import 'package:Ineed/domain/entities/visit/visit_entity.dart';
import 'package:Ineed/domain/repositories/visit/visit_repository.dart';
import 'package:Ineed/domain/utils/resource_data.dart';

import '../../data_source/visit/visit_remote_data_source.dart';

class VisitRepositoryImpl implements VisitRepository {
  VisitRemoteDataSource _visitRemoteDataSource;

  VisitRepositoryImpl(this._visitRemoteDataSource);

  @override
  Future<ResourceData<VisitEntity>> confirmVisit(
      ConfirmVisitEntity entity) async {
    final resource = await _visitRemoteDataSource.confirmVisit(entity);
    return resource;
  }

  @override
  Future<ResourceData<AvaliationVisitEntity>> ratingVisit(
      RatingVisitEntity entity) async {
    final resource = await _visitRemoteDataSource.ratingVisit(entity);
    return resource;
  }

  @override
  Future<ResourceData<VisitEntity>> confirmVisitWithCreditCard(
      ConfirmVisitWithCreditCardEntity entity) async {
    final resource =
        await _visitRemoteDataSource.confirmVisitWithCreditCard(entity);
    return resource;
  }
}
