import 'package:Ineed/app/utils/validators.dart';
import 'package:Ineed/app/widgets/credit-card/credit_card_widget.dart';
import 'package:Ineed/app/widgets/inputs/underline_text_field_widget.dart';
import 'package:flutter/material.dart';

import '../../../domain/card/create_card_entity.dart';
import '../inputs/upper_case_text_formatter.dart';

// pub: https://github.com/JoseBarreto1/flutter_credit_card_brazilian
class CreditCardForm extends StatefulWidget {
  final Function(CreateCardEntity a) onCreditCardModelChange;
  const CreditCardForm({
    Key? key,
    required this.onCreditCardModelChange,
  }) : super(key: key);

  @override
  _CreditCardFormState createState() => _CreditCardFormState();
}

class _CreditCardFormState extends State<CreditCardForm> {
  final MaskedTextController _cardNumberController =
      MaskedTextController(mask: '0000 0000 0000 0000');
  final TextEditingController _expiryDateController =
      MaskedTextController(mask: '00/0000');
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _cardCustomerHolderNameController =
      TextEditingController();
  final TextEditingController _cvvCodeController =
      MaskedTextController(mask: '0000');

  FocusNode _numberFocusNode = FocusNode();
  FocusNode _expiredDateFocusNode = FocusNode();
  FocusNode _holderNameFocusNode = FocusNode();
  FocusNode _holderCustomerNameFocusNode = FocusNode();
  FocusNode _cvvFocusNode = FocusNode();

  final _scrollController = ScrollController();

  Function onListenerInput() => widget.onCreditCardModelChange(CreateCardEntity(
      cardNumber: _cardNumberController.text,
      expirationDate: _expiryDateController.text,
      holder: _cardHolderNameController.text,
      securityCode: _cvvCodeController.text,
      customerName: _cardCustomerHolderNameController.text));

  @override
  void initState() {
    super.initState();
    _cvvFocusNode.addListener(onListenerInput);
    _cardNumberController.addListener(onListenerInput);
    _expiryDateController.addListener(onListenerInput);
    _cardHolderNameController.addListener(onListenerInput);
    _cardCustomerHolderNameController.addListener(onListenerInput);
    _cvvCodeController.addListener(onListenerInput);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 16, right: 16, bottom: 5),
      child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: ClampingScrollPhysics(),
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 180,
                      child: UnderlineTextFieldWidget(
                        validator: Validators.creditCard,
                        autofocus: true,
                        focusNode: _numberFocusNode,
                        controller: _cardNumberController,
                        keyboardType: TextInputType.number,
                        inputAction: TextInputAction.next,
                        labelText: 'Número do cartão',
                        hint: 'xxxx xxxx xxxx xxxx',
                        onSubmitted: (value) {
                          _scrollController.jumpTo(50);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Container(
                      width: 50,
                      child: UnderlineTextFieldWidget(
                        validator: Validators.validateDate,
                        controller: _expiryDateController,
                        keyboardType: TextInputType.number,
                        inputAction: TextInputAction.next,
                        labelText: 'Venc.',
                        focusNode: _expiredDateFocusNode,
                        hint: 'dd/mmmm',
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Container(
                      width: 50,
                      child: UnderlineTextFieldWidget(
                        focusNode: _cvvFocusNode,
                        controller: _cvvCodeController,
                        validator: Validators.validateCVV,
                        keyboardType: TextInputType.number,
                        inputAction: TextInputAction.next,
                        labelText: 'CVV',
                        hint: '',
                        onChanged: (value) {
                          if (value.length == 3 || value.length == 3)
                            _scrollController.jumpTo(100);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Container(
                      width: 200,
                      child: UnderlineTextFieldWidget(
                          controller: _cardHolderNameController,
                          keyboardType: TextInputType.text,
                          inputAction: TextInputAction.next,
                          focusNode: _holderNameFocusNode,
                          labelText: 'Nome no cartão',
                          hint: 'JOÃO C PEREIRA',
                          inputFormatters: [
                            UpperCaseTextFormatter(),
                          ],
                          onChanged: (value) {
                            if (value.length > 5) _scrollController.jumpTo(180);
                          }),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Container(
                      width: 200,
                      child: UnderlineTextFieldWidget(
                        controller: _cardCustomerHolderNameController,
                        keyboardType: TextInputType.text,
                        inputAction: TextInputAction.done,
                        focusNode: _holderCustomerNameFocusNode,
                        labelText: 'Nome titular completo',
                        hint: 'JOÃO COSTA PEREIRA',
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
                      ),
                    ),
                  ]))),
    );
  }
}
