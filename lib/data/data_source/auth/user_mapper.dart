import 'dart:convert';

import 'package:Ineed/domain/entities/user/user_entity.dart';

extension UserMapper on UserEntity {
  UserEntity copyWith(
      {String? name,
      String? email,
      String? password,
      String? typeId,
      String? profileId,
      String? phonenumber,
      String? photo,
      bool? socialAccount,
      String? rg,
      String? cpfCnpj,
      int? number,
      String? complement,
      String? city,
      String? birthday,
      bool? active}) {
    return UserEntity(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      profileId: this.profileId,
      typeId: this.typeId,
      socialAccount: socialAccount ?? this.socialAccount,
      phonenumber: phonenumber ?? this.phonenumber,
      photo: photo ?? this.photo,
      rg: rg ?? this.rg,
      cpfCnpj: cpfCnpj ?? this.cpfCnpj,
      number: number ?? this.number,
      complement: complement ?? this.complement,
      city: city ?? this.city,
      birthday: birthday ?? this.birthday,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Nome': name,
      'Email': email,
      'Senha': password,
      'PerfilId': profileId,
      'TipoId': typeId,
      'contaRedeSocial': socialAccount
    };
  }

  UserEntity fromMap(Map<String, dynamic> map) {
    Map<String, dynamic> mapUser;
    if (map["usuario"] != null)
      mapUser = map["usuario"];
    else
      mapUser = map;
    return UserEntity(
      id: mapUser['id'],
      name: mapUser['nome'],
      email: mapUser['email'],
      rg: mapUser['rg'],
      cpfCnpj: mapUser['cpfCnpj'],
      address: mapUser['endereco'],
      number: mapUser['numero'],
      cep: mapUser['cep'],
      phonenumber: mapUser['telefone'],
      city: mapUser['cidade'],
      photo: mapUser['imagemUrl'],
      uf: mapUser['uf'],
      profileId: mapUser['perfilId'],
      typeId: mapUser['tipoId'],
      birthday: mapUser['dataAniversario'],
      socialAccount: mapUser['contaRedeSocial'],
      active: mapUser['inativo'],
      complement: mapUser['complemento'],
    );
  }

  String toJson() => json.encode(toMap());

  UserEntity fromJson(String source) => fromMap(json.decode(source));
}
