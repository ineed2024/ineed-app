import 'dart:math';

import 'package:Ineed/app/styles/app_color_scheme.dart';
import 'package:Ineed/app/utils/credit_card_utils.dart';
import 'package:Ineed/app/widgets/credit-card/localized_text.dart';
import 'package:flutter/material.dart';

// pub: https://github.com/JoseBarreto1/flutter_credit_card_brazilian
class CreditCardWidget extends StatefulWidget {
  const CreditCardWidget({
    Key? key,
    this.cardNumber,
    this.expiryDate,
    this.cardHolderName,
    this.cvvCode,
    required this.showBackView,
    this.customerName,
    this.animationDuration = const Duration(milliseconds: 500),
    this.textStyle,
    this.cardBgColor = AppColorScheme.primaryColor,
    this.localizedText = const LocalizedText(),
  })  : assert(cardNumber != null),
        assert(showBackView != null),
        super(key: key);

  final String? cardNumber;
  final String? expiryDate;
  final String? cardHolderName;
  final String? customerName;
  final String? cvvCode;
  final TextStyle? textStyle;
  final Color cardBgColor;
  final bool showBackView;
  final Duration? animationDuration;
  final LocalizedText? localizedText;
  @override
  _CreditCardWidgetState createState() => _CreditCardWidgetState();
}

