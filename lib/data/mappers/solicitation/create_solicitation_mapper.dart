import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import '../../../domain/entities/service/service_entity.dart';
import '../../../domain/entities/solicitation/create_solicitation_entity.dart';

extension CreateSolicitationMapper on CreateSolicitationEntity {
  CreateSolicitationEntity copyWith(
      {String? initialDate,
      String? finalDate,
      String? address,
      String? note,
      bool? material,
      bool? urgent,
      int? immobileId,
      List<ServiceEntity>? services,
      List<File>? images}) {
    return CreateSolicitationEntity(
        initialDate: initialDate ?? this.initialDate,
        finalDate: finalDate ?? this.finalDate,
        address: address ?? this.address,
        note: note ?? this.note,
        material: material ?? this.material,
        urgent: urgent ?? this.urgent,
        immobileId: immobileId ?? this.immobileId,
        services: services ?? this.services,
        images: images ?? this.images);
  }

  Map<String, dynamic> toMap() {
    return {
      'dataInicial': initialDate,
      'dataFinal': finalDate,
      'endereco': address,
      'observacao': note,
      'material': material,
      'urgente': urgent,
      'ImovelId': immobileId,
      'ServicoId': services!
          .map((map) => map.id)
          .toList()
          .toString()
          .replaceAll(RegExp("[ \\[ \\]]"), ''),
    };
  }

  FormData toFormData() {
    ///data/user/0/br.com.ineedservice/cache/image_picker8692159138491864347.jpg
    var formData = FormData.fromMap(toMap());
    print('Inicio toFormData: ${DateTime.now()}');
    images!.forEach((element) {
      var index = images!.indexOf(element) == 0 ? '' : images!.indexOf(element);
      var numberImage = index == 0 ? '' : index;
      formData.files.add(MapEntry(
        "image$numberImage",
        MultipartFile.fromFileSync(element.path,
            filename: "${DateTime.now()}.jpg"),
      ));
    });
    print('Fim toFormData: ${DateTime.now()}');
    return formData;
  }

  CreateSolicitationEntity fromMap(Map<String, dynamic> map) {
    return CreateSolicitationEntity(
        initialDate: map['dataInicial'],
        finalDate: map['dataFinal'],
        address: map['endereco'],
        note: map['observacao'],
        material: map['material'],
        urgent: map['urgente'],
        immobileId: map['iMovelId'],
        services: map['ServicoId']);
  }

  String toJson() => json.encode(toMap());

  CreateSolicitationEntity fromJson(String source) =>
      fromMap(json.decode(source));
}
