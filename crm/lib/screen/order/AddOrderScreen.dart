/*import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/screen/order/OrderViewModel.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/ZTextField.dart';
import 'package:zakazy_crm_v2/unit/Expensions.dart';
import 'package:zakazy_crm_v2/widget/order/CitySelectWidget.dart';

class AddOrderScreen extends StatelessWidget {
  final _viewModel = OrderViewModel.create();

  final _clientFirstName = ZTextField(hint: "Имя");

  final _clientLastName = ZTextField(hint: "Фамилия");

  final _clientMiddleName = ZTextField(hint: "Отчество");

  final _clientEmail = ZTextField(hint: "Email");

  final _clientPhone = ZTextField(hint: "Номер телефона");

  final _citySelectForm = CitySelectWidget();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Card(
          elevation: 12,
          child: Padding(
            padding: EdgeInsets.only(left: 24, right: 24, bottom: 48, top: 48),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Создать заказ",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Divider(
                  height: 40,
                ),
                _clientInfoBox(),
                Divider(
                  height: 30,
                ),
                Text(
                  "Город",
                  style: TextStyle(fontSize: 16),
                ),
                Divider(
                  height: 20,
                ),
                _citySelectForm,
                Divider(
                  height: 30,
                ),
                StreamBuilder(
                    stream: _viewModel.errorTxt,
                    builder: (context, snapShot) {
                      if (snapShot.hasData) {
                        return Text(
                          snapShot.data as String,
                          style: TextStyle(color: Colors.redAccent),
                        );
                      }

                      return Container();
                    }),
                Divider(
                  height: 30,
                ),
                SizedBox(
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyButton(
                        title: "Сохранить",
                        onPressed: () => _onSaveClick(),
                        isEnable: true,
                      ),
                      FreeButton(
                        title: "Отменить",
                        onPressed: () => _onCancelCLick(),
                        isEnable: true,
                      )
                    ],
                  ),
                )
              ],
            )),
          ),
        ));
  }

  _clientInfoBox() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Заказчик",
            style: TextStyle(fontSize: 16),
          ),
          Divider(
            height: 30,
          ),
          SizedBox(
            width: 300,
            child: _clientFirstName,
          ),
          Divider(
            height: 20,
          ),
          SizedBox(
            width: 300,
            child: _clientLastName,
          ),
          Divider(
            height: 20,
          ),
          SizedBox(
            width: 300,
            child: _clientMiddleName,
          ),
          Divider(
            height: 20,
          ),
          SizedBox(
            width: 300,
            child: _clientEmail,
          ),
          Divider(
            height: 20,
          ),
          SizedBox(
            width: 300,
            child: _clientPhone,
          ),
          Divider(
            height: 20,
          )
        ],
      );

  _onSaveClick() {
    bool isError = false;

    if (_clientFirstName.text().isEmpty) {
      isError = true;
      _clientFirstName.setError("Заполните поле");
    }

    if (_clientLastName.text().isEmpty) {
      isError = true;
      _clientLastName.setError("Заполните поле");
    }

    if (_clientMiddleName.text().isEmpty) {
      isError = true;
      _clientMiddleName.setError("Заполните поле");
    }

    if (!_clientEmail.text().isValidEmail()) {
      isError = true;
      _clientEmail.setError("Не вервий email");
    }

    if (_clientPhone.text().isEmpty) {
      isError = true;
      _clientPhone.setError("Заполните поле");
    } else if (_clientPhone.text().isNumeric()) {
      isError = true;
      _clientPhone.setError("Неверный номер телефона");
    }

    if (_citySelectForm.selectedCity() == null) {
      isError = true;
      _viewModel.errorTxt.add("Виберите город");
    } else {
      _viewModel.errorTxt.add(null);
    }
  }

  _onCancelCLick() {
    _viewModel.isNewCreate.add(false);
  }
}
*/