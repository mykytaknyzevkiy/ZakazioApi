import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/screen/register/card/RegisterCardWizard.dart';
import 'package:zakazy_crm_v2/unit/Expensions.dart';


// ignore: must_be_immutable
class RegisterPhoneCard extends RegisterCardWizard {
  RegisterPhoneCard(Function() toNextPage) : super(toNextPage);

  @override
  RegisterCardWizardState<RegisterCardWizard> myState() =>
      _RegisterPhoneCardState();
}

class _RegisterPhoneCardState
    extends RegisterCardWizardState<RegisterPhoneCard> {
  final _phoneNumberController = TextEditingController();

  String? mError;

  _RegisterPhoneCardState() {
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
  String description() => "Введите ваш email";

  _phoneNumberFiled() {
    return SizedBox(
      width: 300,
      child: TextFormField(
        inputFormatters: [
          //_formatter
        ],
        controller: _phoneNumberController,
        decoration: InputDecoration(
            icon: Icon(Icons.email),
            labelText: 'Email',
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

    if (!phoneNumber.isValidEmail()) {
      showError("Не верный email");
      return;
    }

    final isOk = await viewModel.registerStep1(phoneNumber);

    if (isOk)
      toNextPage();
    else
      showError("Этот email уже зарегистрирован");
  }
}
