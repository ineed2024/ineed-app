import 'dart:io';

import 'package:flutter/foundation.dart';

import '../service/service_entity.dart';

@immutable
class CreateSolicitationEntity {
  final String? initialDate;
  final String? finalDate;
  final bool? material;
  final String? address;
  final String? note;
  final bool? urgent;
  final int? immobileId;
  final List<ServiceEntity>? services;
  final List<File>? images;
  CreateSolicitationEntity({
    this.initialDate,
    this.finalDate,
    this.material,
    this.address,
    this.note,
    this.urgent,
    this.immobileId,
    this.services,
    this.images,
  });

  @override
  String toString() {
    return 'SolicitationEntity(initialDate: $initialDate, finalDate: $finalDate, material: $material,  address: $address, note: $note, material: $material, note: $note, urgent: $urgent, immobileId: $immobileId, idService: $services)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CreateSolicitationEntity && o.initialDate == initialDate;
  }

  @override
  int get hashCode {
    return initialDate.hashCode;
  }
}