class _CreditCardWidgetState extends State<CreditCardWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _frontRotation;
  Animation<double>? _backRotation;
  Gradient? backgroundGradientColor;
  bool statusNameCard = true;
  bool isAmex = false;

  @override
  void initState() {
    super.initState();

    ///initialize the animation controller
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    backgroundGradientColor = LinearGradient(
      // Where the linear gradient begins and ends
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      // Add one stop for each color. Stops should increase from 0 to 1
      stops: const <double>[0.1, 0.4, 0.7, 0.9],
      colors: <Color>[
        widget.cardBgColor.withOpacity(1),
        widget.cardBgColor.withOpacity(0.97),
        widget.cardBgColor.withOpacity(0.90),
        widget.cardBgColor.withOpacity(0.86),
      ],
    );

    ///Initialize the Front to back rotation tween sequence.
    _frontRotation = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: pi / 2)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(pi / 2),
          weight: 50.0,
        ),
      ],
    ).animate(_animationController!);

    _backRotation = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(pi / 2),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: -pi / 2, end: 0.0)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 50.0,
        ),
      ],
    ).animate(_animationController!);
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double heightCard = MediaQuery.of(context).size.height / 4;
    final double widthCard = MediaQuery.of(context).size.width;
    final Orientation orientation = MediaQuery.of(context).orientation;

    ///
    /// If uer adds CVV then toggle the card from front to back..
    /// controller forward starts animation and shows back layout.
    /// controller reverse starts animation and shows front layout.
    ///
    if (widget.showBackView) {
      _animationController!.forward();
    } else {
      _animationController!.reverse();
    }

    return Stack(
      children: <Widget>[
        AnimationCard(
          animation: _frontRotation!,
          child:
              buildFrontContainer(widthCard, heightCard, context, orientation),
        ),
        AnimationCard(
          animation: _backRotation!,
          child:
              buildBackContainer(widthCard, heightCard, context, orientation),
        ),
      ],
    );
  }

  ///
  /// Builds a back container containing cvv
  ///
  Container buildBackContainer(
    double widthCard,
    double heightCard,
    BuildContext context,
    Orientation orientation,
  ) {
    final TextStyle defaultTextStyle =
        Theme.of(context).textTheme.bodyText1!.merge(
              TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            );

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 0),
            blurRadius: 24,
          ),
        ],
        gradient: backgroundGradientColor,
      ),
      margin: const EdgeInsets.all(16),
      width: widthCard,
      height: heightCard,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.only(top: 16),
              height: 48,
              color: Colors.black,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.only(top: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 9,
                    child: Container(
                      height: 48,
                      color: Colors.white70,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          widget.cvvCode!.isEmpty
                              ? isAmex
                                  ? 'XXXX'
                                  : widget.localizedText!.cvvHint
                              : widget.cvvCode!,
                          maxLines: 1,
                          style: widget.textStyle ?? defaultTextStyle,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: getCardTypeIcon(widget.cardNumber!),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// Builds a front container containing
  /// Card number, Exp. year and Card holder name
  ///
  Container buildFrontContainer(
    double widthCard,
    double heightCard,
    BuildContext context,
    Orientation orientation,
  ) {
    final TextStyle defaultTextStyle =
        Theme.of(context).textTheme.bodyText1!.merge(
              TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            );

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 0),
            blurRadius: 24,
          )
        ],
        gradient: backgroundGradientColor,
      ),
      width: widthCard,
      height: heightCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
              child: getCardTypeIcon(widget.cardNumber!),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                widget.cardNumber!.isEmpty || widget.cardNumber == null
                    ? widget.localizedText!.cardNumberHint
                    : widget.cardNumber!,
                style: widget.textStyle ?? defaultTextStyle,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                widget.expiryDate!.isEmpty || widget.expiryDate! == null
                    ? widget.localizedText!.expiryDateHint
                    : widget.expiryDate!,
                style: widget.textStyle ?? defaultTextStyle,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Text(
                widget.cardHolderName!.isEmpty || widget.cardHolderName == null
                    ? widget.localizedText!.cardHolderLabel.toUpperCase()
                    : widget.cardHolderName!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: widget.textStyle ?? defaultTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // This method returns the icon for the visa card type if found
  // else will return the empty container
  Widget getCardTypeIcon(String cardNumber) {
    if (cardNumber.length > 16 && statusNameCard) {
      if (cardNumber.length == 18) {
        statusNameCard = false;
      }
    } else if (cardNumber.length > 15 && cardNumber.length < 18) {
      statusNameCard = true;
    }
    Widget icon;
    switch (CreditCardUtils.detectCCType(cardNumber)) {
      case CardType.visa:
        icon = Image.asset(
          'assets/images/brand-card/visa.png',
          height: 28,
          width: 28,
        );
        isAmex = false;
        break;

      case CardType.americanExpress:
        icon = Image.asset(
          'assets/images/brand-card/amex.png',
          height: 28,
          width: 28,
        );
        isAmex = true;
        break;

      case CardType.mastercard:
        icon = Image.asset(
          'assets/images/brand-card/mastercard.png',
          height: 28,
          width: 28,
        );
        isAmex = false;
        break;

      case CardType.discover:
        icon = Image.asset(
          'assets/images/brand-card/discover.png',
          height: 28,
          width: 28,
        );
        isAmex = false;
        break;

      case CardType.assomise:
        icon = Image.asset(
          'assets/images/brand-card/assomise.png',
          height: 28,
          width: 28,
        );
        isAmex = false;
        break;

      case CardType.aura:
        icon = Image.asset(
          'assets/images/brand-card/aura.png',
          height: 28,
          width: 28,
        );
        isAmex = false;
        break;

      case CardType.dinersclub:
        icon = Image.asset(
          'assets/images/brand-card/dinersclub.png',
          height: 28,
          width: 28,
        );
        isAmex = false;
        break;

      case CardType.fortbrasil:
        icon = Image.asset(
          'assets/images/brand-card/fortbrasil.png',
          height: 28,
          width: 28,
        );
        isAmex = false;
        break;

      case CardType.elo:
        icon = Image.asset(
          'assets/images/brand-card/elo.png',
          height: 28,
          width: 28,
        );
        isAmex = false;
        break;

      case CardType.hiper:
        icon = Image.asset(
          'assets/images/brand-card/hiper.png',
          height: 28,
          width: 28,
        );
        isAmex = false;
        break;

      case CardType.hipercard:
        icon = Image.asset(
          'assets/images/brand-card/hipercard.png',
          height: 28,
          width: 28,
        );
        isAmex = false;
        break;

      case CardType.jcb:
        icon = Image.asset(
          'assets/images/brand-card/jcb.png',
          height: 28,
          width: 28,
        );
        isAmex = false;
        break;

      case CardType.sorocred:
        icon = Image.asset(
          'assets/images/brand-card/sorocred.png',
          height: 28,
          width: 28,
        );
        isAmex = false;
        break;

      case CardType.realcard:
        icon = Image.asset(
          'assets/images/brand-card/realcard.png',
          height: 28,
          width: 28,
        );
        isAmex = false;
        break;

      case CardType.credishop:
        icon = Image.asset(
          'assets/images/brand-card/credishop.png',
          height: 28,
          width: 28,
        );
        isAmex = false;
        break;

      case CardType.banese:
        icon = Image.asset(
          'assets/images/brand-card/banese.png',
          height: 28,
          width: 28,
        );
        isAmex = false;
        break;

      default:
        icon = Container(
          height: 28,
          width: 28,
        );
        isAmex = false;
        break;
    }

    return icon;
  }
}

