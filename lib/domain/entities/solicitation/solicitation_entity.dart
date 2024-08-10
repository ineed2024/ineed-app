import 'package:Ineed/domain/entities/budget/budget_entity.dart';
import 'package:Ineed/domain/entities/visit/visit_entity.dart';
import 'package:flutter/material.dart';

import '../../../app/constants/solicitation_status.dart';
import '../service/service_entity.dart';

class SolicitationEntity {
  int? id;
  final DateTime? requestDate;
  final int? userId;
  final TimeOfDay? initialDate;
  final TimeOfDay? finalDate;
  final String? evaluation;
  final String? address;
  final String? note;
  final bool? material;
  final String? typeService;
  final bool? urgent;
  final int? immobileId;
  final String? nameClient;
  final String? emailClient;
  SolicitationStatus? status;
  final bool? active;
  final VisitEntity? visit;
  final BudgetEntity? budget;
  final String? listImages;
  final List<ServiceEntity>? services;
  final String? user;

  SolicitationEntity(
      {this.id,
      this.requestDate,
      this.userId,
      this.initialDate,
      this.finalDate,
      this.evaluation,
      this.address,
      this.note,
      this.material,
      this.typeService,
      this.urgent,
      this.immobileId,
      this.nameClient,
      this.emailClient,
      this.status,
      this.active,
      this.visit,
      this.budget,
      this.listImages,
      this.services,
      this.user});

  dynamic formatStatus() {
    status = SolicitationStatus.pending;
    if (!active!) status = SolicitationStatus.canceled;
    if (visit == null) status = SolicitationStatus.pending;

    if (visit != null) {
      if (visit != null && budget == null) status = SolicitationStatus.pending;

      if (!visit!.paidOut!) status = SolicitationStatus.pendingConfirmation;

      if (visit!.paidOut! && !visit!.completed!)
        status = SolicitationStatus.waitingVisit;

      if (visit!.paidOut! &&
          visit!.completed! &&
          visit!.evaluation == null &&
          budget == null) status = SolicitationStatus.waitingEvaluation;

      if (visit!.paidOut! &&
          visit!.completed! &&
          visit!.evaluation != null &&
          budget == null) status = SolicitationStatus.pending;
    }

    if (budget != null) {
      if (budget!.paidOut! && !budget!.completed!)
        status = SolicitationStatus.waitingBudget;

      if (budget!.paidOut! && budget!.completed! && budget!.evaluation == null)
        status = SolicitationStatus.waitingEvaluation;

      if (budget!.paidOut! &&
          !budget!.completed! &&
          budget!.extraTax != null &&
          budget!.extraTax!.length > 0 &&
          !budget!.extraTax![0].paidOut!)
        status = SolicitationStatus.extraTaxConfirmation;

      if (!budget!.paidOut!) status = SolicitationStatus.pendingConfirmation;

      if (budget!.paidOut! && budget!.completed! && budget!.evaluation != null)
        status = SolicitationStatus.finished;
    }

    return status;
  }

  @override
  String toString() {
    return 'SolicitationEntity(id: $id, dataSolicitacao: $requestDate, usuarioId: $userId, dataInicial: $initialDate, dataFinal: $finalDate, avaliacao: $evaluation, endereco: $address, observacao: $note, material: $material, tipoServico: $typeService, urgente: $urgent, iMovelId: $immobileId, nomeCliente: $nameClient, emailCliente: $emailClient, status: $status, ativo: $active, visita: $visit ,orcamento: $budget ,imagem: $listImages ,services: $services, usuario: $user)';
  }

  SolicitationEntity copyWith(
      {int? id,
      DateTime? requestDate,
      int? userId,
      TimeOfDay? initialDate,
      TimeOfDay? finalDate,
      String? evaluation,
      String? address,
      String? note,
      bool? material,
      String? typeService,
      bool? urgent,
      int? immobileId,
      String? nameClient,
      String? emailClient,
      SolicitationStatus? status,
      bool? active,
      VisitEntity? visit,
      BudgetEntity? budget,
      String? listImages,
      List<ServiceEntity>? services,
      String? user}) {
    return SolicitationEntity(
        id: id,
        userId: userId,
        requestDate: requestDate,
        initialDate: initialDate,
        finalDate: finalDate,
        evaluation: evaluation,
        address: address,
        note: note,
        material: material,
        typeService: typeService,
        urgent: urgent,
        immobileId: immobileId,
        nameClient: nameClient,
        emailClient: emailClient,
        status: status,
        active: active,
        visit: visit,
        budget: budget,
        listImages: listImages ?? this.listImages,
        user: user ?? this.user,
        services: services ?? this.services);
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SolicitationEntity && o.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
