import 'package:Ineed/domain/entities/auth/sign_in_entity.dart';
import 'package:Ineed/domain/repositories/auth/auth_repository.dart';
import 'package:Ineed/domain/usecases/base/base_future_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:injectable/injectable.dart';

import '../../entities/user/user_entity.dart';

@injectable
class SignInUseCase
    extends BaseFutureUseCase<SignInEntity, ResourceData<UserEntity>> {
  AuthRepository _authRepository;

  SignInUseCase(this._authRepository);

  @override
  Future<ResourceData<UserEntity>> call([SignInEntity? params]) {
    return _authRepository.signIn(params);
  }
}