class AnimationCard extends StatelessWidget {
  const AnimationCard({
    required this.child,
    required this.animation,
  });

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        final Matrix4 transform = Matrix4.identity();
        transform.setEntry(3, 2, 0.001);
        transform.rotateY(animation.value);
        return Transform(
          transform: transform,
          alignment: Alignment.center,
          child: child,
        );
      },
      child: child,
    );
  }
}

class MaskedTextController extends TextEditingController {
  MaskedTextController(
      {super.text, required this.mask, Map<String, RegExp>? translator}) {
    this.translator = translator ?? MaskedTextController.getDefaultTranslator();

    addListener(() {
      final String previous = _lastUpdatedText;
      if (this.beforeChange(previous, this.text)) {
        updateText(this.text);
        this.afterChange(previous, this.text);
      } else {
        updateText(_lastUpdatedText);
      }
    });

    updateText(this.text);
  }

  String mask;

  Map<String, RegExp>? translator;

  Function afterChange = (String previous, String next) {};
  Function beforeChange = (String previous, String next) {
    return true;
  };

  String _lastUpdatedText = '';

  void updateText(String text) {
    if (text != null) {
      this.text = _applyMask(mask, text);
    } else {
      this.text = '';
    }

    _lastUpdatedText = this.text;
  }

  void updateMask(String mask, {bool moveCursorToEnd = true}) {
    this.mask = mask;
    updateText(text);

    if (moveCursorToEnd) {
      this.moveCursorToEnd();
    }
  }

  void moveCursorToEnd() {
    final String text = _lastUpdatedText;
    selection =
        TextSelection.fromPosition(TextPosition(offset: (text ?? '').length));
  }

  @override
  set text(String newText) {
    if (super.text != newText) {
      super.text = newText;
      moveCursorToEnd();
    }
  }

  static Map<String, RegExp> getDefaultTranslator() {
    return <String, RegExp>{
      'A': RegExp(r'[A-Za-z]'),
      '0': RegExp(r'[0-9]'),
      '@': RegExp(r'[A-Za-z0-9]'),
      '*': RegExp(r'.*')
    };
  }

  String _applyMask(String mask, String value) {
    String result = '';

    int maskCharIndex = 0;
    int valueCharIndex = 0;

    while (true) {
      // if mask is ended, break.
      if (maskCharIndex == mask.length) {
        break;
      }

      // if value is ended, break.
      if (valueCharIndex == value.length) {
        break;
      }

      final String maskChar = mask[maskCharIndex];
      final String valueChar = value[valueCharIndex];

      // value equals mask, just set
      if (maskChar == valueChar) {
        result += maskChar;
        valueCharIndex += 1;
        maskCharIndex += 1;
        continue;
      }

      // apply translator if match
      if (translator!.containsKey(maskChar)) {
        if (translator![maskChar]!.hasMatch(valueChar)) {
          result += valueChar;
          maskCharIndex += 1;
        }

        valueCharIndex += 1;
        continue;
      }

      // not masked value, fixed char on mask
      result += maskChar;
      maskCharIndex += 1;
      continue;
    }

    return result;
  }
}
