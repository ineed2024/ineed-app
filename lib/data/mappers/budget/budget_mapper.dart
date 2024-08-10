import 'dart:convert';
import 'package:Ineed/domain/entities/budget/budget_entity.dart';
import 'package:Ineed/domain/entities/evaluation/evaluation_entity.dart';
import 'package:Ineed/domain/entities/request/request_entity.dart';
import 'package:Ineed/data/mappers/request/request_mapper.dart';
import 'package:Ineed/domain/entities/collaborator/collaborator_entity.dart';
import 'package:Ineed/data/mappers/collaborator/collaborator_mapper.dart';
import 'package:Ineed/domain/entities/extra_tax/extra_tax_entity.dart';
import 'package:Ineed/data/mappers/evaluation/evaluation_mapper.dart';
import 'package:Ineed/data/mappers/extra-tax/extra_tax_mapper.dart';

extension BudgetMapper on BudgetEntity {
  BudgetEntity? fromMap(Map<String, dynamic>? map) {
    Map<String, dynamic> mapBudget;
    if (map != null) {
      mapBudget = map;
      return BudgetEntity(
        id: mapBudget['id'],
        note: mapBudget['observacao'],
        paidOut: mapBudget['pago'],
        valueLabor: double.parse(mapBudget['maoObra']),
        valueMaterial: double.parse(mapBudget['material']),
        evaluation: mapBudget['avaliacao'] != null
            ? EvaluationEntity().fromMap(mapBudget['avaliacao'])
            : null,
        extraTax: mapBudget['taxasExtras'] != null
            ? List.from(mapBudget['taxasExtras'])
                .map((e) => ExtraTaxEntity().fromMap(e))
                .toList()
            : [],
        request: mapBudget['requisicao'] != null
            ? RequestEntity().fromMap(mapBudget['requisicao'])
            : null,
        transaction: mapBudget['transacao'],
        completed: mapBudget['concluido'],
        discount: mapBudget['desconto'] != null
            ? mapBudget['desconto'].toDouble()
            : null,
        collaborator: mapBudget['usuarioColaborador'] != null
            ? CollaboratorEntity().fromMapList(mapBudget['usuarioColaborador'])
            : [],
      );
    } else
      return null;
  }
}
