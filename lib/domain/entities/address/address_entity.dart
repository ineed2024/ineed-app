import 'package:flutter/foundation.dart';

@immutable
class AddressEntity {
  final String? address;
  final String? numberAddress;
  final String? complement;
  final String? cep;
  final String? city;
  final String? uf;

  AddressEntity(
      {this.address,
      this.complement,
      this.numberAddress,
      this.cep,
      this.city,
      this.uf});

  @override
  String toString() {
    return 'AddressEntity(address: $address, numberAddress: $numberAddress, cep: $cep, city: $city, uf: $uf, complement: $complement)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AddressEntity && o.address == address;
  }

  @override
  int get hashCode {
    return address.hashCode;
  }
}
