import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zakazy_crm_v2/model/settings/SettingsContactsModel.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/settings/SettingsFullVM.dart';
import 'package:zakazy_crm_v2/unit/RussianPhoneNumberFormater.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/ZTextField.dart';

class SettingsEditContacts extends StatelessWidget {
  final _viewModel = ViewModelProvider<SettingsFullViewModel>()
      .build(() => SettingsFullViewModel());

  final _companyNameFiled = ZTextField(
      hint: "Название компании");

  final _phoneNumberFiled = ZTextField(
      inputFormatters: [
        RussianPhoneNumberFormat()
      ],
      hint: "Номер телефона");

  final _emailFiled = ZTextField(
      hint: "Email");

  final _facebookFiled = ZTextField(
      hint: "Facebook url");

  final _instagramFiled = ZTextField(
      hint: "Instagram url");

  final _twitterFiled = ZTextField(
      hint: "Whatsapp url");

  final _linkindinFiled = ZTextField(
      hint: "VK url");

  SettingsEditContacts() {
    final data = _viewModel.contacts.value!;

    _companyNameFiled.setText(data.companyName);
    _phoneNumberFiled.setText(data.phoneNumber);
    _emailFiled.setText(data.email);
    _facebookFiled.setText(data.facebook);
    _instagramFiled.setText(data.instagram);
    _twitterFiled.setText(data.twitter);
    _linkindinFiled.setText(data.linkedIn);
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Card(
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Изменить контакты",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Divider(
                    height: 40,
                    color: Colors.transparent,
                  ),
                  _companyNameFiled,
                  Divider(
                    height: 15,
                    color: Colors.transparent,
                  ),
                  _phoneNumberFiled,
                  Divider(
                    height: 15,
                    color: Colors.transparent,
                  ),
                  _emailFiled,
                  Divider(
                    height: 15,
                    color: Colors.transparent,
                  ),
                  _instagramFiled,
                  Divider(
                    height: 15,
                    color: Colors.transparent,
                  ),
                  _linkindinFiled,
                  Divider(
                    height: 15,
                    color: Colors.transparent,
                  ),
                  _twitterFiled,
                  Divider(
                    height: 25,
                    color: Colors.transparent,
                  ),
                  StreamBuilder(
                      stream: _viewModel.onExLoading,
                      builder: (_, snapShot) {
                        if (snapShot.data == true) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return btns();
                      })
                ],
              ),
            ),
          ),
        ),
      );

  btns() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyButton(
            title: "Сохранить",
            onPressed: () {
              if (_companyNameFiled.text().isEmpty) {
                _companyNameFiled.setError("");
                return;
              }
              if (_phoneNumberFiled.text().isEmpty) {
                _phoneNumberFiled.setError("");
                return;
              }
              if (_emailFiled.text().isEmpty) {
                _emailFiled.setError("");
                return;
              }
              if (_facebookFiled.text().isEmpty) {
                _facebookFiled.setError("");
                return;
              }
              if (_instagramFiled.text().isEmpty) {
                _instagramFiled.setError("");
                return;
              }
              if (_twitterFiled.text().isEmpty) {
                _twitterFiled.setError("");
                return;
              }
              if (_linkindinFiled.text().isEmpty) {
                _linkindinFiled.setError("");
                return;
              }

              _viewModel.editContacts(
                SettingsContactsModel(
                  _companyNameFiled.text(),
                  _phoneNumberFiled.text(),
                  _emailFiled.text(),
                  _facebookFiled.text(),
                  _instagramFiled.text(),
                  _twitterFiled.text(),
                  _linkindinFiled.text()
                )
              );
            },
            isEnable: true,
          ),
          FreeButton(
            title: "Отменить",
            onPressed: () => _viewModel.onEdit.add(null),
            isEnable: true,
          )
        ],
      );
}
