import 'package:Ineed/domain/entities/collaborator/collaborator_entity.dart';
import 'package:Ineed/domain/entities/evaluation/evaluation_entity.dart';
import 'package:Ineed/domain/entities/extra_tax/extra_tax_entity.dart';
import 'package:Ineed/domain/entities/request/request_entity.dart';
import 'package:flutter/foundation.dart';

@immutable
class BudgetEntity {
  final int? id;
  final EvaluationEntity? evaluation; // objeto
  final RequestEntity? request; // objeto
  final String? transaction;
  final List<CollaboratorEntity>? collaborator;
  final double? valueLabor;
  final double? valueMaterial;
  final String? note;
  final bool? completed;
  final bool? paidOut;
  final double? discount;
  final List<ExtraTaxEntity>? extraTax;

  BudgetEntity(
      {this.id,
      this.evaluation,
      this.request,
      this.transaction,
      this.collaborator,
      this.valueLabor,
      this.valueMaterial,
      this.note,
      this.completed,
      this.paidOut,
      this.extraTax,
      this.discount});
}
