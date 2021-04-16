import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/model/user/RoleType.dart';
import 'package:zakazy_crm_v2/notificattion_service.dart';
import 'package:zakazy_crm_v2/repository/UserRepository.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/import/ImportViewModel.dart';
import 'package:zakazy_crm_v2/screens.dart';
import 'package:zakazy_crm_v2/unit/FileSelect.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/payment/OrderTransactionList.dart';

class ImportScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ImportScreen();
}

class _ImportScreen extends HomeScreen<ImportScreen, ImportViewModel> {
  late ImportViewModel _viewModel = ImportViewModel();

  @override
  Widget body() => StreamBuilder<MapEntry<bool, String?>>(
      stream: _viewModel.isLoading,
      builder: (context, snapShot) {
        if (snapShot.hasData && snapShot.requireData.key == true) {
          if (snapShot.requireData.value == null) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Ожидайте загрузки",
                    style: TextStyle(fontSize: 24),
                  ),
                  Divider(
                    height: 20,
                    color: Colors.transparent,
                  ),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(),
                  ),
                ]);
          } else {
            return StreamBuilder<ImportOrderProcessModel>(
                stream: NotoficationService()
                    .subcribeImportOrder(snapShot.requireData.value!),
                builder: (_, snapShot) {
                  if (!snapShot.hasData)
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Ожидайте загрузки",
                            style: TextStyle(fontSize: 24),
                          ),
                          Divider(
                            height: 20,
                            color: Colors.transparent,
                          ),
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(),
                          ),
                        ]);

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      snapShot.requireData.process < snapShot.requireData.max
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  Text(
                                    "Идет обработка",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  Divider(
                                    height: 10,
                                    color: Colors.transparent,
                                  ),
                                  Text(
                                      "Вы можете закрыть страницу, импорт продолжиться и результат придет вам на почту"),
                                  Divider(
                                    height: 20,
                                    color: Colors.transparent,
                                  ),
                                  SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: CircularProgressIndicator(),
                                  ),
                                  Divider(
                                    height: 25,
                                    color: Colors.transparent,
                                  ),
                                  Text(
                                      "${snapShot.requireData.process} из ${snapShot.requireData.max}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18))
                                ])
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  Text("Готово",
                                      style: TextStyle(fontSize: 24)),
                                  Divider(
                                      height: 10, color: Colors.transparent),
                                  MyButton(
                                      title: "Закрыть",
                                      onPressed: () =>
                                          _viewModel.isLoading.add(null),
                                      isEnable: true)
                                ]),
                      Divider(height: 25, color: Colors.transparent),
                      Text("Ошибки"),
                      Card(
                          elevation: 4,
                          child: SizedBox(
                              width: double.infinity,
                              child: DataTable(
                                  columns: [
                                    BaseColumn("Индекс"),
                                    BaseColumn("Ошибка")
                                  ],
                                  rows: snapShot.requireData.brokers
                                      .map((e) => DataRow(cells: [
                                            BaseCell(e.index.toString()),
                                            BaseCell(e.reason)
                                          ]))
                                      .toList()))),
                    ],
                  );
                });
          }
        }

        return Wrap(
          spacing: 25,
          runSpacing: 25,
          children: [
            MyButton(
                title: "Заказы",
                onPressed: () async {
                  final file = await FileSelect.selectFile();
                  if (file != null) {
                    await _viewModel.importOrder(file);
                    // ZakazioNavigator.push(context, "order/all");
                  }
                },
                isEnable: true),
            MyButton(
                title: "Категории",
                onPressed: () async {
                  final file = await FileSelect.selectFile();
                  if (file != null) {
                    await _viewModel.importCategories(file);
                    ZakazioNavigator.push(context, "category");
                  }
                },
                isEnable: UserRepository.instance().myUserLiveData.value?.roleInfo() == RoleType.SUPER_ADMIN),
            MyButton(
                title: "Адреса",
                onPressed: () async {
                  final file = await FileSelect.selectFile();
                  if (file != null) {
                    await _viewModel.importAddress(file);
                    ZakazioNavigator.push(context, "region/list");
                  }
                },
                isEnable: UserRepository.instance().myUserLiveData.value?.roleInfo() == RoleType.SUPER_ADMIN),
            MyButton(
                title: "Заказчики",
                onPressed: () async {
                  final file = await FileSelect.selectFile();
                  if (file != null) {
                    await _viewModel.importUser(file, RoleType.CLIENT);
                    ZakazioNavigator.push(context, "user/client/partner");
                  }
                },
                isEnable: UserRepository.instance().myUserLiveData.value?.roleInfo() == RoleType.SUPER_ADMIN),
            MyButton(
                title: "Исполнители",
                onPressed: () async {
                  final file = await FileSelect.selectFile();
                  if (file != null) {
                    await _viewModel.importUser(file, RoleType.EXECUTOR);
                    ZakazioNavigator.push(context, "user/executo/partner");
                  }
                },
                isEnable: UserRepository.instance().myUserLiveData.value?.roleInfo() == RoleType.SUPER_ADMIN),
            MyButton(
                title: "Партнеры",
                onPressed: () async {
                  final file = await FileSelect.selectFile();
                  if (file != null) {
                    await _viewModel.importUser(file, RoleType.PARTNER);
                    ZakazioNavigator.push(context, "user/editor/partner");
                  }
                },
                isEnable: UserRepository.instance().myUserLiveData.value?.roleInfo() == RoleType.SUPER_ADMIN)
          ],
        );
      });

  @override
  Widget top() {
    return Wrap(
      children: [
        Text(
          "Импорт",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 36),
        )
      ],
    );
  }

  @override
  ImportViewModel viewModelInstancer() => ImportViewModel();
}
