import 'package:flutter/foundation.dart';

@immutable
class UpdatePasswordEntity {
  final String passwordOld;
  final String passwordNew;

  UpdatePasswordEntity({
    required this.passwordOld,
    required this.passwordNew,
  });
}
