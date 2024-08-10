import 'package:Ineed/domain/entities/auth/update_password_entity.dart';
import 'package:Ineed/domain/repositories/auth/auth_repository.dart';
import 'package:Ineed/domain/usecases/base/base_future_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdatePasswordUseCase
    extends BaseFutureUseCase<UpdatePasswordEntity, ResourceData> {
  AuthRepository _authRepository;
  UpdatePasswordUseCase(this._authRepository);
  @override
  Future<ResourceData> call([UpdatePasswordEntity? entity]) async {
    return await _authRepository.updatePassword(entity!);
  }
}
