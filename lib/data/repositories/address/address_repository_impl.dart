import 'package:Ineed/domain/entities/address/address_cep_entity.dart';
import 'package:Ineed/domain/repositories/address/address_repository.dart';
import 'package:Ineed/domain/utils/resource_data.dart';

import '../../data_source/address/address_remote_data_source.dart';

class AddressRepositoryImpl implements AddressRepository {
  AddressRemoteDataSource _addressRemoteDataSource;

  AddressRepositoryImpl(this._addressRemoteDataSource);

  @override
  Future<ResourceData<AddressCepEntity>> getAddressCep(cep) async {
    final resource = await _addressRemoteDataSource.getAddressCep(cep);

    return resource;
  }
}
