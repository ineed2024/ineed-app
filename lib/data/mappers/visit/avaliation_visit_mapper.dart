import 'dart:convert';

import 'package:Ineed/domain/entities/visit/avaliation_visit.dart';

extension AvaliationVisitMapper on AvaliationVisitEntity {
  AvaliationVisitEntity copyWith({
    int? id,
    int? rating,
    String? note,
  }) {
    return AvaliationVisitEntity(
      id: id,
      rating: rating,
      note: note,
    );
  }

  AvaliationVisitEntity? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;

    Map<String, dynamic> mapAvaliation;
    if (map["avaliacao"] != null)
      mapAvaliation = map["avaliacao"];
    else
      mapAvaliation = map;
    return AvaliationVisitEntity(
      id: mapAvaliation['id'],
      rating: mapAvaliation['nota'],
      note: mapAvaliation['observacao'],
    );
  }

  // AvaliationVisitEntity fromJson(String source) => fromMap(json.decode(source));
}
