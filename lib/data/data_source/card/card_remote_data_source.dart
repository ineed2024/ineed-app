import 'package:Ineed/data/helpers/error_mapper.dart';
import 'package:Ineed/data/remote/custom_dio.dart';

import 'package:Ineed/data/mappers/card/card_mapper.dart';
import 'package:Ineed/domain/utils/resource_data.dart';
import 'package:Ineed/domain/utils/status.dart';
import 'package:dio/dio.dart';

import '../../../app/modules/user/cards/create-card/payment_token.dart';
import '../../../app/utils/credit_card_utils.dart';
import '../../../domain/card/card_entity.dart';
import '../../../domain/card/create_card_entity.dart';

class CardRemoteDataSource {
  CustomDio _dio;
  CardRemoteDataSource(this._dio);
  Future<ResourceData<CardEntity>> createCard(CreateCardEntity card) async {
    try {
      var paymentToken = await getPaymentToken(card);
      final result = await _dio.post('cartoes', data: {
        "NumberMask": paymentToken["data"]["card_mask"],
        "CardToken": paymentToken['data']["payment_token"],
        "Inativo": false
      });
      return ResourceData<CardEntity>(status: Status.success, data: null);
    } on DioError catch (e) {
      return ResourceData(
          status: Status.failed,
          data: null,
          message: "Erro ao criar um Cartão",
          error: ErrorMapper.from(e));
    }
  }

  Future<dynamic> getPaymentToken(CreateCardEntity card) async {
    PaymentToken _PaymentToken = PaymentToken();
    card.brand = CreditCardUtils.getCardTypeName(card.cardNumber);
    var paymentToken = await PaymentToken.generate(card.toMap(), {
      'client_id': 'Client_Id_2c201586daeb7a781c0d04f2195755ffdd56420e',
      'client_secret': 'Client_Secret_9cb1ec2674c807119a520d24f6f5c2575c4b4fca',
      'sandbox': true,
      'accountId': '88774ecb62a9423f563d1aea27cbf1a0'
    });

    return paymentToken;
  }

  Future<ResourceData<List<CardEntity>>> getCards() async {
    try {
      final result = await _dio.get('cartoes');
      var teste = CardEntity().fromMapList(result);
      return ResourceData<List<CardEntity>>(
          status: Status.success, data: teste);
    } on DioError catch (e) {
      return ResourceData(
          status: Status.failed,
          data: null,
          message: "Erro ao listar os Cartões",
          error: ErrorMapper.from(e));
    }
  }

  Future<ResourceData> deleteCard(int idCard) async {
    try {
      final result = await _dio.delete('cartoes?Id=${idCard}');
      return ResourceData(status: Status.success, message: result["message"]);
    } on DioError catch (e) {
      return ResourceData(
          status: Status.failed,
          data: null,
          message: "Erro ao excluir um Cartão",
          error: ErrorMapper.from(e));
    }
  }

  Future<ResourceData<CardEntity>> getCard(int idCard) async {
    try {
      final result = await _dio.get('cartoes?Id=${idCard}');
      return ResourceData<CardEntity>(
          status: Status.success, data: CardEntity().fromMap(result));
    } on DioError catch (e) {
      return ResourceData(
          status: Status.failed,
          data: null,
          message: "Erro ao listar um Cartão",
          error: ErrorMapper.from(e));
    }
  }
}
