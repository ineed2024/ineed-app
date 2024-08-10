import 'package:Ineed/di/di.dart';
import 'package:Ineed/domain/entities/address/address_cep_entity.dart';
import 'package:Ineed/domain/entities/address/address_entity.dart';
import 'package:Ineed/domain/entities/dropdown/dropdown_item.dart';
import 'package:Ineed/domain/entities/user/user_entity.dart';
import 'package:Ineed/domain/usecases/user/update_address_user_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../domain/usecases/address/get_address_cep_use_case.dart';

part 'address_controller.g.dart';

@Injectable()
class AddressController = _AddressControllerBase with _$AddressController;

abstract class _AddressControllerBase with Store {
  final updateAddressUseCase = getIt.get<UpdateAddressUseCase>();
  final consultAddressFromCEPUseCase = getIt.get<GetAddressCepUseCase>();

  List<DropdownItem> listState = [DropdownItem(value: 1, description: "CE")];
  List<DropdownItem> listCity = [
    DropdownItem(value: 1, description: "Fortaleza")
  ];

  @observable
  String? uf;

  @observable
  String? city;

  @observable
  ResourceData<UserEntity> resourceUser = ResourceData(status: Status.initial);

  @observable
  ResourceData<AddressCepEntity> resourceAddressCep =
      ResourceData(status: Status.initial);

  @action
  setCity(String newCity) {
    city = newCity;
  }

  @action
  setState(String newState) {
    uf = newState;
  }

  Future<ResourceData<UserEntity>> onUpdateAddress(String cep, String address,
      String number, String complement, String uf, String city) async {
    resourceUser = ResourceData(status: Status.loading);
    return resourceUser = await updateAddressUseCase(AddressEntity(
        address: address,
        cep: cep,
        numberAddress: number,
        uf: uf,
        city: city,
        complement: complement));
  }

  Future<ResourceData<AddressCepEntity>> consultAddressFromCEP(
      String cep) async {
    resourceAddressCep = ResourceData(status: Status.loading);
    resourceAddressCep = await consultAddressFromCEPUseCase.call(cep);
    return resourceAddressCep;
  }
}
