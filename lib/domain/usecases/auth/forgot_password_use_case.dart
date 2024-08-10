import 'package:Ineed/domain/entities/auth/forgot_password_entity.dart';
import 'package:Ineed/domain/repositories/auth/auth_repository.dart';
import 'package:Ineed/domain/usecases/base/base_future_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgotPasswordUseCase extends BaseFutureUseCase<ForgotPasswordEntity,
    ResourceData<ForgotPasswordEntity>> {
  AuthRepository _authRepository;

  ForgotPasswordUseCase(this._authRepository);

  @override
  Future<ResourceData<ForgotPasswordEntity>> call(
      [ForgotPasswordEntity? params]) {
    return _authRepository.forgotPassword(params!.email);
  }
}
