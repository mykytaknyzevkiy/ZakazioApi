import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/screen/register/card/RegisterCard.dart';
import 'package:zakazy_crm_v2/screen/splash/SplashBanner.dart';
import 'package:zakazy_crm_v2/widget/LoginCard.dart';

enum _LoginWizard { LOGIN, REGISTER }

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  _LoginWizard _currentWizard = _LoginWizard.LOGIN;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _rightSide()
      ),
    );
  }

  _leftSide() => Expanded(
        flex: 5,
        child: SplashBanner(),
      );

  _rightSide() {
    StatefulWidget widget;

    switch (_currentWizard) {
      case _LoginWizard.LOGIN:
        widget = LoginCard(
            onRegister: () => {
                  setState(() {
                    _currentWizard = _LoginWizard.REGISTER;
                  })
                },
            onForgotPassword: () => {});
        break;
      case _LoginWizard.REGISTER:
        widget = RegisterCard(
          onBack: () => {
            setState(() {
              _currentWizard = _LoginWizard.LOGIN;
            })
          },
        );
        break;
    }

    return SizedBox(
      width: 380,
      child: widget,
    );
  }
}
