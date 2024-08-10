import 'package:Ineed/domain/repositories/solicitation/solicitation_repository.dart';
import 'package:Ineed/domain/usecases/base/base_future_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:Ineed/domain/utils/status.dart';

@injectable
class TotalSolicitationOpenUseCase extends BaseFutureUseCase<void, int> {
  SolicitationRepository _solicitationRepository;

  TotalSolicitationOpenUseCase(this._solicitationRepository);

  @override
  Future<int> call([void params]) async {
    final resource = await _solicitationRepository.getSolicitations();
    if (resource.status == Status.success)
      return resource.data != null
          ? resource.data!.where((element) => element.active!).length
          : 0;
    else
      return 0;
  }
}
