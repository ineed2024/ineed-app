import 'package:Ineed/data/helpers/error_mapper.dart';
import 'package:Ineed/data/mappers/auth/authentication_mapper.dart';
import 'package:Ineed/data/mappers/auth/sign_in_mapper.dart';
import 'package:Ineed/data/mappers/auth/update_password_mapper%20copy.dart';
import 'package:Ineed/data/mappers/auth/user_mapper.dart';
import 'package:Ineed/data/remote/custom_dio.dart';
import 'package:Ineed/domain/entities/auth/authentication_entity.dart';
import 'package:Ineed/domain/entities/auth/forgot_password_entity.dart';
import 'package:Ineed/domain/entities/auth/sign_in_entity.dart';
import 'package:Ineed/domain/entities/auth/update_password_entity.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:Ineed/domain/utils/app_exception.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/user/user_entity.dart';

@injectable
class AuthRemoteDataSource {
  CustomDio _dio;
  AuthRemoteDataSource(this._dio);

  Future<ResourceData<AuthenticationEntity>> loginUserEmail(
      String email, String password) async {
    try {
      final result =
          await _dio.post('login', data: {"Email": email, "Senha": password});
      if (result["perfilId"] != 1) {
        return ResourceData(
          status: Status.failed,
          data: null,
          error: AppException(
              message:
                  "Você nao tem permissão de usar esta versão do aplicativo "),
        );
      }
      return ResourceData<AuthenticationEntity>(
          status: Status.success, data: AuthenticationEntity().fromMap(result));
    } on DioException catch (e) {
      return ResourceData(
          status: Status.failed,
          data: null,
          message: "Erro ao fazer login",
          error: ErrorMapper.from(e));
    }
  }

  Future<ResourceData<ForgotPasswordEntity>> forgotPassword(
      String email) async {
    try {
      final response =
          await _dio.patch('recuperacaoSenha', data: {"email": email});

      return ResourceData(status: Status.success, message: response["message"]);
    } on DioException catch (e) {
      return ResourceData(
          status: Status.failed,
          data: null,
          message: "Erro ao recuperar senha",
          error: ErrorMapper.from(e));
    }
  }

  Future<ResourceData> updatePassword(UpdatePasswordEntity entity) async {
    try {
      final response =
          await _dio.patch('usuario/atualizarSenha', data: entity.toMap());

      return ResourceData(status: Status.success, message: response["message"]);
    } on DioException catch (e) {
      return ResourceData(
          status: Status.failed,
          data: null,
          message: "Erro ao atualizar a senha",
          error: ErrorMapper.from(e));
    }
  }

  Future<ResourceData<UserEntity>> signIn(SignInEntity entity) async {
    try {
      final data = await _dio.post('usuario/cadastrar', data: entity.toJson());
      return ResourceData<UserEntity>(
          status: Status.success, data: UserEntity().fromMap(data));
    } on DioException catch (e) {
      return ResourceData(
          status: Status.failed,
          data: null,
          message: "Erro ao criar conta",
          error: ErrorMapper.from(e));
    }
  }

  Future<ResourceData> logOut() async {
    try {
      final result = await _dio.post('logout');
      return ResourceData(status: Status.success, message: result["message"]);
    } on DioException catch (e) {
      return ResourceData(
          status: Status.failed,
          data: null,
          message: "Erro ao fazer logOut",
          error: ErrorMapper.from(e));
    }
  }
}
