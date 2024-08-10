import 'package:Ineed/domain/entities/address/address_cep_entity.dart';
import 'package:Ineed/domain/repositories/address/address_repository.dart';
import 'package:Ineed/domain/usecases/base/base_future_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAddressCepUseCase
    extends BaseFutureUseCase<String, ResourceData<AddressCepEntity>> {
  AddressRepository _addressRepository;
  GetAddressCepUseCase(this._addressRepository);
  @override
  Future<ResourceData<AddressCepEntity>> call([String? cep]) async {
    return await _addressRepository.getAddressCep(cep);
  }
}
