import 'package:Ineed/data/helpers/error_mapper.dart';
import 'package:Ineed/domain/entities/address/address_cep_entity.dart';
import 'package:Ineed/data/mappers/address/address_cep_mapper.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:dio/dio.dart';

class AddressRemoteDataSource {
  Dio _dio;
  AddressRemoteDataSource(this._dio);
  Future<ResourceData<AddressCepEntity>> getAddressCep(cep) async {
    try {
      final result = await _dio.get('https://viacep.com.br/ws/$cep/json/');

      return ResourceData<AddressCepEntity>(
          status: Status.success,
          data: AddressCepEntity().fromMap(result.data));
    } on DioError catch (e) {
      return ResourceData(
          status: Status.failed,
          data: null,
          message: "Erro ao buscar endereço via cep",
          error: ErrorMapper.from(e));
    }
  }
}
