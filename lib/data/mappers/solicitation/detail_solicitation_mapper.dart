import 'dart:convert';
import 'package:Ineed/data/mappers/budget/budget_mapper.dart';
import 'package:Ineed/domain/entities/budget/budget_entity.dart';
import 'package:Ineed/domain/entities/visit/visit_entity.dart';
import 'package:Ineed/data/mappers/visit/visit_mapper.dart';

import '../../../domain/entities/solicitation/detail_solicitation_entity.dart';
import '../../../domain/entities/solicitation/solicitation_entity.dart';
import '../../../data/mappers/solicitation/solicitation_mapper.dart';

extension DetailSolicitationMapper on DetailSolicitationEntity {
  DetailSolicitationEntity fromMap(Map<String, dynamic> map) {
    Map<String, dynamic> mapReturn;
    mapReturn = map;
    return DetailSolicitationEntity(
        visit: VisitEntity().fromMap(mapReturn['visita']),
        budget: mapReturn['orcamento'] != null
            ? BudgetEntity().fromMap(mapReturn['orcamento'])
            : null,
        solicitation: SolicitationEntity()
            .fromMapFromDetailApi(mapReturn['solicitacao']));
  }

  DetailSolicitationEntity fromJson(String source) =>
      fromMap(json.decode(source));
}
