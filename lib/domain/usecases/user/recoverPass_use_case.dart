import 'package:Ineed/domain/repositories/user/user_repository.dart';
import 'package:Ineed/domain/usecases/base/base_future_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:injectable/injectable.dart';

@injectable
class RecoverPassUseCase extends BaseFutureUseCase<String, ResourceData> {
  UserRepository _userRepository;
  RecoverPassUseCase(this._userRepository);
  @override
  Future<ResourceData> call([String? params]) async {
    return await _userRepository.recoverPass(params!);
  }
}
