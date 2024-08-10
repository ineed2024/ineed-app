import 'package:Ineed/domain/entities/address/address_entity.dart';
import 'package:Ineed/domain/entities/user/create_user_entity.dart';
import 'package:Ineed/domain/entities/user/user_entity.dart';
import 'package:Ineed/domain/utils/resource_data.dart';

abstract class UserRepository {
  Future<ResourceData<UserEntity>> getUser();
  Future<ResourceData<UserEntity>> updateCpfUser(String cpf);
  Future<ResourceData<UserEntity>> updateAddressUser(AddressEntity address);
  Future<ResourceData<UserEntity>> updatePhoneUser(String phone);
  // Future<ResourceData<UserEntity>> createUser(CreateUserEntity user);
  Future<ResourceData> updatePass(String currentPass, String newPass);
  Future<ResourceData> recoverPass(String email);
}
