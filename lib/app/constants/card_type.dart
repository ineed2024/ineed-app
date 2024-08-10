enum CardType { debit, credit }

extension CardTypeExtensions on CardType {
  int valueOf() {
    switch (this) {
      case CardType.debit:
        return 1;
      case CardType.credit:
        return 2;
      default:
        return 0;
    }
  }
}
