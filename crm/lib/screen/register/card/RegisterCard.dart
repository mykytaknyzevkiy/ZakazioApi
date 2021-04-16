import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/screen/register/card/RegisterCardWizard.dart';
import 'package:zakazy_crm_v2/screen/register/card/RegisterInfoCard.dart';
import 'package:zakazy_crm_v2/screen/register/card/RegisterPhoneCard.dart';
import 'package:zakazy_crm_v2/screen/register/card/RegisterRoleCard.dart';
import 'package:zakazy_crm_v2/screen/register/card/RegisterSmsCard.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';

class RegisterCard extends StatefulWidget {
  final Function() onBack;

  const RegisterCard({required this.onBack});

  @override
  State<StatefulWidget> createState() => _RegisterCardState(onBack);
}

class _RegisterCardState extends State<RegisterCard> {
  bool _isLoading = false;

  final Function() onBack;

  final List<RegisterCardWizard> _cards = [];

  int _currentCardIndex = 0;

  _RegisterCardState(this.onBack) {
    _cards.add(RegisterRoleCard(_toNextPage));
    _cards.add(RegisterPhoneCard(_toNextPage));
    _cards.add(RegisterSmsCard(_toNextPage));
    _cards.add(RegisterInfoCard(_toNextPage));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Wrap(
          direction: Axis.vertical,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          runAlignment: WrapAlignment.center,
          children: [
            _title(),
            Divider(
              height: 20,
            ),
            _cards[_currentCardIndex],
            Divider(
              height: 30,
              color: Colors.transparent,
            ),
            Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 20,
              children: [
                _backBtn(),
                _nextBtn(),
              ],
            ),
          ],
        ));
  }

  _title() => Text("Регистрация",
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500));

  _nextBtn() {
    return (!_isLoading
        ? MyButton(
            title: _currentCardIndex == 3 ? "Открыть аккаунт" : "далее",
            onPressed: () {
              _onNext();
            },
            isEnable: !_isLoading,
            backgroundColor: primaryColor,
          )
        : Center(
            child: CircularProgressIndicator(),
          ));
  }

  _backBtn() {
    return FreeButton(
        title: _currentCardIndex == 0 ? "Уже есть аккаунт?" : "Назад",
        onPressed: () {
          _onBack();
        },
        isEnable: !_isLoading);
  }

  _onNext() async {
    setState(() {
      _isLoading = true;
    });
    await _cards[_currentCardIndex].onNext();
    setState(() {
      _isLoading = false;
    });
  }

  _onBack() {
    if (_currentCardIndex == 0) {
      onBack.call();
    } else {
      setState(() {
        _currentCardIndex--;
      });
    }
  }

  _toNextPage() {
    setState(() {
      _currentCardIndex++;
    });
  }
}
