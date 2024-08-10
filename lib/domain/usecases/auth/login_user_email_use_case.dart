import 'package:Ineed/domain/entities/auth/auth_entity.dart';
import 'package:Ineed/domain/entities/auth/authentication_entity.dart';
import 'package:Ineed/domain/repositories/auth/auth_repository.dart';
import 'package:Ineed/domain/usecases/base/base_future_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUserEmailUseCase
    extends BaseFutureUseCase<AuthEntity, ResourceData<AuthenticationEntity>> {
  AuthRepository _authRepository;

  LoginUserEmailUseCase(this._authRepository);

  @override
  Future<ResourceData<AuthenticationEntity>> call([AuthEntity? params]) {
    return _authRepository.loginUserEmail(params!.email, params.password);
  }
}
