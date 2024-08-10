import 'package:injectable/injectable.dart';
import 'package:Ineed/domain/repositories/carro/carro_repository.dart';
import '../../utils/resource_data.dart';
import '../base/base_future_use_case.dart';

@injectable
class ExcluirCarroUseCase extends BaseFutureUseCase<int, ResourceData> {
  CarroRepository carroRepository;

  ExcluirCarroUseCase(this.carroRepository);

  @override
  Future<ResourceData> call([int? params]) {
    return carroRepository.excluir(params!);
  }
}
