import 'dart:convert';
import 'package:Ineed/domain/entities/evaluation/evaluation_entity.dart';

extension EvaluationMapper on EvaluationEntity {
  EvaluationEntity fromMap(Map<String, dynamic> map) {
    Map<String, dynamic> mapEvaluation;

    mapEvaluation = map;
    return EvaluationEntity(
        id: mapEvaluation['id'],
        rate: mapEvaluation['nota'],
        observation: mapEvaluation['observacao']);
  }

  EvaluationEntity fromJson(String source) => fromMap(json.decode(source));
}
