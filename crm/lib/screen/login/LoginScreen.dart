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
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(color: cardBackgroundColor),
      child: (MediaQuery.of(context).size.width > 800)
          ? Row(
              children: [
                _leftSide(),
                Padding(
                  padding: EdgeInsets.all(24),
                  child: _rightSide(),
                )
              ],
            )
          : Container(
              decoration: backgroundImage(context),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
                child: Center(
                  child: SingleChildScrollView(
                    child: Card(
                        elevation: 12,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: _rightSide()),
                  ),
                ),
              ),
            ),
    ));
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
