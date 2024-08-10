import 'package:Ineed/di/di.dart';
import 'package:Ineed/domain/usecases/card/create_card_use_case.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:efipay/efipay.dart';

import '../../../../../domain/card/card_entity.dart';
import '../../../../../domain/card/create_card_entity.dart';
import '../../../../utils/credit_card_utils.dart';
import 'payment_token.dart';

part 'create_card_controller.g.dart';

@Injectable()
class CreateCardController = _CreateCardControllerBase
    with _$CreateCardController;

abstract class _CreateCardControllerBase with Store {
  final _createCardUseCase = getIt.get<CreateCardUseCase>();
  var config = {
    'client_id': 'Client_Id_2c201586daeb7a781c0d04f2195755ffdd56420e',
    'client_secret': 'Client_Secret_9cb1ec2674c807119a520d24f6f5c2575c4b4fca',
    'sandbox': true,
    'certificate': 'PATH_CERTIFICATE_IN_PROJECT',
    'accountId': '88774ecb62a9423f563d1aea27cbf1a0'
  };

  EfiPay? efipay;

  @observable
  CreateCardEntity? createCardEntity;

  @observable
  ResourceData<CardEntity> resourceCard = ResourceData(status: Status.initial);

  @observable
  bool isButtonEnable = true;

  @action
  Future<ResourceData<CardEntity>> createCard() async {
    resourceCard = ResourceData(status: Status.loading);
    return resourceCard = await _createCardUseCase(createCardEntity!
      ..brand = CreditCardUtils.getCardTypeName(createCardEntity!.cardNumber));
  }

  @action
  setCreateCardEntity(CreateCardEntity newCardEntity) {
    if (newCardEntity.cardNumber.isNotEmpty &&
        (newCardEntity.expirationDate.isNotEmpty &&
            newCardEntity.expirationDate.length == 7) &&
        newCardEntity.customerName.isNotEmpty &&
        newCardEntity.securityCode.isNotEmpty &&
        newCardEntity.holder.isNotEmpty)
      isButtonEnable = true;
    else
      isButtonEnable = false;
    createCardEntity = newCardEntity;
  }
}
