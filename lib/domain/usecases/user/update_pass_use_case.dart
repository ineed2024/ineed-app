import 'package:Ineed/domain/repositories/user/user_repository.dart';
import 'package:Ineed/domain/usecases/base/base_future_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdatePassUseCase extends BaseFutureUseCase<String, ResourceData> {
  UserRepository _userRepository;
  UpdatePassUseCase(this._userRepository);
  @override
  Future<ResourceData> call([String? currentPass, newPass]) async {
    return await _userRepository.updatePass(currentPass!, newPass);
  }
}
