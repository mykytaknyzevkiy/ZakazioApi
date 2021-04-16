import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/model/user/UserInfoModel.dart';
import 'package:zakazy_crm_v2/screen/RightScreen.dart';
import 'package:zakazy_crm_v2/screen/profile/UserProfileViewModel.dart';
import 'package:zakazy_crm_v2/unit/RussianPhoneNumberFormater.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/ZTextField.dart';
import 'package:zakazy_crm_v2/unit/Expensions.dart';

class UserEditContactsScreen extends RightScreen {
  final UserProfileViewModel _viewModel;

  final UserInfoModel _user;

  final _clientEmail = ZTextField(hint: "Email");

  final _clientPhone = ZTextField(
      hint: "Номер телефона",
      inputFormatters: [
        RussianPhoneNumberFormat()
      ],
  );

  UserEditContactsScreen(this._user, this._viewModel) {
    _clientEmail.setText(_user.email);
    _clientPhone.setText(_user.phoneNumber);
  }

  @override
  Widget body(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Изменить контактные данные",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold)),
      Divider(
        color: Colors.transparent,
        height: 40,
      ),
      _clientEmail,
      Divider(
        height: 15,
        color: Colors.transparent,
      ),
      _clientPhone,
      Divider(
        height: 25,
        color: Colors.transparent,
      ),
      StreamBuilder(
        stream: _viewModel.isToEditDataLoading,
        builder: (_, snapShot) {
          if (snapShot.data == true) {
            return Center(
              child: CircularProgressIndicator()
            );
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyButton(
                  title: "Сохранить",
                  onPressed: () => _save(),
                  isEnable: true
              ),
              FreeButton(
                  title: "Отменить",
                  onPressed: () => _viewModel.toEditData.add(null),
                  isEnable: true
              )
            ],
          );
        }
      )
    ],
  );

  @override
  double width(BuildContext context) => 350;

  _save() async {
    final email = _clientEmail.text();
    final phoneNumber = _clientPhone.text();

    if (!email.isValidEmail()) {
      _clientEmail.setError("");
      return;
    }
    if (phoneNumber.isEmpty) {
      _clientPhone.setError("");
      return;
    }

    _viewModel.editUser(
        _user,
        _user.firstName,
        _user.lastName,
        _user.middleName,
        email,
        phoneNumber,
        null,
        null
    );
  }
}