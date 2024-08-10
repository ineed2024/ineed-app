import 'package:flutter/foundation.dart';

@immutable
class ExtraTaxEntity {
  final int? id;
  final bool? paidOut;
  final double? value;
  final int? idBudget;

  ExtraTaxEntity({this.paidOut, this.value, this.id, this.idBudget});
}
