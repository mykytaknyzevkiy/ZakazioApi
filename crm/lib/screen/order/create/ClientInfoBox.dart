import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/widget/ZTextField.dart';
import 'package:zakazy_crm_v2/unit/Expensions.dart';

// ignore: must_be_immutable
class ClientInfoBox extends StatefulWidget {
  _ClientInfoBoxState? _state;

  @override
  State<StatefulWidget> createState() {
    _state = _ClientInfoBoxState();

    return _state!;
  }

  bool check() {
    if (_state == null) return false;

    return _state!.check();
  }

  clientFirstName() => _state?.clientFirstName();

  clientLastName() => _state?.clientLastName();

  clientMiddleName() => _state?.clientMiddleName();

  clientEmail() => _state?.clientEmail();

  clientPhone() => _state?.clientPhone();
}

class _ClientInfoBoxState extends State<ClientInfoBox> {
  final _clientFirstName = ZTextField(hint: "Имя");

  final _clientLastName = ZTextField(hint: "Фамилия");

  final _clientMiddleName = ZTextField(hint: "Отчество");

  final _clientEmail = ZTextField(hint: "Email");

  final _clientPhone = ZTextField(hint: "Номер телефона");

  @override
  Widget build(BuildContext context) => Card(
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Заполните данные заказчика",
                style: TextStyle(fontSize: 16),
              ),
              Divider(
                height: 30,
                color: Colors.transparent,
              ),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  SizedBox(
                    width: 300,
                    child: _clientFirstName,
                  ),
                  SizedBox(
                    width: 300,
                    child: _clientLastName,
                  ),
                  SizedBox(
                    width: 300,
                    child: _clientMiddleName,
                  ),
                  SizedBox(
                    width: 300,
                    child: _clientEmail,
                  ),
                  SizedBox(width: 300, child: _clientPhone),
                ],
              )
            ],
          ),
        ),
      );

  clientFirstName() => _clientFirstName.text();

  clientLastName() => _clientLastName.text();

  clientMiddleName() => _clientMiddleName.text();

  clientEmail() => _clientEmail.text();

  clientPhone() => _clientPhone.text();

  bool check() {
    bool isOk = true;

    if (_clientFirstName.text().isEmpty) {
      isOk = false;
      setState(() {
        _clientFirstName.setError("Заполните поле");
      });
    }

    if (_clientLastName.text().isEmpty) {
      isOk = false;
      setState(() {
        _clientLastName.setError("Заполните поле");
      });
    }

    if (_clientMiddleName.text().isEmpty) {
      isOk = false;
      setState(() {
        _clientMiddleName.setError("Заполните поле");
      });
    }

    if (!_clientEmail.text().isValidEmail()) {
      isOk = false;
      setState(() {
        _clientEmail.setError("Не верный email");
      });
    }

    if (_clientPhone.text().isEmpty && !_clientPhone.text().isNumeric()) {
      isOk = false;
      setState(() {
        _clientPhone.setError("Не верный номер телефона");
      });
    }

    return isOk;
  }
}
