import 'dart:convert';

import 'package:Ineed/domain/entities/auth/authentication_entity.dart';

extension AuthenticationMapper on AuthenticationEntity {
  AuthenticationEntity copyWith({
    String? token,
  }) {
    return AuthenticationEntity(
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'token': token,
    };
  }

  AuthenticationEntity fromMap(Map<String, dynamic> map) {
    return AuthenticationEntity(
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  AuthenticationEntity fromJson(String source) => fromMap(json.decode(source));
}
