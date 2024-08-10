import 'package:Ineed/domain/entities/auth/authentication_entity.dart';
import 'package:Ineed/domain/entities/auth/update_password_entity.dart';
import 'package:Ineed/domain/utils/resource_data.dart';

import '../../entities/auth/forgot_password_entity.dart';
import '../../entities/user/user_entity.dart';

abstract class AuthRepository {
  Future<ResourceData<AuthenticationEntity>> loginUserEmail(email, password);
  Future<ResourceData> updatePassword(UpdatePasswordEntity entity);
  Future<ResourceData<ForgotPasswordEntity>> forgotPassword(email);
  Future<ResourceData<UserEntity>> signIn(signin);
  Future<ResourceData> logOut();
}
