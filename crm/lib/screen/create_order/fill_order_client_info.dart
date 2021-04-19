import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zakazy_crm_v2/model/user/RoleType.dart';
import 'package:zakazy_crm_v2/repository/UserRepository.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/create_order/create_order_main.dart';
import 'package:zakazy_crm_v2/screen/create_order/create_order_vm.dart';
import 'package:zakazy_crm_v2/unit/RussianPhoneNumberFormater.dart';
import 'package:zakazy_crm_v2/widget/ZTextField.dart';
import 'package:zakazy_crm_v2/unit/Expensions.dart';

class FillOrderClientInfo extends CreateOrderStateScreen {
  final _viewModel = ViewModelProvider<CreateOrderNewViewModel>()
      .build(() => CreateOrderNewViewModel());

  final _clientFirstName = ZTextField(hint: "Имя");

  final _clientLastName = ZTextField(hint: "Фамилия");

  final _clientMiddleName = ZTextField(hint: "Отчество");

  final _clientEmail = ZTextField(hint: "Email");

  final _clientPhone = ZTextField(hint: "Номер телефона", inputFormatters: [RussianPhoneNumberFormat()],);

  FillOrderClientInfo(Function() onNext)
      : super(CreateOrderState.INFORMATION, "Данные заказчика", onNext) {
    final myUser = UserRepository.instance().myUserLiveData.value!;

    if (myUser.roleInfo() == RoleType.CLIENT) {
      _clientFirstName.setText(myUser.firstName);
      _clientFirstName.setEnable(false);

      _clientLastName.setText(myUser.lastName);
      _clientLastName.setEnable(false);

      _clientMiddleName.setText(myUser.middleName);
      _clientMiddleName.setEnable(false);

      _clientPhone.setText(myUser.phoneNumber);
      _clientPhone.setEnable(false);

      _clientEmail.setText(myUser.email);
      _clientEmail.setEnable(false);
    } else {
      final lastData = _viewModel.orderClientData;

      if (lastData != null) {
        _clientFirstName.setText(lastData.firstName);
        _clientLastName.setText(lastData.lastName);
        _clientMiddleName.setText(lastData.middleName);
        _clientPhone.setText(lastData.phoneNumber);
        _clientEmail.setText(lastData.email);
      }
    }
  }

  bool check() {
    bool isOk = true;

    if (_clientFirstName.text().isEmpty) {
      isOk = false;
      _clientFirstName.setError("Заполните поле");
    }

    if (_clientLastName.text().isEmpty) {
      isOk = false;
      _clientLastName.setError("Заполните поле");
    }

    if (_clientMiddleName.text().isEmpty) {
      isOk = false;
      _clientMiddleName.setError("Заполните поле");
    }

    if (!_clientEmail.text().isValidEmail()) {
      isOk = false;
      _clientEmail.setError("Не верный email");
    }

    if (_clientPhone.text().isEmpty && !_clientPhone.text().isNumeric()) {
      isOk = false;
      _clientPhone.setError("Не верный номер телефона");
    }

    return isOk;
  }

  @override
  nextClick() {
    if (!check()) return;

    _viewModel.orderClientData = OrderClientData(
        firstName: _clientFirstName.text(),
        lastName: _clientLastName.text(),
        middleName: _clientMiddleName.text(),
        email: _clientEmail.text(),
        phoneNumber: _clientPhone.text());

    return super.nextClick();
  }

  @override
  Widget content(BuildContext context) => Wrap(
        spacing: 15,
        runSpacing: 15,
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
      );
}
