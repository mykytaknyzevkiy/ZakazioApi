import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zakazy_crm_v2/model/user/RoleType.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/ZTextField.dart';
import 'package:zakazy_crm_v2/unit/Expensions.dart';
import 'package:zakazy_crm_v2/widget/user/createUser/CreateUserViewModel.dart';

class CreateUserScreen extends StatelessWidget {
  final _viewModel = CreateUserViewModel();

  final RoleType roleType;
  final Function() onClose;

  final _clientFirstName = ZTextField(hint: "Имя");

  final _clientLastName = ZTextField(hint: "Фамилия");

  final _clientMiddleName = ZTextField(hint: "Отчество");

  final _clientEmail = ZTextField(hint: "Email");

  final _clientPhone = ZTextField(hint: "Номер телефона");

  final _clientPassword = ZTextField(hint: "Пароль");

  CreateUserScreen({required this.roleType, required this.onClose});

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
                Text("Доsбавить ${roleType.name()}",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Divider(
                  height: 40,
                ),
                SizedBox(
                  width: 300,
                  child: _clientFirstName,
                ),
                Divider(
                  height: 30,
                ),
                SizedBox(
                  width: 300,
                  child: _clientLastName,
                ),
                Divider(
                  height: 30,
                ),
                SizedBox(
                  width: 300,
                  child: _clientMiddleName,
                ),
                Divider(
                  height: 30,
                ),
                SizedBox(
                  width: 300,
                  child: _clientEmail,
                ),
                Divider(
                  height: 30,
                ),
                SizedBox(
                  width: 300,
                  child: _clientPhone,
                ),
                Divider(
                  height: 30,
                ),
                SizedBox(
                  width: 300,
                  child: _clientPassword,
                ),
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
                    child: StreamBuilder(
                      stream: _viewModel.isLoading,
                      builder: (context, snapShot) {
                        if (snapShot.hasData && snapShot.requireData == true) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return Row(
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
                          );
                        }
                      },
                    ))
              ],
            )),
          ),
        ));
  }

  _onSaveClick() async {
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
      _clientEmail.setError("Неверный email");
    }

    if (_clientPhone.text().isEmpty) {
      isError = true;
      _clientPhone.setError("Заполните поле");
    } else if (!_clientPhone.text().isNumeric()) {
      isError = true;
      _clientPhone.setError("Неверный номер телефона");
    }

    if (_clientPassword.text().isEmpty) {
      isError = true;
      _clientPassword.setError("Заполните поле");
    }

    if (isError) {
      return;
    }

    final data = await _viewModel.save(
        roleType,
        _clientFirstName.text(),
        _clientLastName.text(),
        _clientMiddleName.text(),
        _clientEmail.text(),
        _clientPassword.text(),
        _clientPhone.text());

    if (data) {
      onClose.call();
    }
  }

  _onCancelCLick() {
    onClose.call();
  }
}
