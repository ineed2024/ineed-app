import 'package:flutter/foundation.dart';

@immutable
class CreateUserEntity {
  final String name;
  final String email;
  final String pass;
  final int idProfile;
  final int idType;

  CreateUserEntity(
      {required this.name,
      required this.email,
      required this.pass,
      required this.idProfile,
      required this.idType});
}
