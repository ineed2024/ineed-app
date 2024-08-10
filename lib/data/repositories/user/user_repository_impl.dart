import 'package:Ineed/domain/entities/address/address_entity.dart';
import 'package:Ineed/domain/entities/user/create_user_entity.dart';
import 'package:Ineed/domain/entities/user/user_entity.dart';
import 'package:Ineed/domain/repositories/user/user_repository.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:Ineed/domain/utils/status.dart';

import '../../data_source/user/user_local_data_source.dart';
import '../../data_source/user/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  UserLocalDataSource _userLocalDataSource;
  UserRemoteDataSource _userRemoteDataSource;

  UserRepositoryImpl(this._userRemoteDataSource, this._userLocalDataSource);

  @override
  Future<ResourceData<UserEntity>> getUser() async {
    final resource = await _userRemoteDataSource.getUser();

    if (resource.status == Status.success)
      _userLocalDataSource.saveUser(resource.data!);
    return resource;
  }

  @override
  Future<ResourceData<UserEntity>> updateCpfUser(String cpf) async {
    final resource = await _userRemoteDataSource.updateCpfUser(cpf);

    return resource;
  }

  @override
  Future<ResourceData<UserEntity>> updateAddressUser(
      AddressEntity address) async {
    final resource = await _userRemoteDataSource.updateAddressUser(address);

    return resource;
  }

  @override
  Future<ResourceData<UserEntity>> updatePhoneUser(String phone) async {
    final resource = await _userRemoteDataSource.updatePhoneUser(phone);

    return resource;
  }

  // Future<ResourceData<UserEntity>> createUser(CreateUserEntity user) async {
  //   final resource = await _userRemoteDataSource.createUser(user);

  //   return resource;
  // }

  Future<ResourceData> updatePass(String currentPass, String newPass) async {
    final resource =
        await _userRemoteDataSource.updatePass(currentPass, newPass);

    return resource;
  }

  Future<ResourceData> recoverPass(String email) async {
    final resource = await _userRemoteDataSource.recoverPass(email);

    return resource;
  }
}
