import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/model/user/UserInfoModel.dart';
import 'package:zakazy_crm_v2/screen/profile/UserProfileViewModel.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/ZTextField.dart';
import 'package:zakazy_crm_v2/unit/Expensions.dart';
import 'package:zakazy_crm_v2/widget/order/CitySelectWidget.dart';
import 'package:zakazy_crm_v2/widget/user/ChangeUserAvatar.dart';

// ignore: must_be_immutable
class UserEditInfoScreen extends StatelessWidget {
  final UserProfileViewModel _viewModel;

  final UserInfoModel _user;

  final _clientFirstName = ZTextField(hint: "Имя");

  final _clientLastName = ZTextField(hint: "Фамилия");

  final _clientMiddleName = ZTextField(hint: "Отчество");

  final _cityInfoBox = CitySelectWidget(hasCard: false, hasPading: false);

  late ChangeUserAvatar _userAvatar;

  UserEditInfoScreen(this._user, this._viewModel) {
    _clientFirstName.setText(_user.firstName);

    _clientLastName.setText(_user.lastName);

    _clientMiddleName.setText(_user.middleName);

    _userAvatar = ChangeUserAvatar(currentAvatar: _user.avatar, size: 120);
  }

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
                Text("Изменить информацию",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Divider(
                  color: Colors.transparent,
                  height: 40,
                ),
                _userAvatar,
                Divider(
                  color: Colors.transparent,
                  height: 30,
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
                _cityInfoBox,
                Divider(
                  height: 30,
                ),
                SizedBox(
                    width: 300,
                    child: StreamBuilder(
                      stream: _viewModel.isToEditDataLoading,
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

    if (isError) {
      return;
    }

    _viewModel.editUser(
        _user,
        _clientFirstName.text(),
        _clientLastName.text(),
        _clientMiddleName.text(),
        _user.email,
        _user.phoneNumber,
        _cityInfoBox.selectedCity(),
        _userAvatar.selectedImage());
  }

  _onCancelCLick() {
    _viewModel.toEditData.add(null);
  }
}
