import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class UserEntity {
  final int? id;
  final String? name;
  final String? email;
  final String? password;
  final String? phonenumber;
  final String? photo;
  final bool? socialAccount;
  final String? rg;
  final String? cpfCnpj;
  final String? address;
  final int? number;
  final String? uf;
  final String? cep;
  final String? complement;
  final String? city;
  final String? birthday;
  final bool? active;
  final int? profileId;
  final int? typeId;

  const UserEntity(
      {this.id,
      this.phonenumber,
      this.photo,
      this.rg,
      this.cpfCnpj,
      this.address,
      this.number,
      this.uf,
      this.cep,
      this.complement,
      this.city,
      this.birthday,
      this.active,
      this.name,
      this.email,
      this.password,
      this.profileId = 1,
      this.typeId = 1,
      this.socialAccount = false});

  @override
  String toString() {
    return 'UserEntity(name: $name, email: $email, password: $password, profileId: $profileId, typeId: $typeId, socialAccount: $socialAccount)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UserEntity &&
        o.email == email &&
        o.name == name &&
        o.password == password &&
        o.profileId == profileId &&
        o.typeId == typeId &&
        o.socialAccount == socialAccount;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        name.hashCode ^
        password.hashCode ^
        typeId.hashCode ^
        profileId.hashCode ^
        socialAccount.hashCode;
  }
}
