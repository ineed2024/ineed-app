import 'package:injectable/injectable.dart';
import 'package:Ineed/domain/entities/carro/config_list_carros.dart';
import 'package:Ineed/domain/repositories/carro/carro_repository.dart';
import '../../utils/resource_data.dart';
import '../base/base_future_use_case.dart';

@injectable
class GetListCarrosUseCase
    extends BaseFutureUseCase<int, ResourceData<ConfigList>> {
  CarroRepository carroRepository;

  GetListCarrosUseCase(this.carroRepository);

  @override
  Future<ResourceData<ConfigList>> call([int? params]) {
    return carroRepository.getListCarros(params);
  }
}
