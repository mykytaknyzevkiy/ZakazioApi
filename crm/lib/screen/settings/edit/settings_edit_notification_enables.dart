import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:zakazy_crm_v2/screen/HomeScreen.dart';
import 'package:zakazy_crm_v2/screen/settings/SettingsFullVM.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';

class SettingsEditNotificationEnables extends StatelessWidget {
  final _viewModel = ViewModelProvider<SettingsFullViewModel>()
      .build(() => SettingsFullViewModel());

  late _Switcher createOrder;
  late _Switcher youExecutorOrder;
  late _Switcher clientOrderInWork;

  SettingsEditNotificationEnables() {
    final data = _viewModel.notificationEnable.value!;

    createOrder = _Switcher(
        title: "Создан заказ с вашим учатьем",
        email: data.key.createOrder,
        sms: data.value.createOrder);

    youExecutorOrder = _Switcher(
        title: "Стал/Назначили исполнителем",
        email: data.key.onExecutorInOrder,
        sms: data.value.onExecutorInOrder);

    clientOrderInWork = _Switcher(
        title: "Изменился статус заказа",
        email: data.key.onOrderStatus,
        sms: data.value.onOrderStatus);
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Card(
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Изменить уведомителя",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Divider(
                    height: 40,
                    color: Colors.transparent,
                  ),
                  createOrder,
                  Divider(
                    height: 35,
                    color: Colors.transparent,
                  ),
                  youExecutorOrder,
                  Divider(
                    height: 35,
                    color: Colors.transparent,
                  ),
                  clientOrderInWork,
                  Divider(
                    height: 40,
                    color: Colors.transparent,
                  ),
                  StreamBuilder(
                      stream: _viewModel.onExLoading,
                      builder: (_, snapShot) {
                        if (snapShot.data == true) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return btns();
                      })
                ],
              ),
            ),
          ),
        ),
      );

  btns() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyButton(
            title: "Сохранить",
            onPressed: () {
              final data = _viewModel.notificationEnable.value!;

              data.key.createOrder = createOrder.email;
              data.value.createOrder = createOrder.sms;

              data.key.onOrderStatus = clientOrderInWork.email;
              data.value.onOrderStatus = clientOrderInWork.sms;

              data.key.onExecutorInOrder = youExecutorOrder.email;
              data.value.onExecutorInOrder = youExecutorOrder.sms;

              _viewModel.editNotificationEnable(data);
            },
            isEnable: true,
          ),
          FreeButton(
            title: "Отменить",
            onPressed: () => _viewModel.onEdit.add(null),
            isEnable: true,
          )
        ],
      );
}

class _Switcher extends StatelessWidget {
  final reBuild = BehaviorSubject.seeded(1);

  final String title;
  bool email;
  bool sms;

  _Switcher({required this.title, required this.email, required this.sms});

  @override
  Widget build(BuildContext context) => StreamBuilder(
      stream: reBuild,
      builder: (_, __) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18),
              ),
              Divider(
                height: 10,
                color: Colors.transparent,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [_emailSwitcher(), _smsSwitcher()],
              )
            ],
          ));

  _emailSwitcher() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Email"),
          Divider(
            height: 5,
            color: Colors.transparent,
          ),
          Switch(
              value: email,
              onChanged: (v) {
                email = v;
                reBuild.add(2);
              })
        ],
      );

  _smsSwitcher() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Смс"),
          Divider(
            height: 5,
            color: Colors.transparent,
          ),
          Switch(
              value: sms,
              onChanged: (v) {
                sms = v;
                reBuild.add(2);
              })
        ],
      );

  close() {
    reBuild.close();
  }
}
