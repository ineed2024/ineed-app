import 'package:Ineed/domain/entities/auth/forgot_password_entity.dart';
import 'package:Ineed/domain/entities/auth/update_password_entity.dart';
import 'package:Ineed/domain/repositories/auth/auth_repository.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:Ineed/domain/entities/auth/authentication_entity.dart';
import 'package:Ineed/domain/utils/status.dart';

import '../../../domain/entities/user/user_entity.dart';
import '../../data_source/auth/auth_local_data_source.dart';
import '../../data_source/auth/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthLocalDataSource _authLocalDataSource;
  AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl(this._authLocalDataSource, this._authRemoteDataSource);

  @override
  Future<ResourceData<AuthenticationEntity>> loginUserEmail(
      email, password) async {
    final resource =
        await _authRemoteDataSource.loginUserEmail(email, password);
    if (resource.status == Status.success)
      _authLocalDataSource.saveToken(resource.data!);
    return resource;
  }

  @override
  Future<ResourceData<ForgotPasswordEntity>> forgotPassword(email) async {
    return await _authRemoteDataSource.forgotPassword(email);
  }

  @override
  Future<ResourceData> updatePassword(entity) async {
    return await _authRemoteDataSource.updatePassword(entity);
  }

  @override
  Future<ResourceData<UserEntity>> signIn(signin) async {
    return await _authRemoteDataSource.signIn(signin);
  }

  @override
  Future<ResourceData> logOut() async {
    final result = await _authRemoteDataSource.logOut();
    await _authLocalDataSource.cleanDataLocal();
    return result;
  }
}
