import 'package:Ineed/domain/entities/collaborator/collaborator_entity.dart';
import 'package:Ineed/domain/entities/request/request_entity.dart';
import 'package:Ineed/domain/entities/visit/avaliation_visit.dart';
import 'package:flutter/foundation.dart';

@immutable
class VisitEntity {
  final int? id;
  final AvaliationVisitEntity? evaluation;
  final RequestEntity? request;
  final String? transaction;
  final List<CollaboratorEntity>? collaborator;
  final double? value;
  final String? note;
  final String? professionals;
  final DateTime? visitDate;
  final String? creationDate;
  final bool? completed;
  final bool? paidOut;
  final int? solicitationId;
  final int? requestId;
  final int? evaluationId;
  final int? transactionId;
  final int? collaboratorId;

  VisitEntity(
      {this.id,
      this.evaluation,
      this.request,
      this.transaction,
      this.collaborator,
      this.value,
      this.note,
      this.professionals,
      this.visitDate,
      this.creationDate,
      this.completed,
      this.paidOut,
      this.solicitationId,
      this.requestId,
      this.evaluationId,
      this.transactionId,
      this.collaboratorId});
}
