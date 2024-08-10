import 'dart:convert';

import 'package:Ineed/domain/entities/auth/sign_in_entity.dart';

extension SignInMapper on SignInEntity {
  SignInEntity copyWith(
      {required String name,
      required String email,
      required String password,
      required int typeId,
      required int profileId}) {
    return SignInEntity(
        name: name,
        email: email,
        password: password,
        profileId: profileId,
        typeId: typeId);
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

  SignInEntity fromMap(Map<String, dynamic> map) {
    return SignInEntity(
      email: map['email'],
      name: map['name'],
      profileId: map['profileId'],
      socialAccount: map['socialAccount'],
      typeId: map['typeId'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  SignInEntity fromJson(String source) => fromMap(json.decode(source));
}
