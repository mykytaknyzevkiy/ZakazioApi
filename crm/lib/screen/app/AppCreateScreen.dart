import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/app/AppListViewModel.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/ZTextField.dart';

class AppCreateScreen extends StatelessWidget {
  final _viewModel = ViewModelProvider<AppListViewModel>()
      .build(() => AppListViewModel());

  final _nameTxtField = ZTextField(hint: "Название");

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
              Text("Создать приложение",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Divider(
                color: Colors.transparent,
                height: 20,
              ),
              _nameTxtField,
              Divider(
                height: 30,
              ),
              StreamBuilder(
                stream: _viewModel.isExLoading,
                builder: (context, snapShot) {
                  if (snapShot.data == true)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyButton(
                        title: "Создать",
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
                },
              )
            ]
        ),
      ),
    ),
  );

  _onSaveClick() async {

    if (_nameTxtField.text().isEmpty) {
      _nameTxtField.setError("Заполните поле");
      return;
    }

    await _viewModel.add(_nameTxtField.text());

    _viewModel.isToAddApp.add(false);
  }

  _onCancelCLick() {
    _viewModel.isToAddApp.add(false);
  }

}