import 'package:flutter/material.dart';

@immutable
class EvaluationEntity {
  final int? id;
  final String? observation;
  final int? rate;

  EvaluationEntity({this.id, this.observation, this.rate});
}
