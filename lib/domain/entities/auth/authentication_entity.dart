import 'package:flutter/foundation.dart';

@immutable
class AuthenticationEntity {
  final String? token;

  const AuthenticationEntity({
    this.token,
  });
}
