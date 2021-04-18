import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/model/user/RoleType.dart';
import 'package:zakazy_crm_v2/model/user/UserInfoModel.dart';
import 'package:zakazy_crm_v2/model/user/executor/ExecutorModel.dart';
import 'package:zakazy_crm_v2/model/user/partner/PartnerModel.dart';
import 'package:zakazy_crm_v2/repository/UserRepository.dart';
import 'package:zakazy_crm_v2/screens.dart';
import 'package:zakazy_crm_v2/widget/MaterialButton.dart';

class UserAlertDangeral extends StatelessWidget {
  final _userRepository = UserRepository.instance();

  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return StreamBuilder<UserInfoModel>(
        stream: _userRepository.myUserLiveData,
        builder: (context, snapShot) {
          if (!snapShot.hasData) return Container();
          final user = snapShot.requireData;

          Widget alert;

          if (user.roleInfo() == RoleType.EXECUTOR)
            alert = executorAlert(user as ExecutorModel);
          else if (user.roleInfo() == RoleType.PARTNER)
            alert = partnerAlert(user as PartnerModel);
          else
            alert = Container();

          return Card(elevation: 12, color: Colors.red, child: alert);
        });
  }

  Widget executorAlert(ExecutorModel executorModel) {
    if (executorModel.order.enable) return Container();

    String toDoText = "";
    int toDoIndex = 1;

    if (!executorModel.emailActive) {
      toDoText += "$toDoIndex) ";
      toDoText += "Подтвердить Email";
      toDoText += "\n";

      toDoIndex++;
    }

    /*if (!executorModel.phoneActive) {
      toDoText += "$toDoIndex) ";
      toDoText += "Подтвердить номер телефона";
      toDoText += "\n";

      toDoIndex++;
    }*/

    if (executorModel.city == null) {
      toDoText += "$toDoIndex) ";
      toDoText += "Выбрать адрес работы";
      toDoText += "\n";

      toDoIndex++;
    }

    if (!executorModel.passportActive && !executorModel.passportInProgress) {
      toDoText += "$toDoIndex) ";
      toDoText += "Подтвердить паспортные данные";
      toDoText += "\n";

      toDoIndex++;
    } else if (executorModel.passportInProgress) {
      toDoText += "$toDoIndex) ";
      toDoText += "Ожидайте проверку вашего паспорта";
      toDoText += "\n";

      toDoIndex++;
    }

    if (executorModel.order.count.open >= executorModel.order.count.max) {
      toDoText += "$toDoIndex) ";
      toDoText += "Завершить работу над открытыми заказами";
      toDoText += "\n";

      toDoIndex++;
    }

    if (executorModel.portfolioCount == 0) {
      toDoText += "$toDoIndex) ";
      toDoText += "Создать портфолио";
      toDoText += "\n";

      toDoIndex++;
    }

    if (executorModel.isBlocked()) {
      toDoText += "$toDoIndex) ";
      toDoText += "Ваш аккаунт заблокирован, обратитесь за помошью";
      toDoText += "\n";

      toDoIndex++;
    }

    return Padding(
        padding: const EdgeInsets.all(24),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  executorModel.order.count.open >=
                          executorModel.order.count.max
                      ? "У вас нет разрешения на получение новых заказов"
                      : "У вас нет разрешения для работы над заказами",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              Divider(
                height: 15,
                color: Colors.transparent,
              ),
              Text("Для получения разрешения вам необходимо:",
                  style: TextStyle(color: Colors.white, fontSize: 12)),
              Divider(
                height: 5,
                color: Colors.transparent,
              ),
              Text(toDoText,
                  style: TextStyle(color: Colors.white, fontSize: 12))
            ],
          ),
        ));
  }

  Widget partnerAlert(PartnerModel executorModel) {
    if (executorModel.order.enable) return Container();

    String toDoText = "";
    int toDoIndex = 1;

    if (!executorModel.emailActive) {
      toDoText += "$toDoIndex) ";
      toDoText += "Подтвердить Email";
      toDoText += "\n";

      toDoIndex++;
    }

    /*if (!executorModel.phoneActive) {
      toDoText += "$toDoIndex) ";
      toDoText += "Подтвердить номер телефона";
      toDoText += "\n";

      toDoIndex++;
    }*/

    if (executorModel.city == null) {
      toDoText += "$toDoIndex) ";
      toDoText += "Выбрать адрес работы";
      toDoText += "\n";

      toDoIndex++;
    }

    if (!executorModel.passportActive && !executorModel.passportInProgress) {
      toDoText += "$toDoIndex) ";
      toDoText += "Подтвердить паспортные данные";
      toDoText += "\n";

      toDoIndex++;
    } else if (executorModel.passportInProgress) {
      toDoText += "$toDoIndex) ";
      toDoText += "Ожидайте проверку вашего паспорта";
      toDoText += "\n";

      toDoIndex++;
    }

    if (executorModel.order.count.open >= executorModel.order.count.max) {
      toDoText += "$toDoIndex) ";
      toDoText += "Завершить работу над открытыми заказами";
      toDoText += "\n";

      toDoIndex++;
    }

    return Padding(
        padding: const EdgeInsets.all(24),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  executorModel.order.count.open >=
                          executorModel.order.count.max
                      ? "У вас нет разрешения на получение новых заказов"
                      : "У вас нет разрешения для работы над заказами",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              Divider(
                height: 15,
                color: Colors.transparent,
              ),
              Text("Для получения разрешения вам необходимо:",
                  style: TextStyle(color: Colors.white, fontSize: 12)),
              Divider(
                height: 5,
                color: Colors.transparent,
              ),
              Text(toDoText,
                  style: TextStyle(color: Colors.white, fontSize: 12))
            ],
          ),
        ));
  }
}
