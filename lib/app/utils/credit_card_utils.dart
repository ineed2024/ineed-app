class CreditCardUtils {
  static String getCardTypeName(String cardNumber) {
/*
 'visa', 'mastercard', 'amex', 'diners', 'elo' ou 'hipercard'.
*/

    String name = '';
    switch (detectCCType(cardNumber)) {
      case CardType.visa:
        name = 'visa';
        break;
      case CardType.americanExpress:
        name = 'amex';
        break;
      case CardType.mastercard:
        name = 'mastercard';
        break;
      // case CardType.discover:
      //   name = 'DISCOVER';
      //   break;
      // case CardType.assomise:
      //   name = 'ASSOMISE';
      //   break;
      // // case CardType.aura:
      // //   name = 'AURA';
      // //   break;
      case CardType.dinersclub:
        name = 'diners';
        break;
      // case CardType.fortbrasil:
      //   name = 'FORTBRASIL';
      //   break;
      case CardType.elo:
        name = 'elo';
        break;
      // case CardType.hiper:
      //   name = 'HIPER';
      //   break;
      case CardType.hipercard:
        name = 'hipercard';
        break;
    }
    return name;
  }

  /// This function determines the Credit Card type based on the cardPatterns
  /// and returns it.
  static CardType detectCCType(String cardNumber) {
    //Default card type is other
    CardType cardType = CardType.otherBrand;

    if (cardNumber.isEmpty) {
      return cardType;
    }

    cardNumPatterns.forEach(
      (CardType type, Set<List<String>> patterns) {
        for (List<String> patternRange in patterns) {
          // Remove any spaces
          String ccPatternStr =
              cardNumber.replaceAll(RegExp(r'\s+\b|\b\s'), '');
          final int rangeLen = patternRange[0].length;
          // Trim the Credit Card number string to match the pattern prefix length
          if (rangeLen < cardNumber.length) {
            ccPatternStr = ccPatternStr.substring(0, rangeLen);
          }

          if (patternRange.length > 1) {
            // Convert the prefix range into numbers then make sure the
            // Credit Card num is in the pattern range.
            // Because Strings don't have '>=' type operators
            final int ccPrefixAsInt = int.parse(ccPatternStr);
            final int startPatternPrefixAsInt = int.parse(patternRange[0]);
            final int endPatternPrefixAsInt = int.parse(patternRange[1]);
            if (ccPrefixAsInt >= startPatternPrefixAsInt &&
                ccPrefixAsInt <= endPatternPrefixAsInt) {
              // Found a match
              cardType = type;
              break;
            }
          } else {
            // Just compare the single pattern prefix with the Credit Card prefix
            if (ccPatternStr == patternRange[0]) {
              // Found a match
              cardType = type;
              break;
            }
          }
        }
      },
    );

    return cardType;
  }

  /// Credit Card prefix patterns as of March 2019
  /// A [List<String>] represents a range.
  /// i.e. ['51', '55'] represents the range of cards starting with '51' to those starting with '55'
  static Map<CardType, Set<List<String>>> cardNumPatterns =
      <CardType, Set<List<String>>>{
    CardType.aura: <List<String>>{
      <String>['50'],
    },
    CardType.visa: <List<String>>{
      <String>['4'],
    },
    CardType.americanExpress: <List<String>>{
      <String>['34'],
      <String>['37'],
    },
    CardType.discover: <List<String>>{
      <String>['6011'],
      <String>['622126', '622925'],
      <String>['644', '649'],
      <String>['65']
    },
    CardType.mastercard: <List<String>>{
      <String>['51', '55'],
      <String>['2221', '2229'],
      <String>['223', '229'],
      <String>['23', '26'],
      <String>['270', '271'],
      <String>['2720'],
    },
    CardType.dinersclub: <List<String>>{
      <String>['30'],
      <String>['300', '305'],
      <String>['36'],
      <String>['38'],
      <String>['39'],
    },
    CardType.jcb: {
      <String>['3506', '3589'],
      <String>['2131'],
      <String>['1800'],
    },
    CardType.elo: {
      <String>['4011'],
      <String>['401178'],
      <String>['401179'],
      <String>['438935'],
      <String>['457631'],
      <String>['457632'],
      <String>['431274'],
      <String>['451416'],
      <String>['457393'],
      <String>['504175'],
      <String>['506699', '506778'],
      <String>['509000', '509999'],
      <String>['627780'],
      <String>['636297'],
      <String>['636368'],
      <String>['650031', '650033'],
      <String>['650035', '650051'],
      <String>['650405', '650439'],
      <String>['650485', '650538'],
      <String>['650541', '650598'],
      <String>['650700', '650718'],
      <String>['650720', '650727'],
      <String>['650901', '650978'],
      <String>['651652', '651679'],
      <String>['655000', '655019'],
      <String>['655021', '655058'],
      <String>['6555'],
    },
    CardType.hiper: {
      <String>['637095'],
      <String>['637568'],
      <String>['637599'],
      <String>['637609'],
      <String>['637612'],
    },
    CardType.assomise: {
      <String>['639595'],
      <String>['608732'],
    },
    CardType.fortbrasil: {
      <String>['628167'],
    },
    CardType.sorocred: {
      <String>['627892'],
      <String>['606014'],
      <String>['636414'],
    },
    CardType.realcard: {
      <String>['637176'],
    },
    CardType.hipercard: {
      <String>['6062'],
      <String>['384100'],
      <String>['384140'],
      <String>['384160'],
    },
    CardType.credishop: {
      <String>['603136'],
      <String>['603134'],
      <String>['603135'],
    },
    CardType.banese: {
      <String>['6366'],
      <String>['6361'],
      <String>['6374']
    },
  };
}

enum CardType {
  otherBrand,
  mastercard,
  visa,
  americanExpress,
  discover,
  realcard,
  elo,
  assomise,
  dinersclub,
  fortbrasil,
  hiper,
  hipercard,
  jcb,
  sorocred,
  banese,
  credishop,
  aura,
}
