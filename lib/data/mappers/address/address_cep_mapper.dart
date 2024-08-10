import 'dart:convert';

import 'package:Ineed/domain/entities/address/address_cep_entity.dart';

extension AddressCepMapper on AddressCepEntity {
  AddressCepEntity copyWith(
      {String? cep,
      String? address,
      String? complement,
      String? neighborhood,
      String? city,
      String? uf}) {
    return AddressCepEntity(
        cep: cep ?? this.cep,
        address: address ?? this.address,
        complement: complement ?? this.complement,
        neighborhood: neighborhood ?? this.neighborhood,
        city: city ?? this.city,
        uf: uf ?? this.uf);
  }

  AddressCepEntity fromMap(map) {
    Map<String, dynamic> mapAddress;

    mapAddress = map;
    return AddressCepEntity(
      cep: mapAddress['cep'],
      address: mapAddress['logradouro'],
      complement: mapAddress['complemento'],
      neighborhood: mapAddress['bairro'],
      city: mapAddress['localidade'],
      uf: mapAddress['uf'],
    );
  }

  AddressCepEntity fromJson(String source) => fromMap(json.decode(source));
}
