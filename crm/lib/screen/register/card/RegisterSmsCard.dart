import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/screen/register/card/RegisterCardWizard.dart';

// ignore: must_be_immutable
class RegisterSmsCard extends RegisterCardWizard {
  RegisterSmsCard(Function() toNextPage) : super(toNextPage);

  @override
  RegisterCardWizardState<RegisterCardWizard> myState() => _RegisterSmsCard();
}

class _RegisterSmsCard extends RegisterCardWizardState<RegisterSmsCard> {
  final _phoneNumberController = TextEditingController();

  String? mError;

  _RegisterSmsCard() {
    _phoneNumberController.addListener(() {
      setState(() {
        mError = null;
      });
    });
  }

  @override
  List<Widget> body() {
    return [_phoneNumberFiled()];
  }

  @override
  String description() =>
      "На вашу почту\nотправлено письмо\nс кодом подтверждения";

  _phoneNumberFiled() {
    return SizedBox(
      width: 300,
      child: TextFormField(
        inputFormatters: [
          //_formatter
        ],
        controller: _phoneNumberController,
        decoration: InputDecoration(
            icon: Icon(Icons.code),
            labelText: 'Код',
            border: OutlineInputBorder(),
            errorText: mError),
      ),
    );
  }

  String _inputPhoneNumber() => _phoneNumberController.text;

  showError(String error) {
    setState(() {
      mError = error;
    });
  }

  @override
  Future onNext() async {
    final phoneNumber = _inputPhoneNumber();

    if (phoneNumber.isEmpty) {
      showError("Заполните поле");
      return;
    }

    final isOk = await viewModel.registerStep2(phoneNumber);

    if (isOk)
      toNextPage();
    else
      showError("Не вервый код");
  }
}
