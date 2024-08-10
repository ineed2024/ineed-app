import 'package:flutter/foundation.dart';

@immutable
class SignInEntity {
  final String name;
  final String email;
  final String password;
  final int profileId;
  final int typeId;
  final bool socialAccount;

  const SignInEntity(
      {required this.name,
      required this.email,
      required this.password,
      this.profileId = 1,
      this.typeId = 1,
      this.socialAccount = false});
}
