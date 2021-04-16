import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/repository/UserRepository.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/profile/my/MyProfileViewModel.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/ZTextField.dart';

class ActiveMyEmailScreen extends StatelessWidget {
  final MyProfileViewModel _viewModel = ViewModelProvider<MyProfileViewModel>()
      .build(() => MyProfileViewModel());

  final _smsCode = ZTextField(hint: "Код");

  final String token;

  ActiveMyEmailScreen(this.token);

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
              Text("Подтвердить Email",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Divider(
                color: Colors.transparent,
                height: 20,
              ),
              Text("На ваш Email отправлено письмо с кодом для подтверждения"),
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
                              title: "Подтвердить",
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
    final data = await _viewModel.verificateEmail(token, _smsCode.text());
    if (!data) {
      _smsCode.setError("Не верный код");
    }
  }

  _onCancelCLick() {
    _viewModel.toEditData.add(null);
  }
}
