import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/model/address/CityModel.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/address/city/CityViewModel.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/ZTextField.dart';
import 'package:zakazy_crm_v2/unit/Expensions.dart';

// ignore: must_be_immutable
class AddCityScreen extends StatelessWidget {
  final CityViewModel _viewModel = ViewModelProvider<CityViewModel>().build(() => CityViewModel());

  late ZTextField _nameTxt;
  late ZTextField _zipCodeTxt;

  final CityModel regionModel;
  final int regionID;

  AddCityScreen(this.regionID, this.regionModel) {
    _nameTxt = ZTextField(hint: "Имя", txt: regionModel.name);
    _zipCodeTxt = ZTextField(
        hint: "Индекс",
        txt: regionModel.code >= 0 ? regionModel.code.toString() : '');
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
                Text(regionModel.id >= 0 ? "Изменить город" : "Добавіть город",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Divider(
                  height: 40,
                ),
                SizedBox(width: 300, child: _nameTxt),
                Divider(
                  height: 30,
                ),
                SizedBox(width: 300, child: _zipCodeTxt),
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
            ),
          ),
        ),
      ),
    );
  }

  _onSaveClick() {
    bool isError = false;

    if (_nameTxt.text().isEmpty) {
      isError = true;
      _nameTxt.setError("Заполните поле");
    }

    if (_zipCodeTxt.text().isEmpty) {
      isError = true;
      _zipCodeTxt.setError("Заполните поле");
    }

    if (!_zipCodeTxt.text().isNumeric()) {
      isError = true;
      _zipCodeTxt.setError("Неверний формат");
    }

    if (isError) return;

    if (regionModel.id >= 0) {
      _viewModel.edit(regionModel.id, regionID, _nameTxt.text(),
          int.parse(_zipCodeTxt.text()));
    } else {
      _viewModel.add(regionID, _nameTxt.text(), int.parse(_zipCodeTxt.text()));
    }
  }

  _onCancelCLick() {
    _viewModel.hasAddEdit.add(null);
  }
}
