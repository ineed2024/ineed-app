import 'package:flutter/foundation.dart';

@immutable
class CollaboratorEntity {
  final int? id;
  final String? name;
  final String? email;
  final String? pass;
  final String? rg;
  final String? cpf;
  final String? address;
  final int? numberAddress;
  final String? cep;
  final String? phone;
  final String? city;
  final String? imageUrl;
  final String? uf;
  final int? profileId;
  final int? typeId;
  final String? birthday;
  final bool? socialNetworkAccount;
  final bool? active;
  final String? complement;
  final int? couponId;

  CollaboratorEntity(
      {this.id,
      this.name,
      this.email,
      this.pass,
      this.rg,
      this.cpf,
      this.address,
      this.numberAddress,
      this.cep,
      this.phone,
      this.city,
      this.imageUrl,
      this.uf,
      this.profileId,
      this.typeId,
      this.birthday,
      this.socialNetworkAccount,
      this.active,
      this.complement,
      this.couponId});

  @override
  String toString() {
    return 'ConfigurationEntity(id: $id, name: $name, email: $email, pass: $pass, rg: $rg, cpf: $cpf, cep: $cep, phone: $phone, city: $city, imageUrl: $imageUrl, uf: $uf, profileId: $profileId, birthday: $birthday, typeId: $typeId, socialNetworkAccount: $socialNetworkAccount, active: $active, couponId: $couponId, complement: $complement)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CollaboratorEntity && o.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
