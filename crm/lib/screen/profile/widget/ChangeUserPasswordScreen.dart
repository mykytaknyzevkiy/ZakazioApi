import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/model/user/UserInfoModel.dart';
import 'package:zakazy_crm_v2/screen/profile/UserProfileViewModel.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/ZTextField.dart';

class ChangeUserPasswordScreen extends StatelessWidget {

  final UserProfileViewModel viewModel;

  final UserInfoModel user;

  ChangeUserPasswordScreen(this.user, this.viewModel);

  final _smsCode = ZTextField(hint: "Пароль");

  @override
  Widget build(BuildContext context) => SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Card(
        elevation: 12,
        child: Padding(
          padding: EdgeInsets.only(left: 24, right: 24, bottom: 48, top: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Изменить пароль",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Divider(
                color: Colors.transparent,
                height: 30,
              ),
              _smsCode,
              Divider(
                height: 30,
              ),
              SizedBox(
                  width: 300,
                  child: StreamBuilder(
                    stream: viewModel.isToEditDataLoading,
                    builder: (context, snapShot) {
                      if (snapShot.hasData && snapShot.requireData == true) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MyButton(
                              title: "Изменить",
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
          ),
        ),
      ));

  _onSaveClick() async {
    if (_smsCode.text().isEmpty) {
      _smsCode.setError("Заполните поле");
      return;
    }

    final data = await viewModel.changePasspord(
        user: user, newPasspord: _smsCode.text());
    if (!data) {
      _smsCode.setError("Это пароль запрешен");
    }
  }

  _onCancelCLick() {
    viewModel.toEditData.add(null);
  }
}
