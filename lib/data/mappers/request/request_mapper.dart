import 'dart:convert';

import 'package:Ineed/domain/entities/request/request_entity.dart';

import 'package:Ineed/domain/entities/user/user_entity.dart';

import '../../../domain/card/card_entity.dart';
import '../../mappers/card/card_mapper.dart';
import '../../mappers/auth/user_mapper.dart';

extension RequestMapper on RequestEntity {
  RequestEntity? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
    Map<String, dynamic> mapRequest;
    if (map["requisicao"] != null)
      mapRequest = map["requisicao"];
    else
      mapRequest = map;
    return RequestEntity(
        user: UserEntity().fromMap(mapRequest['usuario']),
        id: mapRequest['id'],
        merchantOrderId: mapRequest['merchantOrderId'],
        portion: mapRequest['parcela'],
        userId: mapRequest['usuarioId'],
        cardId: mapRequest['cartaoId'],
        installment: mapRequest['parcela'],
        value: double.parse(mapRequest['total'].toString()));
  }
}
