// import 'dart:convert';

// import 'package:Ineed/domain/entities/auth/update_password_entity.dart';

// extension UpdatePasswordMapper on UpdatePasswordEntity {
//   UpdatePasswordEntity copyWith({
//     String passwordNew,
//     String passwordOld,
//   }) {
//     return UpdatePasswordEntity(
//       passwordNew: passwordNew ?? this.passwordNew,
//       passwordOld: passwordOld ?? this.passwordOld,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'senhaAtual': passwordOld,
//       'novaSenha': passwordNew,
//     };
//   }

//   String toJson() => json.encode(toMap());
// }
