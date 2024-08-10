import 'package:Ineed/domain/entities/address/address_cep_entity.dart';
import 'package:Ineed/domain/utils/resource_data.dart';

abstract class AddressRepository {
  Future<ResourceData<AddressCepEntity>> getAddressCep(cep);
}
