import 'package:flutter/material.dart';
import 'package:zakazy_crm_v2/model/order/OrderStatus.dart';
import 'package:zakazy_crm_v2/model/user/RoleType.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isNumeric() {
    return double.tryParse(this) != null;
  }
}

extension RoleTypeEx on RoleType {
  String name() {
    switch (this) {
      case RoleType.CLIENT:
        return "Заказчик";
      case RoleType.PARTNER:
        return "Партнер";
      case RoleType.EXECUTOR:
        return "Исполнитель";
      case RoleType.EDITOR:
        return "Модератор";
      case RoleType.ADMIN:
        return "Админ";
      case RoleType.SUPER_ADMIN:
        return "Супер адммин";
    }
  }
}

RoleType findRoleType(String role) {
  if (role == "CLIENT")
    return RoleType.CLIENT;
  else if (role == "PARTNER")
    return RoleType.PARTNER;
  else if (role == "EXECUTOR")
    return RoleType.EXECUTOR;
  else if (role == "EDITOR")
    return RoleType.EDITOR;
  else if (role == "ADMIN")
    return RoleType.ADMIN;
  else
    return RoleType.SUPER_ADMIN;
}

OrderStatus findStatus(String status) {
  if (status == "PROCESS")
    return OrderStatus.PROCESS;
  else if (status == "IN_WORK")
    return OrderStatus.IN_WORK;
  else if (status == "DONE")
    return OrderStatus.DONE;
  else
    return OrderStatus.CANCEL;
}

extension OrderStatusEx on OrderStatus {
  String name() {
    switch (this) {
      case OrderStatus.PROCESS:
        return "В обработке";
      case OrderStatus.IN_WORK:
        return "Выполняется";
      case OrderStatus.DONE:
        return "Завершено";
      case OrderStatus.CANCEL:
        return "Отменен";
    }
  }

  Color color() {
    switch (this) {
      case OrderStatus.PROCESS:
        return Colors.grey;
      case OrderStatus.IN_WORK:
        return Colors.orangeAccent;
      case OrderStatus.DONE:
        return Colors.green[800]!;
      case OrderStatus.CANCEL:
        return Colors.red;
    }
  }

  String toZString() {
    if (this == OrderStatus.PROCESS)
      return "PROCESS";
    else if (this == OrderStatus.IN_WORK)
      return "IN_WORK";
    else if (this == OrderStatus.DONE)
      return "DONE";
    else
      return "CANCEL";
  }
}
