import 'package:Ineed/domain/entities/user/user_entity.dart';
import 'package:Ineed/domain/repositories/user/user_repository.dart';
import 'package:Ineed/domain/usecases/base/base_future_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateCpfUseCase
    extends BaseFutureUseCase<String, ResourceData<UserEntity>> {
  UserRepository _userRepository;
  UpdateCpfUseCase(this._userRepository);
  @override
  Future<ResourceData<UserEntity>> call([String? params]) async {
    return await _userRepository.updateCpfUser(params!);
  }
}
