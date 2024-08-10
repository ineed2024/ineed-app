import 'package:flutter/foundation.dart';

import 'category_entity.dart';

@immutable
class ServiceEntity {
  final int? id;
  final String? title;
  final String? description;
  final String? image;
  final bool? active;
  final CategoryEntity? categoryEntity;

  ServiceEntity(
      {this.id,
      this.title,
      this.description,
      this.image,
      this.active,
      this.categoryEntity});

  @override
  String toString() {
    return 'ServiceEntity(id: $id, title: $title, description: $description, image: $image, active: $active, category: $categoryEntity)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ServiceEntity &&
        o.id == id &&
        o.title == title &&
        o.description == description &&
        o.image == image &&
        o.active == active &&
        o.categoryEntity == categoryEntity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        image.hashCode ^
        active.hashCode ^
        categoryEntity.hashCode;
  }
}
