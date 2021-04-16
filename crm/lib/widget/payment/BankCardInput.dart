import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zakazy_crm_v2/conts.dart';

class BankCardInput extends StatelessWidget {

  final _reBuild = BehaviorSubject<int>.seeded(0);

  final _cardNumTxtController = TextEditingController();

  final _cardExpTxtController = TextEditingController();

  final _cardHolderNameTxtController = TextEditingController();

  final _cardCvvTxtController = TextEditingController();

  TextFormField _cardNumTxtField() => TextFormField(
    controller: _cardNumTxtController,
    keyboardType: TextInputType.number,
    inputFormatters: [
      WhitelistingTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(16),
      CardNumberInputFormatter()
    ],
    decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Номер карты",
        hintText: "Введите номер карты",
        errorText: isCardNumError ? "" : null
    ),
    maxLines: 1,
  );

  TextFormField _cardExpTxtField() => TextFormField(
    controller: _cardExpTxtController,
    keyboardType: TextInputType.number,
    inputFormatters: [
      WhitelistingTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(4),
      CardExpInputFormatter()
    ],
    decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Срок действие",
        hintText: "mm/yy",
        errorText: isCardExpError ? "" : null
    ),
    maxLines: 1,
  );

  TextFormField _cardHolderNameTxtField() => TextFormField(
    controller: _cardHolderNameTxtController,
    decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Имя держателя карты",
        hintText: "Имя и фамилия",
        errorText: isCardNameError ? "" : null
    ),
    maxLines: 1,
  );

  TextFormField _cardCvvTxtField() => TextFormField(
    controller: _cardCvvTxtController,
    keyboardType: TextInputType.number,
    inputFormatters: [
      WhitelistingTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(139)
    ],
    decoration: InputDecoration(
        border: OutlineInputBorder(),
        fillColor: accentColor,
        labelText: "Cvv",
        hintText: "***",
        errorText: isCardCvvError ? "" : null
    ),
    maxLines: 1,
  );

  bool isCardNumError = false;
  bool isCardExpError = false;
  bool isCardNameError = false;
  bool isCardCvvError = false;

  BankCardInput() {
    _cardNumTxtController.addListener(() {
      if (isCardNumError) {
        isCardNumError = false;
        _reBuild.add(1);
      }
    });

    _cardExpTxtController.addListener(() {
      if (isCardExpError) {
        isCardExpError = false;
        _reBuild.add(1);
      }
    });

    _cardHolderNameTxtController.addListener(() {
      if (isCardNameError) {
        isCardNameError = false;
        _reBuild.add(1);
      }
    });

    _cardCvvTxtController.addListener(() {
      if (isCardCvvError) {
        isCardCvvError = false;
        _reBuild.add(1);
      }
    });
  }

  @override
  Widget build(BuildContext context) => StreamBuilder(
    stream: _reBuild,
    builder: (context, snapShot) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _cardNumTxtField(),
        Divider(
          height: 15,
          color: Colors.transparent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 100,
              child: _cardExpTxtField(),
            ),
            SizedBox(
              width: 100,
              child: _cardCvvTxtField(),
            ),
          ],
        ),
        Divider(
          height: 15,
          color: Colors.transparent,
        ),
        _cardHolderNameTxtField()
      ],
    )
  );

  bool check() {
    bool isOK = true;

    if (_cardNumTxtController.text.replaceAll(" ", "").length != 16) {
      isCardNumError = true;
      isOK = false;
    }

    if (_cardExpTxtController.text.length != 5) {
      isCardExpError = true;
      isOK = false;
    }

    if (_cardHolderNameTxtController.text.isEmpty) {
      isCardNameError = true;
      isOK = false;
    }

    if (_cardCvvTxtController.text.length != 3) {
      isCardCvvError = true;
      isOK = false;
    }

    if (!isOK)
      _reBuild.add(1);

    return isOK;
  }

  String cardNum() => _cardNumTxtController.text.replaceAll(" ", "");

  String cardExpMonth() => _cardExpTxtController.text.split("/").first;

  String cardExpYear() => _cardExpTxtController.text.split("/").last;

  String cardCvv() => _cardCvvTxtController.text;

  String cardName() => _cardHolderNameTxtController.text;

  _close() {
    _reBuild.close();
  }

}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(' '); // Add double spaces.
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}

class CardExpInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != text.length) {
        buffer.write('/'); // Add double spaces.
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}