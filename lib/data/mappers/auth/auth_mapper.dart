import 'dart:convert';

import 'package:Ineed/domain/entities/auth/auth_entity.dart';

extension AuthMapper on AuthEntity {
  AuthEntity copyWith({
    required String email,
    required String password,
  }) {
    return AuthEntity(
      email: email,
      password: password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  AuthEntity fromMap(Map<String, dynamic> map) {
    return AuthEntity(
      email: map['email'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  AuthEntity fromJson(String source) => fromMap(json.decode(source));
}
