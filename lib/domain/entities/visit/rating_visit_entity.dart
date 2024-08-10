import 'package:flutter/foundation.dart';

@immutable
class RatingVisitEntity {
  final int? id;
  final int? rating;

  RatingVisitEntity({
    this.id,
    this.rating,
  });

  @override
  String toString() {
    return 'RatingVisitEntity(id: $id, rating: $rating)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RatingVisitEntity && o.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
