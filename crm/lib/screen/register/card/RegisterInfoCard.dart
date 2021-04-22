import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zakazy_crm_v2/repository/UserRepository.dart';
import 'package:zakazy_crm_v2/screen/register/card/RegisterCardWizard.dart';
import 'package:zakazy_crm_v2/screens.dart';
import 'package:zakazy_crm_v2/unit/Expensions.dart';
import 'package:zakazy_crm_v2/unit/RussianPhoneNumberFormater.dart';

// ignore: must_be_immutable
class RegisterInfoCard extends RegisterCardWizard {
  RegisterInfoCard(Function() toNextPage) : super(toNextPage);

  @override
  RegisterCardWizardState<RegisterCardWizard> myState() =>
      _RegisterInfoCardState();
}

class _RegisterInfoCardState extends RegisterCardWizardState<RegisterInfoCard> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isFirstNameEmpty = false;
  bool isLastNameEmpty = false;
  bool isMiddleNameEmpty = false;
  bool isEmailWrong = false;
  bool isEmailError = false;
  bool isPasswordEmpty = false;

  _RegisterInfoCardState() {
    _firstNameController.addListener(() {
      setState(() {
        isFirstNameEmpty = false;
      });
    });

    _lastNameController.addListener(() {
      setState(() {
        isLastNameEmpty = false;
      });
    });

    _middleNameController.addListener(() {
      setState(() {
        isMiddleNameEmpty = false;
      });
    });

    _emailController.addListener(() {
      setState(() {
        isEmailWrong = false;
        isEmailError = false;
      });
    });

    _passwordController.addListener(() {
      setState(() {
        isPasswordEmpty = false;
      });
    });
  }

  @override
  List<Widget> body() {
    return [
      SizedBox(
        width: 300,
        child: TextFormField(
            controller: _firstNameController,
            decoration: InputDecoration(
                icon: Icon(Icons.account_circle),
                labelText: 'Имя',
                border: OutlineInputBorder(),
                errorText: isFirstNameEmpty ? "Заполните поле" : null)),
      ),
      Divider(
        height: 30,
      ),
      SizedBox(
        width: 300,
        child: TextFormField(
            controller: _lastNameController,
            decoration: InputDecoration(
                icon: Icon(Icons.account_circle),
                labelText: 'Фамилия',
                border: OutlineInputBorder(),
                errorText: isLastNameEmpty ? "Заполните поле" : null)),
      ),
      Divider(
        height: 30,
      ),
      SizedBox(
        width: 300,
        child: TextFormField(
            controller: _middleNameController,
            decoration: InputDecoration(
                icon: Icon(Icons.account_circle),
                labelText: 'Отчество',
                border: OutlineInputBorder(),
                errorText: isMiddleNameEmpty ? "Заполните поле" : null)),
      ),
      Divider(
        height: 30,
      ),
      SizedBox(
        width: 300,
        child: TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              RussianPhoneNumberFormat(),
              WhitelistingTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
                icon: Icon(Icons.phone),
                labelText: 'Номер телефона',
                border: OutlineInputBorder(),
                errorText: isEmailWrong
                    ? "Не действительный номер телефона"
                    : isEmailError
                        ? "Этот номер телефона уже зарегистрирован"
                        : null)),
      ),
      Divider(
        height: 30,
      ),
      SizedBox(
        width: 300,
        child: TextFormField(
            obscureText: true,
            controller: _passwordController,
            decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: 'Пароль',
                border: OutlineInputBorder(),
                errorText: isPasswordEmpty ? "Заполните поле" : null)),
      )
    ];
  }

  @override
  String description() => "Создайте аккаунт";

  @override
  Future onNext() async {
    setState(() {
      if (_firstNameController.text.isEmpty) {
        isFirstNameEmpty = true;
      }

      if (_lastNameController.text.isEmpty) {
        isLastNameEmpty = true;
      }

      if (_middleNameController.text.isEmpty) {
        isMiddleNameEmpty = true;
      }

      if (_emailController.text.isEmpty) {
        isEmailWrong = true;
      }

      if (_passwordController.text.isEmpty) {
        isPasswordEmpty = true;
      }
    });

    if (isFirstNameEmpty ||
        isLastNameEmpty ||
        isMiddleNameEmpty ||
        isEmailWrong ||
        isPasswordEmpty) {
      return;
    }

    final isOK = await viewModel.registerStep3(
        _firstNameController.text,
        _lastNameController.text,
        _middleNameController.text,
        _emailController.text,
        _passwordController.text);

    if (isOK) {
      UserRepository.instance().initUser();
    } else {
      setState(() {
        isEmailError = true;
      });
    }
  }
}
