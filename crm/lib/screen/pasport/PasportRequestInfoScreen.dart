// ignore: import_of_legacy_library_into_null_safe
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/pasport/PasportModel.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/pasport/PasportRequestViewModel.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/user/UserAvater.dart';
import 'package:zakazy_crm_v2/unit/Expensions.dart';
import 'dart:html' as html;

class PasportRequestInfoScreen extends StatelessWidget {
  final PasportModel _pasportModel;

  final _viewModel = ViewModelProvider<PasportRequestViewModel>().build(() => PasportRequestViewModel());

  PasportRequestInfoScreen(this._pasportModel);

  @override
  Widget build(BuildContext context) => Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserAvatar(user: _pasportModel.user!, size: 125),
              Divider(
                height: 10,
                color: Colors.transparent,
              ),
              Text(
                "${_pasportModel.user!.firstName} ${_pasportModel.user!.lastName}\n${_pasportModel.user!.middleName}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Divider(
                height: 10,
                color: Colors.transparent,
              ),
              Text(_pasportModel.user!.roleInfo().name(),
                  style: TextStyle(fontSize: 16)),
              Divider(
                height: 40,
                color: Colors.transparent,
              ),
              generateDataText(
                  "Регион",
                  (_pasportModel.user!.city == null)
                      ? "Не выбран"
                      : _pasportModel.user!.city!.region!.name),
              generateDataText(
                  "Город",
                  (_pasportModel.user!.city == null)
                      ? "Не выбран"
                      : _pasportModel.user!.city!.name),
              generateDataText("Серия", _pasportModel.serial),
              generateDataText("Номер", _pasportModel.number),
              generateDataText("Дата выдачи", _pasportModel.dateBegin),
              generateDataText("ИНН", _pasportModel.taxID),
              Text(
                "Скан",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              Divider(
                height: 5,
                color: Colors.transparent,
              ),
              files(),
              Divider(
                height: 30,
                color: Colors.transparent,
              ),
              StreamBuilder(
                stream: _viewModel.onExtrLoading,
                builder: (context, snapShot) {
                  if (snapShot.hasData && snapShot.requireData == true) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return buttons();
                },
              ),
              Divider(
                height: 30,
                color: Colors.transparent,
              )
            ],
          ),
        ),
      )
  );

  generateDataText(String label, String data) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          Divider(
            height: 5,
            color: Colors.transparent,
          ),
          Text(
            data,
            style: TextStyle(fontSize: 16),
          ),
          Divider(
            height: 15,
            color: Colors.transparent,
          )
        ],
      );

  buttons() => Wrap(
        alignment: WrapAlignment.spaceBetween,
        spacing: 15,
        runSpacing: 15,
        children: [
          MyButton(
              title: "Одобрить",
              onPressed: () => {_viewModel.accept(_pasportModel.id)},
              isEnable: true),
          MyButton(
              title: "Отказать",
              onPressed: () => {_viewModel.refuse(_pasportModel.id)},
              isEnable: true,
              backgroundColor: Colors.redAccent),
          FreeButton(
              title: "Отменить",
              onPressed: () => {_viewModel.onViewInfo.add(null)},
              isEnable: true)
        ],
      );

  files() => Wrap(
    alignment: WrapAlignment.spaceBetween,
    children: List.generate(
        _pasportModel.files.length,
            (index) => Card(
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(0),
            child: SizedBox(
              width: 100,
              height: 100,
              child: Stack(
                children: [
                  Center(
                    child: Icon(Icons.file_present, size: 50),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        icon: Icon(Icons.open_in_new),
                        onPressed: () {
                          html.AnchorElement anchorElement = html.AnchorElement();
                          anchorElement.href = fileUrl(_pasportModel.files[index]);
                          anchorElement.download = _pasportModel.files[index];
                          anchorElement.click();
                        }),
                  )
                ],
              ),
            ),
          ),
        )
    ),
  );
}
