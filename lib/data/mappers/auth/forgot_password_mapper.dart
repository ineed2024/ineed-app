import 'dart:convert';

import 'package:Ineed/domain/entities/auth/forgot_password_entity.dart';

extension ForgotPasswordMapper on ForgotPasswordEntity {
  ForgotPasswordEntity copyWith({
    required String email,
  }) {
    return ForgotPasswordEntity(
      email: email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
    };
  }

  ForgotPasswordEntity fromMap(Map<String, dynamic> map) {
    return ForgotPasswordEntity(
      email: map['email'],
    );
  }
}
