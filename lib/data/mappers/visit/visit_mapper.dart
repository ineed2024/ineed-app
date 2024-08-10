import 'dart:convert';
import 'package:Ineed/data/mappers/visit/avaliation_visit_mapper.dart';
import 'package:Ineed/domain/entities/collaborator/collaborator_entity.dart';
import 'package:Ineed/domain/entities/request/request_entity.dart';
import 'package:Ineed/domain/entities/visit/visit_entity.dart';
import 'package:Ineed/data/mappers/collaborator/collaborator_mapper.dart';

import '../../../domain/entities/visit/avaliation_visit.dart';
import '../../mappers/request/request_mapper.dart';

extension VisitMapper on VisitEntity {
  VisitEntity copyWith(
      {required int id,
      required AvaliationVisitEntity? evaluation,
      required RequestEntity? request,
      required String? transaction,
      required List<CollaboratorEntity> collaborator,
      required double value,
      String? note,
      required String professionals,
      required DateTime visitDate,
      required String creationDate,
      required bool completed,
      required bool paidOut,
      required int solicitationId,
      required int requestId,
      required int evaluationId,
      required int transactionId,
      required int collaboratorId}) {
    return VisitEntity(
        id: id ?? this.id,
        evaluation: evaluation ?? this.evaluation,
        request: request ?? this.request,
        transaction: transaction ?? this.transaction,
        collaborator: collaborator ?? this.collaborator,
        value: value ?? this.value,
        note: note ?? this.note,
        professionals: professionals ?? this.professionals,
        visitDate: visitDate ?? this.visitDate,
        creationDate: creationDate ?? this.creationDate,
        completed: completed ?? this.completed,
        paidOut: paidOut ?? this.paidOut,
        solicitationId: solicitationId ?? this.solicitationId,
        requestId: requestId ?? this.requestId,
        evaluationId: evaluationId ?? this.evaluationId,
        transactionId: transactionId ?? this.transactionId,
        collaboratorId: collaboratorId ?? this.collaboratorId);
  }

  VisitEntity? fromMap(Map<String, dynamic>? map) {
    if (map != null) {
      Map<String, dynamic> mapVisit;

      mapVisit = map;
      return VisitEntity(
          id: mapVisit['id'],
          evaluation: AvaliationVisitEntity().fromMap(mapVisit['avaliacao']),
          request: RequestEntity().fromMap(mapVisit['requisicao']),
          transaction: mapVisit['transacao'],
          collaborator:
              CollaboratorEntity().fromMapList(mapVisit['usuarioColaborador']),
          value: double.parse(mapVisit['valor']),
          note: mapVisit['observacao'],
          professionals: mapVisit['profissionais'],
          visitDate: DateTime.parse(mapVisit['dataVisita']),
          creationDate: mapVisit['dataCriacao'],
          completed: mapVisit['concluida'],
          paidOut: mapVisit['pago'],
          solicitationId: mapVisit['solicitacaoId'],
          requestId: mapVisit['requisicaoId'],
          evaluationId: mapVisit['avaliacaoId'],
          transactionId: mapVisit['transacaoId'],
          collaboratorId: mapVisit['collaboratorId']);
    } else
      return null;
  }

  //String toJson() => json.encode(toMap());

  // VisitEntity fromJson(String source) => fromMap(json.decode(source));
}
