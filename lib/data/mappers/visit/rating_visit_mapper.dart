import 'dart:convert';
import 'package:Ineed/domain/entities/visit/rating_visit_entity.dart';

extension RatingVisitMapper on RatingVisitEntity {
  RatingVisitEntity copyWith({
    int? id,
    int? rating,
  }) {
    return RatingVisitEntity(id: id ?? this.id, rating: rating ?? this.rating);
  }

  Map<String, dynamic> toMap() {
    return {
      'nota': rating,
    };
  }

  String toJson() => json.encode(toMap());
}
