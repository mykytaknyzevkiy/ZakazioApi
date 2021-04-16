import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/conts.dart';
import 'package:zakazy_crm_v2/model/app/AppModel.dart';
import 'package:zakazy_crm_v2/model/user/RoleType.dart';
import 'package:zakazy_crm_v2/model/user/UserInfoModel.dart';
import 'package:zakazy_crm_v2/repository/UserRepository.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/app/info/AppInfoViewModel.dart';
import 'package:zakazy_crm_v2/screen/profile/widget/UserInfoCard.dart';
import 'package:zakazy_crm_v2/screens.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';
import 'package:zakazy_crm_v2/widget/order/AdaptiveOrderList.dart';
import 'dart:js' as js;

class AppInfoScreen extends StatefulWidget {
  final int appID;

  const AppInfoScreen({Key? key, required this.appID}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppInfoScreen(appID);
}

class _AppInfoScreen extends HomeScreen<AppInfoScreen, AppInfoViewModel> {
  final int appID;

  late AppInfoViewModel _viewModel = viewModel();

  _AppInfoScreen(this.appID);

  @override
  void initState() {
    _viewModel.load(appID);
    _viewModel.loadOrders(appID, 0);
    super.initState();
  }

  @override
  Widget body() => MediaQuery.of(context).size.width > phoneSize
  ? _desktop()
  : _mobile();

  _desktop() => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      StreamBuilder<AppModel>(
          stream: _viewModel.info,
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              _deleteBtn.setEnable(snapShot.requireData.owner?.id ==
                  UserRepository.instance().myUserLiveData.value?.id ||
                  [RoleType.SUPER_ADMIN, RoleType.ADMIN, RoleType.EDITOR]
                      .contains(UserRepository.instance()
                      .myUserLiveData
                      .value
                      ?.roleInfo()));
              return _infoBox(snapShot.requireData);
            }

            return Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                ));
          }),
      Flexible(
        child: Card(
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Заказы",
                  style: TextStyle(fontSize: 18),
                ),
                Divider(
                  height: 20,
                  color: Colors.transparent,
                ),
                AdaptiveOrderList(
                    stream: _viewModel.orderList,
                    onLoad: (pageNum) =>
                        _viewModel.loadOrders(appID, pageNum))
              ],
            ),
          ),
        ),
      )
    ],
  );

  _mobile() => Column(
    children: [
      StreamBuilder<AppModel>(
          stream: _viewModel.info,
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              _deleteBtn.setEnable(snapShot.requireData.owner?.id ==
                  UserRepository.instance().myUserLiveData.value?.id ||
                  [RoleType.SUPER_ADMIN, RoleType.ADMIN, RoleType.EDITOR]
                      .contains(UserRepository.instance()
                      .myUserLiveData
                      .value
                      ?.roleInfo()));
              return _infoBox(snapShot.requireData);
            }

            return Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                ));
          }),
      Divider(
        height: 25,
        color: Colors.transparent,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Заказы",
            style: TextStyle(fontSize: 18),
          ),
          Divider(
            height: 20,
            color: Colors.transparent,
          ),
          AdaptiveOrderList(
              stream: _viewModel.orderList,
              onLoad: (pageNum) =>
                  _viewModel.loadOrders(appID, pageNum))
        ],
      )
    ],
  );

  late MyButton _deleteBtn = MyButton(
    title: "Удалить",
    backgroundColor: Colors.redAccent,
    onPressed: () async {
      await viewModel().delete(appID);
      ZakazioNavigator.push(context, "app/list");
    },
    isEnable: false,
  );

  @override
  Widget top() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Приложение № $appID",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 36),
          ),
          Divider(
            height: 15,
            color: Colors.transparent,
          ),
          _deleteBtn,
          Divider(
            height: 15,
            color: Colors.transparent,
          ),
          MyButton(
              title: "Документация",
              onPressed: () {
                js.context.callMethod(
                    'open', ['https://zakazy.developerhub.io/zakazy']);
              },
              isEnable: true)
        ],
      );

  _infoBox(AppModel appModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyButton(
              title: "скопировать ключ",
              onPressed: () {
                js.context.callMethod("copy", [appModel.key]);
              },
              isEnable: true),
          Divider(
            height: 15,
            color: Colors.transparent,
          ),
          UserInfoCard(appModel.owner!, null, "Владелец"),
          Divider(
            height: 15,
            color: Colors.transparent,
          ),
          Card(
            elevation: 4,
            child: Container(
              constraints: BoxConstraints(minWidth: 300),
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Информация",
                      style: TextStyle(fontSize: 18),
                    ),
                    Divider(
                      height: 20,
                      color: Colors.transparent,
                    ),
                    dataInfoField("Название", appModel.name),
                    Divider(
                      height: 10,
                      color: Colors.transparent,
                    ),
                    dataInfoField("Открытые заказы",
                        appModel.order.count.open.toString()),
                    Divider(
                      height: 10,
                      color: Colors.transparent,
                    ),
                    dataInfoField("Завершенные заказы",
                        appModel.order.count.close.toString()),
                    Divider(
                      height: 10,
                      color: Colors.transparent,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      );

  @override
  AppInfoViewModel viewModelInstancer() => AppInfoViewModel();
}
