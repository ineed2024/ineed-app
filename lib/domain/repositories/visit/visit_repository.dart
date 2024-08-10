import 'package:Ineed/domain/entities/visit/avaliation_visit.dart';
import 'package:Ineed/domain/entities/visit/confirm_visit_entity.dart';
import 'package:Ineed/domain/entities/visit/confirm_visit_with_credit_card_entity.dart';
import 'package:Ineed/domain/entities/visit/rating_visit_entity.dart';
import 'package:Ineed/domain/entities/visit/visit_entity.dart';
import 'package:Ineed/domain/utils/resource_data.dart';

abstract class VisitRepository {
  Future<ResourceData<VisitEntity>> confirmVisit(ConfirmVisitEntity entity);
  Future<ResourceData<AvaliationVisitEntity>> ratingVisit(
      RatingVisitEntity entity);
  Future<ResourceData<VisitEntity>> confirmVisitWithCreditCard(
      ConfirmVisitWithCreditCardEntity entity);
}
