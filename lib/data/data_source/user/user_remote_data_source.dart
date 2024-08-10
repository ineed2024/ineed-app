import 'package:Ineed/data/helpers/error_mapper.dart';
import 'package:Ineed/data/remote/custom_dio.dart';
import 'package:Ineed/domain/entities/user/create_user_entity.dart';
import 'package:Ineed/domain/entities/user/user_entity.dart';
import 'package:Ineed/data/mappers/auth/user_mapper.dart';
import 'package:Ineed/data/mappers/address/address_mapper.dart';
import 'package:Ineed/data/mappers/auth/user_mapper.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:dio/dio.dart';

import '../../../domain/entities/address/address_entity.dart';

class UserRemoteDataSource {
  CustomDio _dio;
  UserRemoteDataSource(this._dio);
  Future<ResourceData<UserEntity>> getUser() async {
    try {
      final result = await _dio.get('usuario/listar');
      return ResourceData<UserEntity>(
          status: Status.success, data: UserEntity().fromMap(result));
    } on DioError catch (e) {
      return ResourceData(
          status: Status.failed,
          data: null,
          message: "Erro ao buscar as informações de usuario",
          error: ErrorMapper.from(e));
    }
  }

  Future<ResourceData<UserEntity>> updateCpfUser(String cpf) async {
    try {
      final result =
          await _dio.put('usuario/atualizar/atributo', data: {"CpfCnpj": cpf});
      return ResourceData<UserEntity>(
          status: Status.success,
          data: UserEntity().fromMap(result["usuario"]),
          message: result["message"]);
    } on DioError catch (e) {
      return ResourceData(
          status: Status.failed,
          data: null,
          message: "Erro atualizar cpf do usuario",
          error: ErrorMapper.from(e));
    }
  }

  Future<ResourceData<UserEntity>> updateAddressUser(
      AddressEntity endereco) async {
    try {
      final result =
          await _dio.put('usuario/atualizar/atributo', data: endereco.toMap());
      return ResourceData<UserEntity>(
          status: Status.success,
          data: UserEntity().fromMap(result["usuario"]),
          message: result["message"]);
    } on DioError catch (e) {
      return ResourceData(
          status: Status.failed,
          data: null,
          message: "Erro atualizar o endereço do usuario",
          error: ErrorMapper.from(e));
    }
  }

  Future<ResourceData<UserEntity>> updatePhoneUser(String phone) async {
    try {
      final result = await _dio
          .put('usuario/atualizar/atributo', data: {"telefone": phone});
      return ResourceData<UserEntity>(
          status: Status.success,
          data: UserEntity().fromMap(result["usuario"]),
          message: result["message"]);
    } on DioError catch (e) {
      return ResourceData(
          status: Status.failed,
          data: null,
          message: "Erro atualizar o telefone do usuario",
          error: ErrorMapper.from(e));
    }
  }

  // Future<ResourceData<UserEntity>> createUser(CreateUserEntity user) async {
  //   try {
  //     final result = await _dio.post('usuario/cadastrar', data: user.toMap());
  //     return ResourceData<UserEntity>(
  //         status: Status.success,
  //         data: UserEntity().fromMap(result["usuario"]),
  //         message: result["message"]);
  //   } on DioError catch (e) {
  //     return ResourceData(
  //         status: Status.failed,
  //         data: null,
  //         message: "Erro ao criar usuario",
  //         error: ErrorMapper.from(e));
  //   }
  // }

  Future<ResourceData> updatePass(String currentPass, String newPass) async {
    try {
      final result = await _dio.patch('usuario/atualizarSenha',
          data: {"senhaAtual": currentPass, "novaSenha": newPass});
      return ResourceData(status: Status.success, message: result["message"]);
    } on DioError catch (e) {
      return ResourceData(
          status: Status.failed,
          data: null,
          message: "Erro ao criar usuario",
          error: ErrorMapper.from(e));
    }
  }

  Future<ResourceData> recoverPass(String email) async {
    try {
      final result =
          await _dio.patch('recuperacaoSenha', data: {"email": email});
      return ResourceData(status: Status.success, message: result["message"]);
    } on DioError catch (e) {
      return ResourceData(
          status: Status.failed,
          data: null,
          message: "Erro ao criar usuario",
          error: ErrorMapper.from(e));
    }
  }
}
