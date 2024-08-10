import 'package:Ineed/domain/entities/user/user_entity.dart';
import 'package:Ineed/domain/repositories/user/user_repository.dart';
import 'package:Ineed/domain/usecases/base/base_future_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileUserUseCase
    extends BaseFutureUseCase<void, ResourceData<UserEntity>> {
  UserRepository _userRepository;

  ProfileUserUseCase(this._userRepository);

  @override
  Future<ResourceData<UserEntity>> call([void params]) async {
    return await _userRepository.getUser();
  }
}
