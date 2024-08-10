import 'dart:convert';

import 'package:Ineed/domain/entities/collaborator/collaborator_entity.dart';

extension CollaboratorMapper on CollaboratorEntity {
  CollaboratorEntity copyWith(
      {int? id,
      String? name,
      String? email,
      String? pass,
      String? rg,
      String? cpf,
      String? address,
      int? numberAddress,
      String? cep,
      String? phone,
      String? city,
      String? imageUrl,
      String? uf,
      int? profileId,
      int? typeId,
      String? birthday,
      bool? socialNetworkAccount,
      bool? active,
      String? complement,
      int? couponId}) {
    return CollaboratorEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        pass: pass ?? this.pass,
        rg: rg ?? this.rg,
        cpf: cpf ?? this.cpf,
        address: address ?? this.address,
        numberAddress: numberAddress ?? this.numberAddress,
        cep: cep ?? this.cep,
        phone: phone ?? this.phone,
        city: city ?? this.city,
        imageUrl: imageUrl ?? this.imageUrl,
        uf: uf ?? this.uf,
        profileId: profileId ?? this.profileId,
        typeId: typeId ?? this.typeId,
        birthday: birthday ?? this.birthday,
        socialNetworkAccount: socialNetworkAccount ?? this.socialNetworkAccount,
        active: active ?? this.active,
        complement: complement ?? this.complement,
        couponId: couponId ?? this.couponId);
  }

  /*Map<String, dynamic> toMap() {
    return {
      'id': id,
      'maximoParcelas': maxParcels,
      'taxaVisitasUrgentes': urgentVisitsRate,
      'maximoOrcamentos': maxBudget,
      'descontoPadrao': standardDiscount,
      'usoRestanteCupom': useRemainingCoupon,
      'diasValidadeCupom': daysUseCouponValidity,
      'maximoCupomDescontoDeUsuarios': maxCupomDiscountUsers,
    };
  }*/

  List<CollaboratorEntity> fromMapList(List<dynamic> data) =>
      List.from(data).map((element) => fromMap(element)).toList();

  CollaboratorEntity fromMap(Map<String, dynamic> map) {
    Map<String, dynamic> mapCollaborator;

    mapCollaborator = map;
    return CollaboratorEntity(
        id: mapCollaborator['id'],
        name: mapCollaborator['nome'],
        email: mapCollaborator['email'],
        pass: mapCollaborator['senha'],
        rg: mapCollaborator['rg'],
        cpf: mapCollaborator['cpf'],
        address: mapCollaborator['endereco'],
        numberAddress: mapCollaborator['numero'],
        cep: mapCollaborator['cep'],
        phone: mapCollaborator['telefone'],
        city: mapCollaborator['cidade'],
        imageUrl: mapCollaborator['imagemUrl'],
        uf: mapCollaborator['uf'],
        profileId: mapCollaborator['perfilId'],
        typeId: mapCollaborator['tipoId'],
        birthday: mapCollaborator['dataAniversario'],
        socialNetworkAccount: mapCollaborator['contaRedeSocial'],
        active: mapCollaborator['inativo'] != null
            ? !mapCollaborator['inativo']
            : null,
        complement: mapCollaborator['complemento'],
        couponId: mapCollaborator['cupomId']);
  }

  // String toJson() => json.encode(toMap());

  CollaboratorEntity fromJson(String source) => fromMap(json.decode(source));
}
