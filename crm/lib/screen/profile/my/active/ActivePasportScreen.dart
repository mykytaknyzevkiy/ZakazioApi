import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/repository/UserRepository.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/profile/my/MyProfileViewModel.dart';
import 'package:zakazy_crm_v2/widget/ImageSelectWidget.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/ZDateField.dart';
import 'package:zakazy_crm_v2/widget/ZTextField.dart';

class ActivePasportScreen extends StatelessWidget {
  final MyProfileViewModel _viewModel = ViewModelProvider<MyProfileViewModel>()
      .build(() => MyProfileViewModel());

  final _serial = ZTextField(hint: "Серия");
  final _number = ZTextField(hint: "Номер");
  final _dateEx = ZDateField(hint: "Дата окончания");
  final _taxID = ZTextField(hint: "ИНН");
  final _firstPasportPage = ImageSelectWidget(size: 300);
  final _secoundPasportPage = ImageSelectWidget(size: 300);
  final _facePasportPage = ImageSelectWidget(size: 300);

  @override
  Widget build(BuildContext context) => SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Card(
          elevation: 12,
          child: Padding(
            padding: EdgeInsets.only(left: 24, right: 24, bottom: 48, top: 48),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Загрузить паспорт",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Divider(
                    color: Colors.transparent,
                    height: 40,
                  ),
                  _serial,
                  Divider(
                    height: 30,
                    color: Colors.transparent,
                  ),
                  _number,
                  Divider(
                    height: 30,
                    color: Colors.transparent,
                  ),
                  _dateEx,
                  Divider(
                    height: 30,
                    color: Colors.transparent,
                  ),
                  _taxID,
                  Divider(
                    height: 30,
                    color: Colors.transparent,
                  ),
                  Text(
                    "Первая страница паспорта",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  Divider(
                    height: 10,
                    color: Colors.transparent,
                  ),
                  _firstPasportPage,
                  Divider(
                    height: 30,
                    color: Colors.transparent,
                  ),
                  Text(
                    "Вторая страница паспорта",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  Divider(
                    height: 10,
                    color: Colors.transparent,
                  ),
                  _secoundPasportPage,
                  Divider(
                    height: 30,
                    color: Colors.transparent,
                  ),
                  Text(
                    "Возьмите паспорт в руки . Откройте на первой странице и сфотографируйтесь так, чтобы было видно вас и открытый паспорт с 1 и 2 страницей",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  Divider(
                    height: 10,
                    color: Colors.transparent,
                  ),
                  _facePasportPage,
                  Divider(
                    height: 30,
                    color: Colors.transparent,
                  ),
                  StreamBuilder<String>(
                      stream: _viewModel.toEditDataError,
                      builder: (context, snapShot) {
                        if (snapShot.hasData) {
                          return Text(snapShot.requireData,
                              style: TextStyle(color: Colors.redAccent));
                        }
                        return Container();
                      }),
                  Divider(
                    height: 15,
                    color: Colors.transparent,
                  ),
                  SizedBox(
                      width: 300,
                      child: StreamBuilder(
                        stream: _viewModel.isToEditDataLoading,
                        builder: (context, snapShot) {
                          if (snapShot.hasData &&
                              snapShot.requireData == true) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                MyButton(
                                  title: "Отправить",
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
          ),
        ),
      );

  _onSaveClick() async {
    bool isOk = true;

    if (_serial.text().isEmpty) {
      isOk = false;
      _serial.setError("Заполните поле");
    }

    if (_number.text().isEmpty) {
      isOk = false;
      _number.setError("Заполните поле");
    }

    if (_dateEx.dateTxt() == null) {
      isOk = false;
      _dateEx.setError("Выберите дату");
    }

    if (_taxID.text().isEmpty) {
      isOk = false;
      _taxID.setError("Заполните поле");
    }

    if (_firstPasportPage.image() == null) {
      isOk = false;
      _viewModel.toEditDataError.add("Загрузить скан первой страница паспорта");
    } else if (_secoundPasportPage.image() == null) {
      isOk = false;
      _viewModel.toEditDataError.add("Загрузить скан второй страница паспорта");
    } else if (_facePasportPage.image() == null) {
      isOk = false;
      _viewModel.toEditDataError.add("Загрузить ваше фото с паспортом");
    }

    if (isOk) {
      _viewModel.sendPasportInfo(
          _serial.text(),
          _number.text(),
          _dateEx.dateTxt()!,
          _taxID.text(),
          _firstPasportPage.image()!,
          _secoundPasportPage.image()!,
          _facePasportPage.image()!);
    }
  }

  _onCancelCLick() {
    _viewModel.toEditData.add(null);
  }
}
