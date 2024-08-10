import 'package:Ineed/domain/entities/carro/carro_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:Ineed/domain/repositories/carro/carro_repository.dart';
import '../../utils/resource_data.dart';
import '../base/base_future_use_case.dart';

@injectable
class AdcionarCarroUseCase
    extends BaseFutureUseCase<CarroEntity, ResourceData> {
  CarroRepository carroRepository;

  AdcionarCarroUseCase(this.carroRepository);

  @override
  Future<ResourceData> call([CarroEntity? params]) {
    return carroRepository.adicionar(params!);
  }
}
