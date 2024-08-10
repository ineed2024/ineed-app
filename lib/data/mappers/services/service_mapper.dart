import 'dart:convert';

import 'package:Ineed/data/mappers/services/category_mapper.dart';

import '../../../domain/entities/service/category_entity.dart';
import '../../../domain/entities/service/service_entity.dart';

extension SeviceMapper on ServiceEntity {
  ServiceEntity copyWith(
      {int? id,
      String? title,
      String? description,
      String? image,
      CategoryEntity? categoryEntity,
      bool? active}) {
    return ServiceEntity(
        id: id!,
        title: title ?? this.title,
        description: description ?? this.description,
        image: image ?? this.image,
        active: active ?? this.active,
        categoryEntity: categoryEntity!);
  }

  Map<String, dynamic> toMap() {
    return {'id': id};
  }

  List<ServiceEntity> fromMapList(List<dynamic> data) =>
      List.from(data).map((element) => fromMap(element)).toList();

  ServiceEntity fromMap(Map<String, dynamic> map) {
    Map<String, dynamic> mapService;
    if (map["servico"] != null)
      mapService = map["servico"];
    else
      mapService = map;
    return ServiceEntity(
        id: mapService['id'],
        title: mapService['nome'],
        description: mapService['descricao'],
        image: mapService['imagem'],
        active: !mapService['inativo'],
        categoryEntity: CategoryEntity().fromMap(mapService["categoria"]));
  }

  String toJson() => json.encode(toMap());

  ServiceEntity fromJson(String source) => fromMap(json.decode(source));
}
