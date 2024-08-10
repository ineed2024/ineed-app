import 'dart:convert';

import 'package:Ineed/domain/entities/address/address_entity.dart';

extension AddressMapper on AddressEntity {
  AddressEntity copyWith(
      {String? address,
      int? numberAddress,
      String? cep,
      String? city,
      String? uf,
      String? complement}) {
    return AddressEntity(
      address: address ?? this.address,
      numberAddress: this.numberAddress,
      cep: cep ?? this.cep,
      city: city ?? this.city,
      uf: uf ?? this.uf,
      complement: complement ?? this.complement,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'endereco': address,
      'numero': numberAddress,
      'cep': cep,
      'cidade': city,
      'uf': uf,
      'complemento': complement
    };
  }

  String toJson() => json.encode(toMap());
}
