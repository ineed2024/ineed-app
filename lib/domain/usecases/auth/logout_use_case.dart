import 'package:Ineed/domain/repositories/auth/auth_repository.dart';
import 'package:Ineed/domain/usecases/base/base_future_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUseCase extends BaseFutureUseCase<void, ResourceData> {
  AuthRepository _authRepository;
  LogoutUseCase(this._authRepository);
  @override
  Future<ResourceData> call([void params]) async {
    return await _authRepository.logOut();
  }
}
