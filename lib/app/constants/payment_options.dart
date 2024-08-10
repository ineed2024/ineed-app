enum PaymentOptions { ticket, creditCard }

extension PaymentOptionsExtensions on PaymentOptions {
  int valueOf() {
    switch (this) {
      case PaymentOptions.creditCard:
        return 1;
        break;
      case PaymentOptions.ticket:
        return 2;
      default:
        return 0;
    }
  }

  String nameOf() {
    switch (this) {
      case PaymentOptions.creditCard:
        return 'Cartão de crédito';
        break;
      case PaymentOptions.ticket:
        return 'Boleto';
      default:
        return 'Nenhum';
    }
  }
}
