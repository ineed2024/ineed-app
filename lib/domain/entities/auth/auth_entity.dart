import 'package:flutter/foundation.dart';

@immutable
class AuthEntity {
  final String email;
  final String password;

  const AuthEntity({
    required this.email,
    required this.password,
  });
}
