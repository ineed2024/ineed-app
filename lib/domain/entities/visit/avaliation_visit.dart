import 'package:flutter/foundation.dart';

@immutable
class AvaliationVisitEntity {
  final int? id;
  final int? rating;
  final String? note;

  AvaliationVisitEntity({this.id, this.rating, this.note});

  @override
  String toString() {
    return 'AvaliationVisitEntity(id: $id, rating: $rating, note: $note)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AvaliationVisitEntity && o.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
