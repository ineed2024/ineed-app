import 'package:Ineed/domain/entities/carro/carro_entity.dart';
import 'package:Ineed/domain/entities/carro/config_list_carros.dart';

import '../../utils/resource_data.dart';

abstract class CarroRepository {
  Future<ResourceData<ConfigList>> getListCarros(int? page);
  Future<ResourceData> adicionar(CarroEntity carro);
  Future<ResourceData> alterar(CarroEntity carro);
  Future<ResourceData> excluir(int id);
}
