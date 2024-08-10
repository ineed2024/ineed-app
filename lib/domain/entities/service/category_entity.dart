import 'package:flutter/foundation.dart';

@immutable
class CategoryEntity {
  final int? id;
  final String? title;
  final String? image;
  final bool? active;

  const CategoryEntity({this.id, this.title, this.image, this.active});

  @override
  String toString() {
    return 'CategoryEntity(id: $id, title: $title, image: $image, active: $active)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CategoryEntity &&
        o.id == id &&
        o.title == title &&
        o.image == image &&
        o.active == active;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        image.hashCode ^
        image.hashCode ^
        active.hashCode;
  }
}
