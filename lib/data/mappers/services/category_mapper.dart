import 'dart:convert';

import '../../../domain/entities/service/category_entity.dart';

extension CategoryMapper on CategoryEntity {
  CategoryEntity copyWith({
    int? id,
  }) {
    return CategoryEntity(
      id: id!,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id};
  }

  List<CategoryEntity> fromMapList(List<dynamic> data) =>
      List.from(data).map((element) => fromMap(element)).toList();

  CategoryEntity fromMap(Map<String, dynamic> map) {
    return CategoryEntity(
      id: map['id'],
      title: map['valor'],
      image: map['imagem'],
      active: !map['inativo'],
    );
  }

  String toJson() => json.encode(toMap());

  CategoryEntity fromJson(String source) => fromMap(json.decode(source));
}
