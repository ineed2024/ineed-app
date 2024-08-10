import 'dart:convert';

import 'package:Ineed/domain/entities/visit/visit_entity.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/budget/budget_entity.dart';
import '../../../domain/entities/service/service_entity.dart';
import '../../../domain/entities/solicitation/solicitation_entity.dart';
import '../../../data/mappers/visit/visit_mapper.dart';
import '../../../data/mappers/budget/budget_mapper.dart';
import '../../../data/mappers/services/service_mapper.dart';

extension SolicitationMapper on SolicitationEntity {
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dataSolicitacao': requestDate,
      'usuarioId': userId,
      'dataInicial': initialDate,
      'dataFinal': finalDate,
      'avaliacao': evaluation,
      'endereco': address,
      'observacao': note,
      'material': material,
      'tipoServico': typeService,
      'urgente': urgent,
      'iMovelId': immobileId,
      'nomeCliente': nameClient,
      'emailCliente': emailClient,
      'status': status,
      'ativo': active,
      'visita': visit,
      'orcamento': budget,
      'imagem': listImages,
      'services': services,
      'usuario': user,
    };
  }

  List<SolicitationEntity> fromMapList(List<dynamic> map) =>
      map != null ? List.from(map).map((el) => fromMap(el)).toList() : [];

  SolicitationEntity fromMap(Map<String, dynamic> map) {
    final solicitation = SolicitationEntity(
        id: map['id'],
        requestDate: DateTime.parse(map['dataSolicitacao']),
        userId: map['usuarioId'],
        initialDate: TimeOfDay.fromDateTime(DateTime.parse(map['dataInicial'])),
        finalDate: TimeOfDay.fromDateTime(DateTime.parse(map['dataFinal'])),
        evaluation: map['avaliacao'],
        address: (map['endereco'] as String).replaceAll('\n', ''),
        note: map['observacao'],
        material: map['material'],
        typeService: map['tipoServico'],
        urgent: map['urgente'],
        immobileId: map['iMovelId'],
        nameClient: map['nomeCliente'],
        emailClient: map['emailCliente'],
        active: map['ativo'],
        visit: VisitEntity().fromMap(map['visita']),
        listImages: map['imagem'].toString(),
        user: map['usuario']['nome'],
        budget: BudgetEntity().fromMap(map['orcamento']),
        services: map["servicoSolicitacao"] != null
            ? List.from(map["servicoSolicitacao"])
                .map((element) => ServiceEntity().fromMap(element))
                .toList()
            : null,
        status: null);
    solicitation.formatStatus();
    return solicitation;
  }

  SolicitationEntity fromMapFromDetailApi(Map<String, dynamic> map) {
    final solicitation = SolicitationEntity(
        address: (map['endereco'] as String).replaceAll('\n', ''),
        urgent: map['urgente'],
        initialDate: TimeOfDay.fromDateTime(DateTime.parse(map['dataInicial'])),
        finalDate: TimeOfDay.fromDateTime(DateTime.parse(map['dataFinal'])),
        material: map["fornecerMaterial"],
        listImages: map['imagem'].toString(),
        note: map['observacao'],
        typeService: map['tipoServico'],
        immobileId: map['iMovelId'],
        active: true,
        services: map["solicitacoes"] != null
            ? List.from(map["solicitacoes"])
                .map((element) => ServiceEntity().fromMap(element))
                .toList()
            : null);
    solicitation.formatStatus();
    return solicitation;
  }

  String toJson() => json.encode(toMap());

  SolicitationEntity fromJson(String source) => fromMap(json.decode(source));
}
