import 'package:flutter/foundation.dart';

@immutable
class AddressCepEntity {
  final String? cep;
  final String? address;
  final String? complement;
  final String? neighborhood;
  final String? city;
  final String? uf;

  AddressCepEntity(
      {this.cep,
      this.address,
      this.complement,
      this.neighborhood,
      this.city,
      this.uf});

  @override
  String toString() {
    return 'AddressCepEntity(cep: $cep, address: $address, complement: $complement, neighborhood: $neighborhood, city: $city, uf: $uf)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AddressCepEntity && o.address == address;
  }

  @override
  int get hashCode {
    return address.hashCode;
  }
}
